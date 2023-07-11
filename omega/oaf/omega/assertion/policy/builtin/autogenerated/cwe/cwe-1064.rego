package openssf.omega.policy.autogenerated.cwe.cwe_1064

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_1064
# title: "CWE-1064: Invokable Control Element with Signature Containing an Excessive Number of Parameters"
# methodology: >
#   The product contains a function, subroutine, or method whose signature has an unnecessarily large number of parameters/arguments.
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
        not "cwe-1064" in assertion.predicate.content.tags
    }
}