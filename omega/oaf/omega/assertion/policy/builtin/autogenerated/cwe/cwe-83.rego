package openssf.omega.policy.autogenerated.cwe.cwe_83

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_83
# title: "CWE-83: Improper Neutralization of Script in Attributes in a Web Page"
# methodology: >
#   The product does not neutralize or incorrectly neutralizes "javascript:" or other URIs from dangerous attributes within tags, such as onmouseover, onload, onerror, or style.
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
        not "cwe-83" in assertion.predicate.content.tags
    }
}