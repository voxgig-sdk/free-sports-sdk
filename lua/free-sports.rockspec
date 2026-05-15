package = "voxgig-sdk-free-sports"
version = "0.0-1"
source = {
  url = "git://github.com/voxgig-sdk/free-sports-sdk.git"
}
description = {
  summary = "FreeSports SDK for Lua",
  license = "MIT"
}
dependencies = {
  "lua >= 5.3",
  "dkjson >= 2.5",
  "dkjson >= 2.5",
}
build = {
  type = "builtin",
  modules = {
    ["free-sports_sdk"] = "free-sports_sdk.lua",
    ["config"] = "config.lua",
    ["features"] = "features.lua",
  }
}
