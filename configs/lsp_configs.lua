local M = {}

local ccls_extra = {}
if vim.fn.has('macunix') then
  ccls_extra = {
          "-stdlib=libstdc++",
          "-isystem/usr/local/include",
          "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/c++/v1",
          "-isystem/Library/Developer/CommandLineTools/usr/lib/clang/13.0.0/include",
          "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include",
          "-isystem/Library/Developer/CommandLineTools/usr/include",
          "-isystem/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/System/Library/Frameworks"
  }
end

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"
  local util = require("lspconfig/util")

  lspconfig.ccls.setup {
    cmd = {"ccls",  "-log-file=/tmp/ccls.log", "-v=1"},
    filetypes = { "c", "cpp", "cc" },
    root_dir = util.root_pattern("compile_commands.json", ".ccls"),
    init_options = {
      cache = {
        directory = ".ccls-cache";
      },
      clang = {
        extraArgs = ccls_extra,
        client = {
         snippetSupport = true
        },
        highlight = {
          lsRanges = true
        }
      }
    },
    on_attach = attach,
    capabilities = capabilities,
  }

  lspconfig.pyright.setup {
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    root_dir = util.root_pattern(".git", "pyproject.toml", "pyrightconfig.json"),
    single_file_support = true,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = false,
          useLibraryCodeForTypes = false,
          diagnosticMode = 'openFilesOnly',
        },
      },
    },
    on_attach = attach,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
   
   -- typescript

return M
