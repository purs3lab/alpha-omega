package openssf.omega.policy.autogenerated.cwe.cwe_643

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_643
# title: "CWE-643: Improper Neutralization of Data within XPath Expressions ('XPath Injection')"
# methodology: >
#   The product uses external input to dynamically construct an XPath expression used to retrieve data from an XML database, but it does not neutralize or incorrectly neutralizes that input. This allows an attacker to control the structure of the query.
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
        not "cwe-643" in assertion.predicate.content.tags
    }
}