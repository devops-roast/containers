# NOTE: see 'docker-bake.override.hcl' for common configuration

target "default" {
  inherits   = ["_template"]
  name       = format("mise-%s", distro)
  dockerfile = format("Dockerfile.%s", distro)
  matrix = {
    distro = [
      "alpine",
      # "debian",
    ]
  }
  tags = formatlist("%s/mise:%s", registries, distro) # :alpine, :debian
}
