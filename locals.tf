# Create a local variable using a template file and the value of Terraformn variable.
locals {
  dependencies_script = templatefile("${path.module}/dependencies.sh", {
    var = {
      github_token = var.github_token
    }
  })
}
