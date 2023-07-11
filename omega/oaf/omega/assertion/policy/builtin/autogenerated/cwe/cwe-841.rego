package openssf.omega.policy.autogenerated.cwe.cwe_841

# Metadata (YAML)
# ---
# name: autogenerated.cwe.cwe_841
# title: "CWE-841: Improper Enforcement of Behavioral Workflow"
# methodology: >
#   The product supports a session in which more than one behavior must be performed by an actor, but it does not properly ensure that the actor performs the behaviors in the required sequence.
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
        not "cwe-841" in assertion.predicate.content.tags
    }
}