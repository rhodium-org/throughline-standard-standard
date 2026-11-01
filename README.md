# The standard standard

A [throughline](https://github.com/rhodium-org/throughline) graph that states the
shape every throughline standard is kept in. A standard is a public graph other
graphs follow as their schema source; this one is the standard those standards
follow, so they stop drifting apart.

It says nothing about any standard's subject. A plan standard and a presentation
standard declare their own item types, attributes and rules; this graph fixes what
they share: the registers, the item types those registers hold, the declarations a
standard makes about itself, the conformance check in CI and the protection on the
repository.

## What a standard must do

| Rule | Checked by |
|---|---|
| Declare `[project] suggested_namespace`, a valid namespace | the conformance action |
| Keep that namespace plus its longest register prefix within 16 characters (upper-cased, non-alphanumerics removed) | the conformance action |
| Hold five registers: vision (INT, `intent`), constraints (CON), rules (RULE), examples (EX) and non-goals (NG) | the conformance action |
| Record `origin` (human, ai, hybrid) on every item | `tl check`, from the types declared here |
| Verify every rule with an example | `tl check`, from the coverage rule declared here |
| Run `tl check` and the conformance action in a CI job named `graph` | the conformance action |
| Be public, with `.github/CODEOWNERS` and the three rulesets | the conformance action (CODEOWNERS); rulesets at set-up |
| Follow this standard as its schema source, pinned to an edition | the conformance action |
| Show in its README how to follow it | the conformance action |

throughline keeps `suggested_namespace` optional for every graph. A schema source
cannot require a key of its follower's `[project]` table, its registers, its README
or its CI, so those rules are checked by the action in this repository rather than
by `tl check`.

## Following the standard

A standard's `throughline.toml`:

```toml
[project]
name = "Plan format standard (throughline source)"
format_version = 4
suggested_namespace = "plan"

[[sources]]
namespace = "standard"
url = "https://github.com/rhodium-org/throughline-standard-standard"
ref = "v1.0.0"
schema = true
```

It then declares only what it adds: its own subject's types, attributes, links and
rules. It never redeclares a type, attribute, link, status or rule declared here.
This needs throughline 4.4.0 or later.

Its CI, in a job named `graph`:

```yaml
jobs:
  graph:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5
      - uses: actions/setup-python@v6
        with:
          python-version: "3.12"
      - run: pip install "throughline>=4.4.0"
      - run: tl check
      - uses: rhodium-org/throughline-standard-standard@v1.0.0
```

The action needs only Python 3.11 or later. Run it locally with
`python3 bin/check-standard <path to the standard>`.

## What is in this graph

| Register | Holds |
|---|---|
| `vision/` (INT) | why the standard exists |
| `constraints/` (CON) | obligations on the standard itself |
| `rules/` (RULE) | what a conforming standard must do; every declaration in `throughline.toml` names its rule |
| `examples/` (EX) | the example standards in `conformance/`, and the rules each verifies |
| `non-goals/` (NG) | what the standard leaves out on purpose |

## Editions

The standard is released as tagged editions that a standard pins. A change that
would make a conforming standard fail is a new major edition, and its notes say
what a standard must change.
