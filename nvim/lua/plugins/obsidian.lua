return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  ft = "markdown",
  lazy = false,
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "personal",
        path = "~/dev_note",
      },
    },
  }
}
