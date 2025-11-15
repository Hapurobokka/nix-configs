{
  pkgs,
  lib,
  ...
}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme = {
          enable = false;
          name = "catppuccin";
          style = "frappe";
        };

        options = {
          number = true;
          relativenumber = true;
          cursorline = true;

          shiftwidth = 4;
          tabstop = 4;
          smartindent = true;
          expandtab = true;
          softtabstop = 4;

          ignorecase = true;
          smartcase = true;

          foldlevelstart = 99;

          signcolumn = "yes";
          splitbelow = true;
          splitright = true;
          termguicolors = true;
          timeoutlen = 400;
          undofile = true;

          wrap = true;
          linebreak = true;
        };

        clipboard = {
          enable = true;
          registers = "unnamedplus";
        };
        autocmds = [
          {
            desc = "Changes the indent size to 2 in certain files";
            event = ["FileType"];
            callback =
              lib.generators.mkLuaInline
              /*
              lua
              */
              ''
                function()
                    vim.bo.tabstop = 2
                    vim.bo.shiftwidth = 2
                    vim.bo.expandtab = true
                end
              '';
            pattern = [
              "javascript"
              "css"
              "haskell"
              "html"
              "javascriptreact"
              "lua"
              "nim"
              "nix"
              "svelte"
              "typescript"
              "typescriptreact"
              "xml"
            ];
          }

          {
            event = ["FileType"];
            pattern = ["norg"];
            callback =
              lib.generators.mkLuaInline
              /*
              lua
              */
              ''
                function()
                  vim.keymap.set("n", "<S-CR>", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true })
                  end
              '';
          }
        ];

        spellcheck = {
          enable = true;
          languages = ["es"];
          ignoredFiletypes = ["toggleterm" "term"];
        };

        lsp = {
          enable = true;
        };
        formatter.conform-nvim = {
          enable = true;
          setupOpts.formatters_by_ft = {python = ["black"];};
        };

        extraPlugins = with pkgs.vimPlugins; {
          plenary = {
            package = plenary-nvim;
          };
          markview = {
            package = markview-nvim;
          };
          table-mode = {
            package = vim-table-mode;
          };
          kanagawa = {
            package = kanagawa-nvim;
            setup = /*lua*/ "vim.cmd 'colorscheme kanagawa'";
          };
        };

        ui.noice.enable = true;
        mini = {
          ai.enable = true;
          bracketed.enable = true;
          icons.enable = true;
          map.enable = true;
          jump.enable = true;
          jump2d.enable = false;
          operators.enable = true;
          pairs.enable = true;
          starter.enable = true;
          statusline.enable = true;
          surround.enable = true;
          clue = {
            enable = true;
            setupOpts = {
              triggers = [
                {
                  mode = "n";
                  keys = "<Leader>";
                }
                {
                  mode = "x";
                  keys = "<Leader>";
                }

                {
                  mode = "i";
                  keys = "<C-x>";
                }

                {
                  mode = "n";
                  keys = "g";
                }
                {
                  mode = "x";
                  keys = "g";
                }

                {
                  mode = "n";
                  keys = ",";
                }
                {
                  mode = "x";
                  keys = ",";
                }

                {
                  mode = "n";
                  keys = "\"";
                }
                {
                  mode = "n";
                  keys = "\`";
                }
                {
                  mode = "x";
                  keys = "\"";
                }
                {
                  mode = "x";
                  keys = "`";
                }

                {
                  mode = "n";
                  keys = "s";
                }
                {
                  mode = "x";
                  keys = "s";
                }

                {
                  mode = "n";
                  keys = "\"";
                }
                {
                  mode = "x";
                  keys = "\"";
                }
                {
                  mode = "i";
                  keys = "<C-r>";
                }
                {
                  mode = "c";
                  keys = "<C-r>";
                }

                {
                  mode = "n";
                  keys = "<C-w>";
                }

                {
                  mode = "n";
                  keys = "z";
                }
                {
                  mode = "x";
                  keys = "z";
                }
              ];
              clues =
                lib.generators.mkLuaInline
                /*
                lua
                */
                ''
                  {
                    require('mini.clue').gen_clues.builtin_completion(),
                    require('mini.clue').gen_clues.g(),
                    require('mini.clue').gen_clues.marks(),
                    require('mini.clue').gen_clues.registers(),
                    require('mini.clue').gen_clues.windows(),
                    require('mini.clue').gen_clues.z(),

                  }
                '';
            };
          };
        };
        fzf-lua.enable = true;
        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
          setupOpts = {
            keymap.preset = "default";
            cmdline.keymap.preset = "default";
          };
        };
        binds = {
          hardtime-nvim.enable = true;
        };
        git.gitsigns.enable = true;
        utility = {
          oil-nvim.enable = true;
          motion = {
            precognition.enable = false;
            flash-nvim = {
              enable = true;
              mappings = {
                jump = "S";
                treesitter = null;
              };
            };
          };
        };
        visuals.fidget-nvim.enable = true;
        presence.neocord.enable = true;
        terminal.toggleterm.enable = true;
        filetree.neo-tree.enable = true;

        notes.obsidian = {
          enable = false;
          setupOpts = {
            ui.enable = false;
            workspaces = [
              {
                name = "vault";
                path = "~/Documentos/vault";
              }
            ];
            daily_notes = {
              folder = "fleeting/";
              date = "%d-%m-%Y";
              default_tags = ["fleeting"];
            };
            note_id_func =
              lib.generators.mkLuaInline
              /*
              lua
              */
              ''
                function(title)
                  local suffix = ""
                  if title ~= nil then
                    -- If title is given, transform it into valid file name.
                    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
                  else
                    -- If title is nil, just add 4 random uppercase letters to the suffix.
                    for _ = 1, 4 do
                      suffix = suffix .. string.char(math.random(65, 90))
                    end
                  end
                  return tostring(os.time()) .. "-" .. suffix
                end
              '';
          };
        };

        notes.neorg = {
          enable = true;
          setupOpts = {
            load = {
              "core.defaults".enable = true;
              "core.concealer" = {};
              "core.dirman" = {
                config = {
                  workspaces = {
                    main = "~/neorg";
                  };
                  index = "index.norg";
                  default_workspace = "main";
                };
              };
            };
          };
          treesitter.enable = true;
        };

        languages = {
          enableFormat = true;
          nix = {
            enable = true;
            extraDiagnostics.enable = true;
            format.enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          rust = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          clang = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          python = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            format.enable = true;
          };
          typst = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
        };

        treesitter = {
          grammars = pkgs.vimPlugins.nvim-treesitter.allGrammars;
          indent.enable = false;
        };

        keymaps = [
          # Fzf-Lua binds
          {
            action = ":FzfLua files<cr>";
            key = "<leader>ff";
            mode = "n";
            silent = true;
            desc = "Open files";
          }
          {
            action = ":FzfLua buffers<cr>";
            key = "<leader>bb";
            mode = "n";
            silent = true;
            desc = "Open buffers";
          }
          {
            action = ":FzfLua live_grep<cr>";
            key = "<leader>fg";
            mode = "n";
            silent = true;
            desc = "Open buffers";
          }
          {
            action = ":FzfLua diagnostics_document<cr>";
            key = "<leader>fd";
            mode = "n";
            silent = true;
            desc = "Open diagnostics";
          }
          {
            action = ":FzfLua oldfiles<cr>";
            key = "<leader>fr";
            mode = "n";
            silent = true;
            desc = "Open recent files";
          }
          {
            action = ":FzfLua lsp_document_symbols<cr>";
            key = "<leader>fs";
            mode = "n";
            silent = true;
            desc = "Show lsp symbols";
          }
          {
            # Oil binds
            action = ":Oil<cr>";
            key = "<leader>oo";
            mode = "n";
            silent = true;
            desc = "Open Oil";
          }

          # Buffer binds
          {
            action = ":bdelete<cr>";
            key = "<leader>bd";
            mode = "n";
            silent = true;
            desc = "Delete buffer";
          }

          # Misc binds
          {
            action = ":e ~/nix-configs/home-manager/nvf-configuration.nix<cr>";
            key = "<leader>fnd";
            mode = "n";
            silent = true;
            desc = "Open NVF file";
          }

          {
            action = ":ToggleTerm<cr>";
            key = "<leader>ot";
            mode = "n";
            silent = true;
            desc = "Open terminal";
          }

          {
            action = "<C-\\><C-n>";
            key = "<C-d>";
            mode = "t";
            silent = true;
            desc = "Exit term mode";
          }
          {
            action = ":FzfLua spell_suggest<cr>";
            key = "z=";
            mode = "n";
            silent = true;
            desc = "Trigger spell suggestions";
          }
          {
            action = ":FzfLua live_grep<cr>";
            key = "g/";
            mode = "n";
            silent = true;
            desc = "Search in all files";
          }
          {
            action = ":Neotree<cr>";
            key = "<Leader>ot";
            mode = "n";
            silent = true;
            desc = "Open Neotree";
          }
          {
            action = ":lua require('conform').format()<cr>";
            key = "<Leader>lf";
            mode = "n";
            silent = true;
            desc = "Custom format funcion";
          }
          # # Obsidian binds
          # {
          #   action = ":ObsidianQuickSwitch<cr>";
          #   key = "<leader>oq";
          #   mode = "n";
          #   silent = true;
          #   desc = "Quick switch Obsidian notes";
          # }
          # {
          #   action = ":ObsidianNew<cr>";
          #   key = "<leader>on";
          #   mode = "n";
          #   silent = true;
          #   desc = "New Obsidian note";
          # }
        ];
      };
    };
  };
}
