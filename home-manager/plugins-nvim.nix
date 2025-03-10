{
  mini = {
    enable = true;
    modules = {
      icons = {};
      indentscope = {};
      jump = {};
      jump2d.mappings.start_jumping = "s";
      pairs = {};
      files = {};
      ai = {};
      operators = {};
      statusline = {};
      starter = {};
      notify = {};
      bracketed = {};
      surround = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          find_left = "gsF";
          highlight = "gsh";
          replace = "gsr";
          update_n_lines = "gsn";
        };
      };
    };
  };

  fzf-lua = {
    enable = true;
    keymaps = {
      "<leader>ff" = "files";
      "<leader>fm" = "marks";
      "<leader>fr" = "oldfiles";
      "<leader>fs" = "treesitter";
      "<leader>fw" = "live_grep";
      "<leader>fz" = "grep_curbuf";
      "<leader>fd" = "lsp_definitions";
      "<leader>ft" = "tags";
      "<leader>fb" = "buffers";
    };
  };

  treesitter = {
    enable = true;
    settings = {
      indent.enable = false;
      auto_install = true;
      highlight = {
        enable = true;
        use_languagetree = true;
      };
    };
  };

  neorg = {
    enable = true;
    settings = {
      load = {
        "core.defaults".__empty = null;
        "core.concealer".config = { icon_preset = "varied"; };
        "core.dirman".config = {
           workspaces = {
            notes = "~/notes";
            luciernaga = "~/luciernaga";
          };
        };
      };
    };
  };

  luasnip = {
    enable = true;
  };
      
  friendly-snippets = {
    enable = true;
  };

  blink-cmp = {
    enable = true;
    setupLspCapabilities = true;
    settings = {
      keymap = {
        "<Tab>" = [
          "select_next"
          "accept"
          "fallback"
        ];
        "<S-Tab>" = [
          "select_prev"
          "accept"
          "fallback"
        ];
        "<C-f>" = [
          "snippet_forward"
          "fallback"
        ];
        "<Space>" = [
          "accept"
          "fallback"
        ];
      };
      completion = {
        documentation.auto_show = false; 
        ghost_text.enabled = true;
        list.selection = {
          preselect = false;
          auto_insert = true;
        };
      };
      snippets.preset = "luasnip";
    };
  };

  snacks = {
    enable = true;
    settings = {
      quickfile.enabled = true;
      bigfile.enabled = true;
    };
  };

  lsp = {
    enable = true;
    servers = {
      nixd.enable = true;
      pyright.enable = true;
      clangd.enable = true;
      hls = {
        enable = true;
        installGhc = true;
      };
      rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
      };
    };
  };

  which-key = {
    enable = true;
    settings = {
      preset = "helix";
    };
  };
}
