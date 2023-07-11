package openssf.omega.policy.autogenerated.cwe.cwe_164

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_164
# title: "CWE-164: Improper Neutralization of Internal Special Elements"
# methodology: >
#   The product receives input from an upstream component, but it does not neutralize or incorrectly neutralizes internal special elements that could be interpreted in unexpected ways when they are sent to a downstream component.
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
        not "cwe-164" in assertion.predicate.content.tags
    }
}