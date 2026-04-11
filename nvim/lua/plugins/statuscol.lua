return {
	"luukvbaal/statuscol.nvim",
	config = function()
		vim.opt.number = true
		vim.opt.relativenumber = true

		local relnum = function(args)
			if args.relnum == 0 then
				return "  "
			end
			return string.format("%2d", args.relnum)
		end

		local absnum = function(args)
			return string.format("%2d", args.lnum)
		end

		require("statuscol").setup({
			setopt = true,
			ft_ignore = { "neo-tree" },
			bt_ignore = { "nofile" },
			segments = {
				{ text = { relnum, " " }, click = "v:lua.ScLa" },
				{ text = { absnum, " " }, click = "v:lua.ScLa" },
				{ sign = { namespace = { ".*" }, name = { ".*" }, auto = true } },
			},
		})
	end,
}
