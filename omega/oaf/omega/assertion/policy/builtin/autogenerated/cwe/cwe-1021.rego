package openssf.omega.policy.autogenerated.cwe.cwe_1021

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_1021
# title: "CWE-1021: Improper Restriction of Rendered UI Layers or Frames"
# methodology: >
#   The web application does not restrict or incorrectly restricts frame objects or UI layers that belong to another application or domain, which can lead to user confusion about which interface the user is interacting with.
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
        not "cwe-1021" in assertion.predicate.content.tags
    }
}