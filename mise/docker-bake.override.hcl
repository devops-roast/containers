// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

variable "registries" {
  default = [
    "docker.io/devopsroastbot",
  ]
}
target "_template" {
  labels = {
    "org.opencontainers.image.authors" = "DevOps Roast <support+github@devops-roast.com>"
    "org.opencontainers.image.source"  = "https://github.com/devops-roast/containers"
  }
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
}
