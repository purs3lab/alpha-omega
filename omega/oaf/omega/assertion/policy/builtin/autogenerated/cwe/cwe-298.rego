package openssf.omega.policy.autogenerated.cwe.cwe_298

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_298
# title: "CWE-298: Improper Validation of Certificate Expiration"
# methodology: >
#   A certificate expiration is not validated or is incorrectly validated, so trust may be assigned to certificates that have been abandoned due to age.
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
        not "cwe-298" in assertion.predicate.content.tags
    }
}