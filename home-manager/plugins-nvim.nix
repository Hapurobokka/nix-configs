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
      animate = {};
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
      incremental_selection.enable = false;
      indent.enable = false;
      auto_install = true;
      highlight = {
        enable = true;
        use_languagetree = true;
      };
    };
  };

  neorg = {
    enable = false;
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
        documentation.auto_show = true; 
        ghost_text.enabled = true;
        list.selection = {
          preselect = false;
          auto_insert = true;
        };
      };
      snippets.preset = "luasnip";
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

  glow.enable = true;

  obsidian = {
    enable = true;
    settings = {
      workspaces = [
        {
          name = "vault";
          path = "~/vault";
        }
        {
          name = "aire";
          path = "~/aire";
        }
      ];
    };
  };
}
