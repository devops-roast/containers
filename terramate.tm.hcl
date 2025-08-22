terramate {
  config {
    git {
      default_remote = "origin"
      default_branch = "main"

      # learn more: https://terramate.io/docs/cli/orchestration/safeguards
      check_remote      = false
      check_untracked   = false
      check_uncommitted = false
    }
  }
}

# shared values for all stacks
globals {
  registries        = ["docker.io/devopsroastbot"]
  default_platforms = ["linux/amd64", "linux/arm64"]
}

# write the common template once per stack dir (so stacks can just inherit)
generate_hcl "docker-bake.override.hcl" {
  content {
    variable "registries" { default = global.registries }

    target "_template" {
      labels = {
        "org.opencontainers.image.authors" = "DevOps Roast <support+github@devops-roast.com>"
        "org.opencontainers.image.source"  = "https://github.com/devops-roast/containers"
      }
      platforms = global.default_platforms
    }
  }
}
