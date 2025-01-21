_: prev: {
  rofi-calc = prev.rofi-calc.override {
    rofi-unwrapped = prev.rofi-wayland-unwrapped;
  };
}
