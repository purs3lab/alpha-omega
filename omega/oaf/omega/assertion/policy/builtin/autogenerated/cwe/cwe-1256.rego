package openssf.omega.policy.autogenerated.cwe.cwe_1256

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_1256
# title: "CWE-1256: Improper Restriction of Software Interfaces to Hardware Features"
# methodology: >
#   The product provides software-controllable device functionality for capabilities such as power and clock management, but it does not properly limit functionality that can lead to modification of hardware memory or register bits, or the ability to observe physical side channels.
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
        not "cwe-1256" in assertion.predicate.content.tags
    }
}