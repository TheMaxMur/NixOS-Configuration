{ self
, username
, ...
}:

let
  userModules = "${self}/home/users/${username}/modules";
in {
  imports = [
    "${userModules}/packages"
  ];
}

