{
  mini = {
    enable = true;
    modules = {
      icons = {};
      indentscope = {};
      jump = {};
      pairs = {};
      files = {};
      ai = {};
      operators = {};
      statusline = {};
      starter = {};
      notify = {};
      bracketed = {};
    };
  };

  fzf-lua = {
    enable = true;
    keymaps = {
      "<leader>." = "files";
      "<leader>fm" = "marks";
      "<leader>fr" = "oldfiles";
      "<leader>fs" = "treesitter";
      "<leader>fw" = "live_grep";
      "<leader>fz" = "grep_curbuf";
      "<leader>fd" = "lsp_definitions";
      "<leader>ft" = "tags";
      "<leader>," = "buffers";
    };
  };

  leap = {
    enable = true;
    addDefaultMappings = true;
  };

  hardtime.enable = true;

  nvim-surround.enable = true;

  treesitter = {
    enable = true;
    settings = {
      incremental_selection.enable = false;
      indent.enable = true;
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
      nushell.enable = true;
      nimls.enable = true;
      nixd.enable = true;
      pyright.enable = true;
      denols.enable = true;
      clangd.enable = true;
      hls = {
        enable = true;
        installGhc = false;
      };
      rust_analyzer = {
        enable = true;
        installCargo = false;
        installRustc = false;
      };
    };
  };

  which-key = {
    enable = true;
    settings = {
      preset = "helix";
    };
  };

  markview = { enable = false; };

  obsidian = {
    enable = false;
    settings = {
      ui.enable = false;
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

  neogit.enable = true;

  vimtex.enable = true;

  presence-nvim.enable = true;

  undotree.enable = true;

  rainbow-delimiters.enable = true;

  tmux-navigator.enable = true;
}
