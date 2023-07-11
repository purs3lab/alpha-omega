package openssf.omega.policy.autogenerated.cwe.cwe_1073

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_1073
# title: "CWE-1073: Non-SQL Invokable Control Element with Excessive Number of Data Resource Accesses"
# methodology: >
#   The product contains a client with a function or method that contains a large number of data accesses/queries that are sent through a data manager, i.e., does not use efficient database capabilities.
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
        not "cwe-1073" in assertion.predicate.content.tags
    }
}