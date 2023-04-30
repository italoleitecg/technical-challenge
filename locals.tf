locals {
  dependencies_script = templatefile("${path.module}/dependencies.sh", {
    var = {
      github_token = var.github_token
    }
  })
}
