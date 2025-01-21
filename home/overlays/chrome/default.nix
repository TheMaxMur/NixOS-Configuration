_: prev: {
  google-chrome = prev.google-chrome.override {
    commandLineArgs = "--force-dark-mode";
  };
}
