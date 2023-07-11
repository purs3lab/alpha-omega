package openssf.omega.policy.autogenerated.cwe.cwe_1127

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_1127
# title: "CWE-1127: Compilation with Insufficient Warnings or Errors"
# methodology: >
#   The code is compiled without sufficient warnings enabled, which may prevent the detection of subtle bugs or quality issues.
# version: 0.1.0
# last_updated:
#   date: 2023-05-25
#   author: Michael Scovetta <michael.scovetta@gmail.com>
# ---

import future.keywords.every
import future.keywords.in

default pass = false
default applies = false

# Identify whether this policy applies to a given data object
applies := true {
    input.predicate.generator.name == "openssf.omega.security_tool_finding"
    input.predicateType == "https://github.com/ossf/alpha-omega/security_tool_finding/0.1.0"
    input.predicate.content.tags
}

pass := true {
    every assertion in input {
        not "cwe-1127" in assertion.predicate.content.tags
    }
}