return {
	"folke/todo-comments.nvim", -- Highlight todo, notes, etc in comments
	event = "VimEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	---@module 'todo-comments'
	---@type TodoOptions
	---@diagnostic disable-next-line: missing-fields
	opts = { signs = false },
}
