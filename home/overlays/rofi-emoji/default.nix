_: prev: {
  rofi-emoji = prev.rofi-emoji.override {
    rofi-unwrapped = prev.rofi-wayland-unwrapped;
  };
}
