package openssf.omega.policy.autogenerated.cwe.cwe_607

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_607
# title: "CWE-607: Public Static Final Field References Mutable Object"
# methodology: >
#   A public or protected static final field references a mutable object, which allows the object to be changed by malicious code, or accidentally from another package.
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
        not "cwe-607" in assertion.predicate.content.tags
    }
}