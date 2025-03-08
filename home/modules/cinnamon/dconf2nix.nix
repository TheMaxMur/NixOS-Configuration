# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{
  lib,
  username,
  ...
}:
with lib.hm.gvariant; {
  dconf.settings = {
    "org/cinnamon" = {
      alttab-minimized-aware = true;
      alttab-switcher-delay = 0;
      alttab-switcher-enforce-primary-monitor = false;
      alttab-switcher-show-all-workspaces = false;
      alttab-switcher-style = "icons+thumbnails";
      app-menu-label = "";
      command-history = ["r"];
      desklet-snap-interval = 25;
      desktop-effects-close = "fly";
      desktop-effects-close-effect = "traditional";
      desktop-effects-close-time = 120;
      desktop-effects-close-transition = "easeOutQuad";
      desktop-effects-map = "move";
      desktop-effects-map-effect = "traditional";
      desktop-effects-map-time = 100;
      desktop-effects-map-transition = "easeOutQuad";
      desktop-effects-maximize-effect = "none";
      desktop-effects-maximize-time = 100;
      desktop-effects-maximize-transition = "easeInExpo";
      desktop-effects-minimize = "fade";
      desktop-effects-minimize-effect = "traditional";
      desktop-effects-minimize-time = 160;
      desktop-effects-minimize-transition = "easeInQuad";
      desktop-effects-tile-effect = "none";
      desktop-effects-tile-time = 100;
      desktop-effects-tile-transition = "easeInQuad";
      desktop-effects-unmaximize-effect = "none";
      desktop-effects-unmaximize-time = 100;
      desktop-effects-unmaximize-transition = "easeNone";
      device-aliases = ["/org/freedesktop/UPower/devices/battery_BAT0:=Laptop"];
      enabled-applets = [
        "panel1:left:0:menu@cinnamon.org:30"
        "panel1:right:9:notifications@cinnamon.org:35"
        "panel1:right:11:network@cinnamon.org:40"
        "panel1:right:12:sound@cinnamon.org:41"
        "panel1:right:13:power@cinnamon.org:42"
        "panel1:right:15:calendar@cinnamon.org:43"
        "panel1:right:14:weather@mockturtl:95"
        "panel1:left:1:workspace-switcher@cinnamon.org:116"
        "panel1:center:1:window-list@cinnamon.org:121"
        "panel1:right:5:keyboard@cinnamon.org:128"
        "panel1:right:6:systray@cinnamon.org:130"
        "panel1:right:8:xapp-status@cinnamon.org:133"
        "panel4:left:0:menu@cinnamon.org:138"
        "panel4:left:1:workspace-switcher@cinnamon.org:139"
        "panel4:center:1:window-list@cinnamon.org:140"
        "panel4:right:5:weather@mockturtl:141"
        "panel4:right:3:keyboard@cinnamon.org:142"
        "panel4:right:6:calendar@cinnamon.org:144"
        "panel4:right:4:workspace-name@willurd:152"
        "panel4:center:2:spacer@cinnamon.org:154"
        "panel1:center:2:spacer@cinnamon.org:155"
        "panel4:center:0:spacer@cinnamon.org:156"
        "panel1:center:0:spacer@cinnamon.org:157"
      ];
      enabled-desklets = [];
      enabled-extensions = ["horizontal-osd@berk-karaal"];
      favorite-apps = [
        "google-chrome.desktop"
        "cinnamon-settings.desktop"
        "ulauncher.desktop"
        "org.gnome.Terminal.desktop"
      ];
      hotcorner-layout = [
        "expo:false:0"
        "desktop:false:0"
        "scale:false:0"
        "desktop:false:0"
      ];
      next-applet-id = 158;
      next-desklet-id = 13;
      no-adjacent-panel-barriers = false;
      panel-edit-mode = false;
      panel-launchers = ["DEPRECATED"];
      panel-zone-icon-sizes = "[{\"panelId\": 1, \"left\": 0, \"center\": 0, \"right\": 24}, {\"left\": 0, \"center\": 0, \"right\": 0, \"panelId\": 4}, {\"left\": 0, \"center\": 0, \"right\": 24, \"panelId\": 2}]";
      panel-zone-symbolic-icon-sizes = "[{\"panelId\": 1, \"left\": 28, \"center\": 28, \"right\": 16}, {\"left\": 28, \"center\": 28, \"right\": 16, \"panelId\": 4}, {\"left\": 28, \"center\": 28, \"right\": 16, \"panelId\": 2}]";
      panel-zone-text-sizes = "[{\"panelId\":1,\"left\":0,\"center\":0,\"right\":0},{\"left\":0,\"center\":0,\"right\":0,\"panelId\":4},{\"left\":0,\"center\":0,\"right\":0,\"panelId\":2}]";
      panels-autohide = [
        "1:false"
        "2:false"
        "3:true"
        "4:false"
      ];
      panels-enabled = [
        "1:0:top"
        "4:1:top"
        "4:1:top"
        "2:2:top"
      ];
      panels-height = [
        "1:27"
        "2:27"
        "3:30"
        "4:27"
      ];
      panels-hide-delay = [
        "1:0"
        "2:0"
        "3:0"
        "4:0"
      ];
      panels-show-delay = [
        "1:0"
        "2:0"
        "3:0"
        "4:0"
      ];
      show-media-keys-osd = "medium";
      window-effect-speed = 1;
      workspace-expo-view-as-grid = true;
      workspace-osd-visible = false;
    };

    "org/cinnamon/cinnamon-session" = {
      auto-save-session = true;
      quit-time-delay = 60;
      suspend-then-hibernate = true;
    };

    "org/cinnamon/desktop/a11y/applications" = {
      screen-keyboard-enabled = true;
    };

    "org/cinnamon/desktop/a11y/keyboard" = {
      bouncekeys-delay = 300;
      mousekeys-accel-time = 300;
      mousekeys-init-delay = 300;
      mousekeys-max-speed = 10;
      slowkeys-delay = 300;
    };

    "org/cinnamon/desktop/a11y/mouse" = {
      dwell-threshold = 10;
      dwell-time = 1.2;
      secondary-click-time = 1.2;
    };

    "org/cinnamon/desktop/applications/calculator" = {
      exec = "gnome-calculator";
    };

    "org/cinnamon/desktop/applications/terminal" = {
      exec = "alacritty";
      exec-arg = "--";
    };

    "org/cinnamon/desktop/background" = {
      picture-options = "zoom";
      picture-uri = "file:///home/${username}/Pictures/wallpapers/grey_gradient.png";
    };

    "org/cinnamon/desktop/background/slideshow" = {
      delay = 15;
      image-source = "directory:///home/${username}/Pictures/wallpapers";
    };

    "org/cinnamon/desktop/interface" = {
      clock-show-date = true;
      clock-show-seconds = false;
      cursor-blink-time = 1200;
      cursor-size = 24;
      cursor-theme = "Vimix-cursors";
      first-day-of-week = 1;
      font-name = "JetBrainsMono Nerd Font 10";
      gtk-theme = "Orchis-Dark-Compact";
      icon-theme = "Tela-circle-dark";
      keyboard-layout-prefer-variant-names = false;
      keyboard-layout-show-flags = false;
      keyboard-layout-use-upper = true;
      scaling-factor = mkUint32 0;
      text-scaling-factor = 1.0;
      toolkit-accessibility = true;
    };

    "org/cinnamon/desktop/keybindings" = {
      custom-list = [
        "__dummy__"
        "custom2"
        "custom3"
        "custom0"
      ];
      looking-glass-keybinding = [];
    };

    "org/cinnamon/desktop/keybindings/custom-keybindings/custom0" = {
      binding = ["<Super>Tab"];
      command = "gnome-terminal";
      name = "mouse button 10";
    };

    "org/cinnamon/desktop/keybindings/custom-keybindings/custom2" = {
      binding = ["Print"];
      command = "flameshot gui";
      name = "screenshot";
    };

    "org/cinnamon/desktop/keybindings/custom-keybindings/custom3" = {
      binding = [];
      command = "flameshot gui";
      name = "screen-shot";
    };

    "org/cinnamon/desktop/keybindings/media-keys" = {
      area-screenshot-clip = ["<Primary><Shift>Print"];
      screensaver = [
        "<Super>l"
        "XF86ScreenSaver"
        "<Super>Cyrillic_de"
      ];
      screenshot = [];
      terminal = ["<Super>Return"];
    };

    "org/cinnamon/desktop/keybindings/wm" = {
      close = ["<Primary>q"];
      minimize = ["<Super>m"];
      move-to-workspace-1 = [
        "<Primary><Super>1"
        "<Shift><Super>exclam"
      ];
      move-to-workspace-10 = [
        "<Primary><Super>0"
        "<Shift><Super>parenright"
      ];
      move-to-workspace-11 = [
        "<Shift><Super>underscore"
        "<Primary><Super>minus"
      ];
      move-to-workspace-12 = [
        "<Shift><Super>plus"
        "<Primary><Super>equal"
      ];
      move-to-workspace-2 = [
        "<Primary><Super>2"
        "<Shift><Super>at"
      ];
      move-to-workspace-3 = [
        "<Primary><Super>3"
        "<Shift><Super>numbersign"
      ];
      move-to-workspace-4 = [
        "<Primary><Super>4"
        "<Shift><Super>dollar"
      ];
      move-to-workspace-5 = [
        "<Primary><Super>5"
        "<Shift><Super>percent"
      ];
      move-to-workspace-6 = [
        "<Primary><Super>6"
        "<Shift><Super>asciicircum"
      ];
      move-to-workspace-7 = [
        "<Primary><Super>7"
        "<Shift><Super>ampersand"
      ];
      move-to-workspace-8 = [
        "<Primary><Super>8"
        "<Shift><Super>asterisk"
      ];
      move-to-workspace-9 = [
        "<Primary><Super>9"
        "<Shift><Super>parenleft"
      ];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-10 = ["<Super>0"];
      switch-to-workspace-11 = ["<Super>minus"];
      switch-to-workspace-12 = ["<Super>equal"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
      switch-to-workspace-up = [
        "<Control><Alt>Up"
        "<Alt>F1"
        "<Super>w"
      ];
      toggle-fullscreen = ["<Shift><Super>f"];
      toggle-maximized = ["<Super>f"];
    };

    "org/cinnamon/desktop/media-handling" = {
      autorun-never = false;
    };

    "org/cinnamon/desktop/notifications" = {
      bottom-notifications = true;
      notification-duration = 4;
      remove-old = false;
    };

    "org/cinnamon/desktop/peripherals/keyboard" = {
      delay = mkUint32 500;
      numlock-state = true;
      repeat-interval = mkUint32 30;
    };

    "org/cinnamon/desktop/peripherals/mouse" = {
      double-click = 400;
      drag-threshold = 8;
      speed = 0.0;
    };

    "org/cinnamon/desktop/peripherals/touchpad" = {
      disable-while-typing = true;
      speed = 0.0;
      tap-to-click = true;
    };

    "org/cinnamon/desktop/screensaver" = {
      allow-media-control = false;
      ask-for-away-message = false;
      custom-screensaver-command = "";
      default-message = "nbox";
      floating-widgets = true;
      font-date = "JetBrainsMono Nerd Font Bold 18";
      font-message = "JetBrainsMono Nerd Font Bold 12";
      font-time = "JetBrainsMono Nerd Font Medium 64";
      layout-group = 0;
      lock-delay = mkUint32 600;
      lock-enabled = true;
      show-album-art = false;
      time-format = "%H:%M:%S";
      use-custom-format = true;
    };

    "org/cinnamon/desktop/session" = {
      idle-delay = mkUint32 300;
    };

    "org/cinnamon/desktop/sound" = {
      event-sounds = false;
      maximum-volume = 150;
      volume-sound-enabled = false;
    };

    "org/cinnamon/desktop/wm/preferences" = {
      action-middle-click-titlebar = "none";
      button-layout = ":minimize,maximize,close";
      focus-mode = "click";
      min-window-opacity = 30;
      num-workspaces = 12;
      theme = "Arc-Dark";
      titlebar-font = "JetBrainsMono Nerd Font 10";
      workspace-names = [
        "1. Home"
        "2. Chats"
        "3. Music"
        "4. Notes"
        "5. Code"
        "6. Work"
        "7. GPT"
        "8. Education"
        "9. Media"
        "10. Monitoring"
        "11. Offtop"
        "12. Workspace"
      ];
    };

    "org/cinnamon/gestures" = {
      enabled = true;
      pinch-percent-threshold = mkUint32 40;
      swipe-down-2 = "PUSH_TILE_DOWN::end";
      swipe-down-3 = "TOGGLE_EXPO::end";
      swipe-down-4 = "VOLUME_DOWN::end";
      swipe-left-2 = "PUSH_TILE_LEFT::end";
      swipe-left-3 = "WORKSPACE_NEXT::end";
      swipe-left-4 = "WINDOW_WORKSPACE_PREVIOUS::end";
      swipe-percent-threshold = mkUint32 20;
      swipe-right-2 = "PUSH_TILE_RIGHT::end";
      swipe-right-3 = "WORKSPACE_PREVIOUS::end";
      swipe-right-4 = "WINDOW_WORKSPACE_NEXT::end";
      swipe-up-2 = "PUSH_TILE_UP::end";
      swipe-up-3 = "TOGGLE_EXPO::end";
      swipe-up-4 = "VOLUME_UP::end";
      tap-3 = "MEDIA_PLAY_PAUSE::end";
    };

    "org/cinnamon/launcher" = {
      check-frequency = 300;
      memory-limit = 2048;
    };

    "org/cinnamon/muffin" = {
      attach-modal-dialogs = true;
      center-new-windows = true;
      draggable-border-width = 10;
      experimental-features = ["scale-monitor-framebuffer"];
      placement-mode = "center";
      resize-threshold = 24;
      tile-hud-threshold = 25;
      tile-maximize = true;
      unredirect-fullscreen-windows = false;
      workspace-cycle = true;
      workspaces-only-on-primary = false;
    };

    "org/cinnamon/settings-daemon/peripherals/keyboard" = {
      numlock-state = "on";
    };

    "org/cinnamon/settings-daemon/peripherals/touchscreen" = {
      orientation-lock = true;
    };

    "org/cinnamon/settings-daemon/plugins/power" = {
      button-power = "interactive";
      critical-battery-action = "shutdown";
      idle-brightness = 5;
      idle-dim-time = 120;
      lid-close-ac-action = "suspend";
      lid-close-battery-action = "suspend";
      lid-close-suspend-with-external-monitor = false;
      lock-on-suspend = true;
      sleep-display-ac = 300;
      sleep-display-battery = 300;
      sleep-inactive-ac-timeout = 900;
      sleep-inactive-battery-timeout = 600;
    };

    "org/cinnamon/settings-daemon/plugins/xsettings" = {
      buttons-have-icons = false;
    };

    "org/cinnamon/sounds" = {
      login-enabled = true;
      notification-enabled = false;
      switch-enabled = false;
      tile-enabled = false;
    };

    "org/cinnamon/theme" = {
      name = "Orchis-Dark-Compact";
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
