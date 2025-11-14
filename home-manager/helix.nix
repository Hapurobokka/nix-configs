{ pkgs, ... }:
{
  programs.helix = {
    enable = true;

    settings = {
      theme = "kanagawa";
      editor = {
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
      language-server.pyright = {
        command = "pyright-langserver";
        args = [ "--stdio" ];
      };
      language = [
        {
          name = "ruby";
          file-types = [ "rb" "rake" "gemspec" ];
          language-servers = [ "rubocop" ];
        }
        {
          name = "python";
          language-servers = [ "pyright" ];
        }
      ];
    };
  };
}
