package openssf.omega.policy.autogenerated.cwe.cwe_763

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_763
# title: "CWE-763: Release of Invalid Pointer or Reference"
# methodology: >
#   The product attempts to return a memory resource to the system, but it calls the wrong release function or calls the appropriate release function incorrectly.
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
        not "cwe-763" in assertion.predicate.content.tags
    }
}