package openssf.omega.policy.autogenerated.cwe.cwe_1105

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_1105
# title: "CWE-1105: Insufficient Encapsulation of Machine-Dependent Functionality"
# methodology: >
#   The product or code uses machine-dependent functionality, but it does not sufficiently encapsulate or isolate this functionality from the rest of the code.
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
        not "cwe-1105" in assertion.predicate.content.tags
    }
}