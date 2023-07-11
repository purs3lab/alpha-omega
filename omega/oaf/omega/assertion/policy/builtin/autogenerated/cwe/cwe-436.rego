package openssf.omega.policy.autogenerated.cwe.cwe_436

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_436
# title: "CWE-436: Interpretation Conflict"
# methodology: >
#   Product A handles inputs or steps differently than Product B, which causes A to perform incorrect actions based on its perception of B's state.
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
        not "cwe-436" in assertion.predicate.content.tags
    }
}