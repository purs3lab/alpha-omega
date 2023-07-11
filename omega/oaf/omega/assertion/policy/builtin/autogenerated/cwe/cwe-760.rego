package openssf.omega.policy.autogenerated.cwe.cwe_760

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_760
# title: "CWE-760: Use of a One-Way Hash with a Predictable Salt"
# methodology: >
#   The product uses a one-way cryptographic hash against an input that should not be reversible, such as a password, but the product uses a predictable salt as part of the input.
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
        not "cwe-760" in assertion.predicate.content.tags
    }
}