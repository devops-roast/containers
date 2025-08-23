# NOTE: see 'docker-bake.override.hcl' for common configuration

variable "mise_versions" {
  default = [
    "2025.8.20",
  ]
}

target "default" {
  inherits   = ["_template"]
  name       = format("mise-%s", distro)
  dockerfile = format("Dockerfile.%s", distro)
  matrix = {
    distro = [
      "alpine",
    ]
    version = mise_versions
  }
  args = {
    mise_version = format("%s", version)
  }
  tags = concat(
    formatlist("%s/mise:%s-%s", registries, version, distro),                # :2025.8.20-alpine
    distro == "alpine" ? formatlist("%s/mise:%s", registries, version) : [], # :2025.8.20
  )
}
