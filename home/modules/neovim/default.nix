{
  self,
  lib,
  config,
  pkgs,
  theme,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.generators) mkLuaInline;

  cfg = config.module.nvim;
in {
  options = {
    module.nvim.enable = mkEnableOption "Enables nvim";
  };

  config = mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      defaultEditor = true;

      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;

          withNodeJs = false;
          withPython3 = false;
          withRuby = false;

          enableLuaLoader = true;
          useSystemClipboard = true;
          hideSearchHighlight = true;
          searchCase = "smart";

          options = {
            mouse = "a";
            colorcolumn = "79";
            encoding = "utf-8";
            fileformat = "unix";
            number = true;
            relativenumber = true;
            swapfile = false;
            scrolloff = 7;
            tabstop = 2;
            shiftwidth = 2;
            softtabstop = 2;
            expandtab = true;
            smartindent = true;
          };

          globals = {
            mapleader = ",";
            editorconfig = true;
          };

          keymaps = [
            {
              key = "<C-n>";
              mode = ["n"];
              action = ":NvimTreeToggle<CR>";
              silent = true;
              desc = "Toggle File tree";
            }
            {
              key = "<Tab>";
              mode = "n";
              action = "<cmd>bnext<CR>";
              silent = true;
              desc = "Go to next buffer";
            }
            {
              key = "<S-Tab>";
              mode = "n";
              action = "<cmd>bprevious<CR>";
              silent = true;
              desc = "Go to previous buffer";
            }
            {
              key = "bd";
              mode = "n";
              action = "<cmd>bdel<CR>";
              silent = true;
              desc = "Close current buffer";
            }
            {
              key = ";;";
              mode = "n";
              action = "<cmd>Telescope<CR>";
              silent = true;
            }
            {
              key = ";g";
              mode = "n";
              action = "<cmd>Telescope live_grep<CR>";
              silent = true;
              desc = "Grep files";
            }
            {
              key = ";f";
              mode = "n";
              action = "<cmd>Telescope find_files<CR>";
              silent = true;
              desc = "Find files";
            }
            {
              key = "<leader>gn";
              mode = "n";
              action = ":LazyGit<CR>";
              silent = true;
              desc = "Open LazyGit";
            }
            {
              key = "<C-a>";
              mode = "n";
              action = "gg<S-v>G";
              silent = true;
              desc = "Select all";
            }
          ];

          extraLuaFiles = [
            "${self}/home/modules/neovim/lua/autocmds.lua"
            "${self}/home/modules/neovim/lua/rulayout.lua"
          ];

          autopairs.nvim-autopairs.enable = true;
          autocomplete.nvim-cmp.enable = true;
          telescope.enable = true;
          statusline.lualine.enable = true;
          comments.comment-nvim.enable = true;
          git.gitsigns.enable = true;

          lsp = {
            enable = true;
            lsplines.enable = true;
          };

          languages = {
            enableLSP = true;
            enableFormat = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;

            bash.enable = true;
            clang.enable = true;
            css.enable = true;
            dart.enable = true;
            go.enable = true;
            haskell.enable = true;
            hcl.enable = true;
            html.enable = true;
            java.enable = true;
            kotlin.enable = true;
            lua.enable = true;
            markdown.enable = true;
            nim.enable = true;
            nix.enable = true;
            python.enable = true;
            ruby.enable = true;
            rust.enable = true;
            scala.enable = true;
            sql.enable = true;
            typst.enable = true;
            ts.enable = true;
            terraform.enable = true;
            yaml.enable = true;
            zig.enable = true;
          };

          theme = {
            enable = true;
            name = theme;
            style = "dark";
          };

          notify.nvim-notify = {
            enable = true;

            setupOpts = {
              render = "minimal";
              stages = "static";
            };
          };

          spellcheck = {
            enable = true;
            languages = [
              "en"
              "ru"
            ];
          };

          terminal.toggleterm = {
            enable = true;

            setupOpts = {
              direction = "float";
            };
          };

          utility = {
            preview.markdownPreview = {
              enable = true;
            };
          };

          mini = {
            icons.enable = true;

            tabline = {
              enable = true;

              setupOpts = {
                show_icons = true;
              };
            };
          };

          visuals = {
            indent-blankline.enable = true;
          };

          ui = {
            noice.enable = true;

            borders = {
              enable = true;
              globalStyle = "rounded";

              plugins.nvim-cmp.enable = false;
            };

            smartcolumn = {
              enable = true;

              setupOpts.custom_colorcolumn = {
                nix = "110";
                rust = "120";
              };
            };
          };

          filetree = {
            nvimTree = {
              enable = true;
              openOnSetup = false;

              setupOpts = {
                sync_root_with_cwd = true;
                respect_buf_cwd = true;
                sort_by = "case_sensitive";
                git.enable = true;

                update_focused_file = {
                  enable = true;
                  update_root = true;
                };

                view = {
                  number = false;
                  float = {
                    enable = true;
                    open_win_config = mkLuaInline ''
                      function()
                        local screen_w = vim.opt.columns:get()
                        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                        local window_w = screen_w * 0.5
                        local window_h = screen_h * 0.8
                        local window_w_int = math.floor(window_w)
                        local window_h_int = math.floor(window_h)
                        local center_x = (screen_w - window_w) / 2
                        local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
                        return {
                          border = "rounded",
                          relative = "editor",
                          row = center_y,
                          col = center_x,
                          width = window_w_int,
                          height = window_h_int,
                        }
                      end
                    '';
                  };

                  width = mkLuaInline ''
                    function()
                      return math.floor(vim.opt.columns:get() * 0.5)
                    end
                  '';
                };

                hijack_cursor = false;
                renderer = {
                  group_empty = true;
                  full_name = true;
                  indent_markers = {
                    enable = true;
                  };
                  icons = {
                    show = {
                      file = true;
                      folder = true;
                      folder_arrow = true;
                    };
                    glyphs = {
                      default = "󰈚";
                      symlink = "";
                      folder = {
                        default = "";
                        empty = "";
                        empty_open = "";
                        open = "";
                        symlink = "";
                        symlink_open = "";
                        arrow_open = "";
                        arrow_closed = "";
                      };
                      git = {
                        untracked = "";
                        staged = "";
                        deleted = "";
                        unstaged = "󰜀";
                        renamed = "";
                        ignored = "◌";
                        unmerged = "";
                      };
                    };
                  };
                };
                filters = {
                  dotfiles = true;
                };
                diagnostics = {
                  enable = true;
                  show_on_dirs = true;
                };
              };
            };
          };

          lazy.plugins = {
            auto-session = {
              package = pkgs.vimPlugins.auto-session;
              setupModule = "auto-session";
              lazy = false;

              setupOpts = {
                auto_session_enabled = true;
                auto_session_root_dir = mkLuaInline ''
                  vim.fn.stdpath("data") .. "/sessions/"
                '';
                pre_save_cmds = mkLuaInline ''
                  { close_floating_windows, close_toggleterm, "NvimTreeClose" }
                '';
                post_restore_cmds = mkLuaInline ''
                  { clear_jumps, "NvimTreeOpen" }
                '';
                save_extra_cmds = mkLuaInline ''
                  { "NvimTreeOpen" }
                '';
              };
            };

            "auto-save.nvim" = {
              package = pkgs.vimPlugins.auto-save-nvim;
              setupModule = "auto-save";
              lazy = false;

              after = ''
                local group = vim.api.nvim_create_augroup('autosave', {})

                vim.api.nvim_create_autocmd('User', {
                    pattern = 'AutoSaveWritePost',
                    group = group,
                    callback = function(opts)
                        if opts.data.saved_buffer ~= nil then
                            local filename = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
                            vim.notify('AutoSave: saved at ' .. vim.fn.strftime('%H:%M:%S'), vim.log.levels.INFO)
                        end
                    end,
                })
              '';
            };

            "lazygit.nvim" = {
              package = pkgs.vimPlugins.lazygit-nvim;
              lazy = true;

              cmd = [
                "LazyGit"
                "LazyGitConfig"
                "LazyGitCurrentFile"
                "LazyGitFilter"
                "LazyGitFilterCurrentFile"
              ];
            };
          };
        };
      };
    };
  };
}
