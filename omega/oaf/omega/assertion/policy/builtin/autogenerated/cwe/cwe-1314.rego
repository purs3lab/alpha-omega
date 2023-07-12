package openssf.omega.policy.autogenerated.cwe.cwe_1314

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_1314
# title: "CWE-1314: Missing Write Protection for Parametric Data Values"
# methodology: >
#   The device does not write-protect the parametric data values for sensors that scale the sensor value, allowing untrusted software to manipulate the apparent result and potentially damage hardware or cause operational failure.
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
        not "cwe-1314" in assertion.predicate.content.tags
    }
}