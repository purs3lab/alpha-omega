package openssf.omega.policy.autogenerated.cwe.cwe_1282

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_1282
# title: "CWE-1282: Assumed-Immutable Data is Stored in Writable Memory"
# methodology: >
#   Immutable data, such as a first-stage bootloader, device identifiers, and "write-once" configuration settings are stored in writable memory that can be re-programmed or updated in the field.
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
        not "cwe-1282" in assertion.predicate.content.tags
    }
}