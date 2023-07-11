package openssf.omega.policy.autogenerated.cwe.cwe_196

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_196
# title: "CWE-196: Unsigned to Signed Conversion Error"
# methodology: >
#   The product uses an unsigned primitive and performs a cast to a signed primitive, which can produce an unexpected value if the value of the unsigned primitive can not be represented using a signed primitive.
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
        not "cwe-196" in assertion.predicate.content.tags
    }
}