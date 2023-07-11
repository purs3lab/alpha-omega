package openssf.omega.policy.autogenerated.cwe.cwe_263

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_263
# title: "CWE-263: Password Aging with Long Expiration"
# methodology: >
#   The product supports password aging, but the expiration period is too long.
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
        not "cwe-263" in assertion.predicate.content.tags
    }
}