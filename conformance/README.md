# Conformance examples

Each directory here is a small example standard that names this standard as its
schema source by path. An `EX` item in `../examples/` describes each one and
verifies the rules it shows: the conforming example must pass `tl check` and the
conformance action (`../bin/check-standard`), and each deliberately broken one
must fail the check that catches it, for the reason its item states.

`check.sh` runs every example and is a step of CI's `graph` job.

The examples that only the conformance action fails hold registers but no items,
since the action reads a standard's configuration, never its items. Their items
are written by `tl`; their `throughline.toml`, README and `.github/` are written by
hand, because they are the configuration under test. Each example's `.github/`
is inert: GitHub reads workflows only from a repository's root.
