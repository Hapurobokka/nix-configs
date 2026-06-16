{pkgs, ...}: {
  programs.helix = {
    enable = true;

    extraPackages = [
      pkgs.nimlsp
      pkgs.ruff
      pkgs.ty
    ];

    settings = {
      theme = "kanagawa";
      editor = {
        soft-wrap.enable = true;
        true-color = true;
        line-number = "relative";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };

    languages = {
      language-server.rubocop = {
        command = "rubocop";
        args = [ "--lsp" ];
      };
      language-server.ruff = {
        command = "ruff";
        args = [ "server" ];
      };
      language-server.ty = {
        command = "ty";
        args = [ "server" ];
      };
      language-server.nimlsp = {
        command = "nimlsp";
      };
      language = [
        {
          name = "ruby";
          file-types = [
            "rb"
            "rake"
            "gemspec"
          ];
          language-servers = [ "rubocop" ];
        }
        {
          name = "python";
          language-servers = [ "ruff" "ty" ];
        }
        {
          name = "nim";
          language-servers = [ "nimlsp" ];
        }
      ];
    };
  };
}
