package openssf.omega.policy.autogenerated.cwe.cwe_926

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_926
# title: "CWE-926: Improper Export of Android Application Components"
# methodology: >
#   The Android application exports a component for use by other applications, but does not properly restrict which applications can launch the component or access the data it contains.
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
        not "cwe-926" in assertion.predicate.content.tags
    }
}