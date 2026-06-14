vim.filetype.add({
  extension = {
    tf = "terraform",
    tfvars = "terraform-vars",
    terraformrc = "hcl",
  },
  filename = {
    ["Dangerfile"] = "ruby",
    ["poetry.lock"] = "toml",
  },
})
