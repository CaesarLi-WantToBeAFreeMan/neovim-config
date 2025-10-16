return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim"
	},
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				--formatting
				--programming languages
				null_ls.builtins.formatting.clang_format.with({ --C/C++
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
				null_ls.builtins.formatting.google_java_format.with({ --Java
					extra_args = {
                        "--aosp"        --use 4 spaces per tab
                    }
				}),
				null_ls.builtins.formatting.stylua.with({ --Lua
					extra_args = {
						"--indent-type",                "Spaces",           --use 4 spaces per tab
						"--indent-width",               "4",                --convert tabs to spaces
						"--quote-style",                "AutoPreferDouble", --use double quotes instead of single ones
						"--call-parentheses",           "None",             --remove spaces before function call parentheses
						"--collapse-simple-statement",  "Always",           --allow single line statements
                        "--column-width",               "120"               --maximum line width before wrapping
					}
				}),
				null_ls.builtins.formatting.isort, --sort imports for Python
				null_ls.builtins.formatting.black, --format code for Python

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
				null_ls.builtins.formatting.sqlfluff,--SQL

				--diagnostics
				--programming languages
				null_ls.builtins.diagnostics.cpplint, --C/C++
				null_ls.builtins.diagnostics.checkstyle, --Java
				null_ls.builtins.diagnostics.flake8, --Python

				--web development
				null_ls.builtins.diagnostics.eslint_d, --JavaScript, TypeScript
				null_ls.builtins.diagnostics.stylelint, --CSS, SCSS

				--data
				null_ls.builtins.diagnostics.sqlfluff,--SQL

				--documents
				null_ls.builtins.diagnostics.markdownlint, --Markdown
			},
			vim.keymap.set( --format code using <A-f>
				"n",
				"<A-f>",
				vim.lsp.buf.format,
				{
					noremap = true,
					silent = true,
					desc = "format code",
				}
			),
		})
	end,
}
