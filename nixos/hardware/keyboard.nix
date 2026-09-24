_: {
  services.keyd = {
    enable = true;

    keyboards = {
      mouse = {
        ids = [ "1ea7:0064:eb0a7e0e" ];

        settings = {
          main = {
            mouse1 = "leftmouse";
            mouse2 = "leftmouse";
          };
        };
      };
    };
  };
}

