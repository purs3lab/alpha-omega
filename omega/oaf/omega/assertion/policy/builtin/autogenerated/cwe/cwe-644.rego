package openssf.omega.policy.autogenerated.cwe.cwe_644

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_644
# title: "CWE-644: Improper Neutralization of HTTP Headers for Scripting Syntax"
# methodology: >
#   The product does not neutralize or incorrectly neutralizes web scripting syntax in HTTP headers that can be used by web browser components that can process raw headers, such as Flash.
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
        not "cwe-644" in assertion.predicate.content.tags
    }
}