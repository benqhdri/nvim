local opt = vim.opt

opt.showmatch = true
opt.foldenable = false
opt.nu = true
opt.rnu = true
opt.linebreak = true
opt.scrolloff = 10

opt.mouse:append("nv")
opt.clipboard:append("unnamedplus")

-- Change tab to space 4
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.foldmethod = "indent"

opt.ignorecase = true
opt.smartcase = true

opt.wildmode = { "longest", "list" }

opt.history = 8192
opt.laststatus = 2
opt.hidden = true
opt.fileencodings = { "utf-8", "gb18030" }

opt.background = "dark"
