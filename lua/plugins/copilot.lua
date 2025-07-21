return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom",
						ratio = 0.4,
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<M-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node",
				server_opts_overrides = {},
			})
		end,
	},

	-- Copilot CMP Source
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	-- Copilot Chat
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		keys = {
			-- Quick chat
			{ "<leader>cc", "<cmd>CopilotChat<cr>", desc = "CopilotChat - Open in split", mode = { "n", "v" } },
			{ "<leader>cv", "<cmd>CopilotChatVSplit<cr>", desc = "CopilotChat - Open in vsplit", mode = { "n", "v" } },
			{ "<leader>ct", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle", mode = { "n", "v" } },

			-- Quick actions
			{ "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code", mode = { "n", "v" } },
			{ "<leader>cr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code", mode = { "n", "v" } },
			{ "<leader>cf", "<cmd>CopilotChatFix<cr>", desc = "CopilotChat - Fix code", mode = { "n", "v" } },
			{ "<leader>co", "<cmd>CopilotChatOptimize<cr>", desc = "CopilotChat - Optimize code", mode = { "n", "v" } },
			{ "<leader>cd", "<cmd>CopilotChatDocs<cr>", desc = "CopilotChat - Generate docs", mode = { "n", "v" } },
			{ "<leader>cT", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests", mode = { "n", "v" } },

			-- Custom prompts
			{
				"<leader>cp",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
					end
				end,
				desc = "CopilotChat - Quick chat",
				mode = { "n", "v" },
			},

			-- Commit message generation
			{
				"<leader>cm",
				"<cmd>CopilotChatCommit<cr>",
				desc = "CopilotChat - Generate commit message for staged changes",
			},
			{
				"<leader>cM",
				"<cmd>CopilotChatCommitStaged<cr>",
				desc = "CopilotChat - Generate commit message for all changes",
			},
		},
		config = function()
			require("CopilotChat").setup({
				debug = false,
				model = "gpt-4", -- Can be 'gpt-3.5-turbo' or 'gpt-4'
				temperature = 0.1,

				question_header = "## User ",
				answer_header = "## Copilot ",
				error_header = "## Error ",

				-- Window configuration
				window = {
					layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace'
					width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
					height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
					-- Options below only apply to floating windows
					relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
					border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
					row = nil, -- row position of the window, default is centered
					col = nil, -- column position of the window, default is centered
					title = "Copilot Chat", -- title of chat window
					footer = nil, -- footer of chat window
					zindex = 1, -- determines if window is on top or below other floating windows
				},

				-- Chat settings
				chat = {
					welcome_message = "Welcome to CopilotChat! Ask me anything about your code.",
					loading_text = "Loading, please wait ...",
					question_sign = "", -- Sign to use for user questions
					answer_sign = "ﮧ", -- Sign to use for copilot answers
					border_follow = true,
					separator = "───", -- Separator to use in chat
					show_folds = true, -- Shows folds for sections in chat
					show_help = true, -- Shows help message as virtual lines when waiting for user input
					auto_follow_cursor = true, -- Auto-follow cursor in chat
					auto_insert_mode = false, -- Automatically enter insert mode when opening window and on new prompt
					clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
				},

				-- Context settings
				context = "buffer", -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
				history_path = vim.fn.stdpath("data") .. "/copilotchat_history", -- Default path to stored history
				callback = nil, -- Callback to use when ask response is received

				-- Selection settings
				selection = {
					-- Visual selection will be used as context.
					prompt = "Copilot please explain the following code:\n\n",
				},

				-- Prompts definitions
				prompts = {
					Explain = {
						prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
					},
					Review = {
						prompt = "/COPILOT_REVIEW Review the selected code.",
						callback = function(response, source)
							-- see config.lua for implementation
						end,
					},
					Fix = {
						prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
					},
					Optimize = {
						prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readability.",
					},
					Docs = {
						prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
					},
					Tests = {
						prompt = "/COPILOT_GENERATE Please generate tests for my code.",
					},
					FixDiagnostic = {
						prompt = "Please assist with the following diagnostic issue in file:",
						selection = function(source)
							return require("CopilotChat.select").diagnostics(source)
						end,
					},
					Commit = {
						prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
						selection = function(source)
							return require("CopilotChat.select").gitdiff(source, true)
						end,
					},
					CommitStaged = {
						prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
						selection = function(source)
							return require("CopilotChat.select").gitdiff(source, false)
						end,
					},
				},

				-- default mappings
				mappings = {
					complete = {
						detail = "Use @<Tab> or /<Tab> for options.",
						insert = "<Tab>",
					},
					close = {
						normal = "q",
						insert = "<C-c>",
					},
					reset = {
						normal = "<C-r>",
						insert = "<C-r>",
					},
					submit_prompt = {
						normal = "<CR>",
						insert = "<C-s>",
					},
					accept_diff = {
						normal = "<C-y>",
						insert = "<C-y>",
					},
					yank_diff = {
						normal = "gy",
						register = '"',
					},
					show_diff = {
						normal = "gd",
					},
					show_system_prompt = {
						normal = "gp",
					},
					show_user_selection = {
						normal = "gs",
					},
				},
			})
		end,
	},
}
