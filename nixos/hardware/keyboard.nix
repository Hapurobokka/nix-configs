_: {
  services.keyd = {
    enable = true;

    keyboards.mouse = {
      ids = [ "1ea7:0064" ];
      
      settings = {
        main = {
          mouse2 = "leftmouse";
        };
      };
    };
  };
}

