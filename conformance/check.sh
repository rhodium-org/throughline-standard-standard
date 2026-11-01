#!/usr/bin/env bash
# Checks each conformance example as its EX item says: the conforming standard
# must pass tl check and the conformance action, and each broken one must fail
# the check that catches it, for its reason.
set -u
cd "$(dirname "$0")"
action=../bin/check-standard
fail=0

expect_pass() {  # example, EX item
  if out=$(tl -C "$1" check 2>&1) && out=$("$action" "$1" 2>&1); then
    echo "ok    $2 $1 passes tl check and the conformance action"
  else
    echo "FAIL  $2 $1 should pass"; echo "$out"; fail=1
  fi
}

expect_fail() {  # example, EX item, the check that must fail it, text the failure must contain
  local out
  case "$3" in
    tl)     out=$(tl -C "$1" check 2>&1) ;;
    action) out=$("$action" "$1" 2>&1) ;;
  esac
  if [ $? -eq 0 ]; then
    echo "FAIL  $2 $1 should fail $3 with: $4"; echo "$out"; fail=1
  elif grep -qF -- "$4" <<<"$out"; then
    echo "ok    $2 $1 fails $3: $4"
  else
    echo "FAIL  $2 $1 failed $3, but not with: $4"; echo "$out"; fail=1
  fi
}

expect_pass conforming                EX-0001
expect_fail no-namespace         EX-0002 action "declares no [project] suggested_namespace"
expect_fail bad-namespace        EX-0003 action "suggested_namespace 'Example_Standard' is not a namespace"
expect_fail long-namespace       EX-0004 action "mangles to 'PRESENTATIONFORMATRULE' (22 characters)"
expect_fail missing-register     EX-0005 action "no register holds type 'example'"
expect_fail rule-without-example EX-0006 tl     "needs incoming 'verifies' link"
expect_fail no-ci                EX-0007 action "has a job named graph that runs tl check and the conformance action"
expect_fail no-codeowners        EX-0008 action ".github/CODEOWNERS is missing"
expect_fail not-following        EX-0009 action "has no [[sources]] entry for rhodium-org/throughline-standard-standard"
expect_fail no-follow-snippet    EX-0010 action "README.md does not show the [[sources]] entry"
exit $fail
