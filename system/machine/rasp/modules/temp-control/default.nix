{pkgs, ...}: {
  environment.systemPackages =
    (with pkgs; [
      python312
    ])
    ++ (with pkgs.python312Packages; [
      rpi-gpio
    ]);

  systemd.services.temp-control = {
    enable = true;
    description = "RPI temp control";

    after = [
      "network.target"
    ];

    wantedBy = [
      "network.target"
    ];

    serviceConfig = {
      Type = "simple";
      User = "root";
      Group = "root";

      WorkingDirectory = "/etc/temp-control/";
      ExecStart = "${pkgs.python312}/bin/python /etc/temp-control/temp-control.py";
      Restart = "always";
      RestartSec = "5";
    };
  };

  environment.etc = {
    "temp-control/temp-control.py" = {
      user = "root";
      group = "root";
      mode = "0770";

      text = ''
        #!${pkgs.python312}/bin/python
        # -*- coding: utf-8 -*-
        import sys, traceback, subprocess

        from time import sleep
        from re import findall


        def get_temp() -> float:
            temp = subprocess.check_output(["${pkgs.libraspberrypi}/bin/vcgencmd", "measure_temp"]).decode()
            temp = float(findall('\d+\.\d+', temp)[0])

            return(temp)


        def main() -> int:
            try:
                tempOn = 75
                controlPin = 512 + 14
                pinState = False
                try:
                    subprocess.run(f"echo {controlPin} > /sys/class/gpio/export", shell=True, check=True)
                except:
                    pass
                subprocess.run(f"echo out > /sys/class/gpio/gpio{controlPin}/direction", shell=True, check=True)
                subprocess.run(f"echo 0 > /sys/class/gpio/gpio{controlPin}/value", shell=True, check=True)

                while True:
                    temp = get_temp()

                    if temp > tempOn and not pinState or temp < tempOn - 10 and pinState:
                        pinState = not pinState
                        subprocess.run(f"echo {str(int(pinState))} > /sys/class/gpio/gpio{controlPin}/value", shell=True, check=True)

                    print(str(temp) + "  " + str(pinState))
                    sleep(1)

            except KeyboardInterrupt:
                print("Exit pressed Ctrl+C")

                return (0)
            except:
                print("Other Exception")
                print("--- Start Exception Data:")
                traceback.print_exc(limit=2, file=sys.stdout)
                print("--- End Exception Data:")

                return (1)
            finally:
                print("CleanUp")
                # GPIO.cleanup()
                print("End of program")

                return (0)

            return (0)

        if __name__ == "__main__":
            sys.exit(main())
      '';
    };
  };
}
