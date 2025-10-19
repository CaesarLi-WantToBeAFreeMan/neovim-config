return {
	"nvimtools/none-ls.nvim",                                       --formatting and diagnostics
	dependencies = {
		"nvim-lua/plenary.nvim"                                     --plenary
	},
	config = function()
		local null_ls = require("null-ls")                          --load none-ls module
		null_ls.setup({
			sources = {
				--formatters
				--programming languages
				null_ls.builtins.formatting.clang_format.with({             --C/C++ formatter
					extra_args = {
                        "--style={BasenOnStyle: LLVM," ..                   --use LLVM as base style
                        "IndentWidth: 4," ..                                --use 4 spaces per tab
                        "UseTab: Never," ..                                 --convert tabs to spaces
                        "BreakBeforeBraces: Attach," ..                     --keep { at the same line
                        "SpaceBeforeParens: Never," ..                      --remove spaces before ()
                        "SpacesInEmptyParentheses: false," ..               --remove spaces inside () 
                        "SpacesInParentheses: false," ..                    --remove spaces inside {}
                        "SpacesInSquareBrackets: false," ..                 --remove spaces inside []
                        "SpacesInAngles: Never," ..                         --remove spaces inside <>
                        "PointerAlignment: Center," ..                      --center pointer
                        "SpaceBeforeAssignmentOperators: true," ..          --add spaces around assignment operators
                        "AllowShortBlocksOnASingleLine: Always," ..         --allow single statement in blocks
                        "AllowShortIfStatementOnASingleLine: Always," ..    --allow single statement in ifs
                        "AllowShortLoopsOnASingleLine: true," ..            --allow single statement in loops
                        "AllowShortFunctionsOnASingleLine: All," ..         --allow single statement in functions
                        "SpacesBeforeTrailingComments: 0}"                  --no spaces before trailing comments
					}
				}),
				null_ls.builtins.formatting.google_java_format.with({       --Java formatter
					extra_args = {
                        "--aosp"        --use 4 spaces per tab
                    }
				}),
				null_ls.builtins.formatting.stylua.with({                   --Lua formatter
					extra_args = {
						"--indent-type",                "Spaces",           --use 4 spaces per tab
						"--indent-width",               "4",                --convert tabs to spaces
						"--quote-style",                "AutoPreferDouble", --use double quotes instead of single ones
						"--call-parentheses",           "None",             --remove spaces before function call parentheses
						"--collapse-simple-statement",  "Always",           --allow single line statements
                        "--column-width",               "120"               --maximum line width before wrapping
					}
				}),
				null_ls.builtins.formatting.isort,                          --Python import sorter
				null_ls.builtins.formatting.black,                          --Python code formatter

				--web development
				--JavaScript, JSX, TypeScript, TSX, Vue, HTML, CSS, SCSS, LESS, Markdown, YAML
				null_ls.builtins.formatting.prettier.with({
					extra_args = {
						"--tab-width",          "4",        --use 4 spaces per tab
						"--use-tabs",           "false",    --convert tabs to spaces
						"--single-quote",       "false",    --use double quotes instead of single ones
						"--jsx-single-quote",   "false",    --use double quotes instead of single ones in JSX
                        "--bracket-same-line",  "true",     --keep { at the same line
						"--bracket-spacing",    "false",    --remove spaces inside {}
						"--semi",               "true",     --use ;
						"--arrow-parens",       "avoid",    --avoid parentheses for single parameter arrow functions
						"--trailing-comma",     "es5",      --trailing commas where valid in ES5
						"--print-width",        "120",      --maximum line width before wrapping
					},
					filetypes = {
						"javascript", "javascriptreact", "typescript", "typescriptreact",
						"vue", "css", "scss", "html",
						"json", "yaml", "markdown",
					},
				}),

				--data
				null_ls.builtins.formatting.sqlfluff,       --SQL formatter

				--diagnostics
				--programming languages
				null_ls.builtins.diagnostics.cpplint,       --C/C++ linter
				null_ls.builtins.diagnostics.checkstyle,    --Java linter
				null_ls.builtins.diagnostics.flake8,        --Python linter

				--web development
				null_ls.builtins.diagnostics.eslint_d,      --JS/TS linter
				null_ls.builtins.diagnostics.stylelint,     --CSS/SCSS linter

				--data
				null_ls.builtins.diagnostics.sqlfluff,      --SQL linter

				--documents
				null_ls.builtins.diagnostics.markdownlint,  --Markdown linter
			},
			vim.keymap.set("n", "<A-f>", vim.lsp.buf.format,
				{
					silent = true,
					desc = "format code"
				}
			)
		})
	end
}
