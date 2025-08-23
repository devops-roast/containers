group "default" {
  targets = [
    "mise",
  ]
}

variable "registry" {
  default = "docker.io/devopsroastbot"
}

function "tags" {
  params = [repository, tag]
  result = [
    "${registry}/${repository}:${tag}",
  ]
}

target "docker-metadata-action" {}
target "github-metadata-action" {}

target "common" {
  inherits = [
    "docker-metadata-action",
    "github-metadata-action",
  ]

  labels = {
    "org.opencontainers.image.authors" = "DevOps Roast <support+github@devops-roast.com>"
    "org.opencontainers.image.source"  = "https://github.com/devops-roast/containers"
  }
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
}

variable "mise_versions" {
  default = [
    "2025.8.20",
  ]
}

target "mise" {
  inherits   = ["common"]
  name       = format("mise-%s", distro)
  context    = "mise"
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
    tags("mise", version),
    tags("mise", "${version}-${distro}"),
  )
}
