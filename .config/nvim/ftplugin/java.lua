local jdtls = require("jdtls")

-- Root markers to find your project root
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)

local home = os.getenv("HOME")
local workspace_dir = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local config = {
    cmd = { "jdtls", "-data", workspace_dir },
    root_dir = root_dir,
    settings = {},
    init_options = {},
}

jdtls.start_or_attach(config)