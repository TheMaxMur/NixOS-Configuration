return {
	settings = {
		schemas = {
			["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
			["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = {
				"ci/*.yml",
				".gitlab-ci.yml",
			},
			kubernetes = "templates/**",
		},
	},
}
