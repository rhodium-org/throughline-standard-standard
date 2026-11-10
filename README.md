# throughline-standard-standard

The throughline **meta-standard**: the one graph every throughline standard follows,
and which follows itself.

A standard declares the shape of the graphs that follow it (their registers, types,
value sets, attributes and links) as items a person ratifies, so an app reading a
follower can rely on that shape, and `tl check` reports every follower that departs
from it (throughline UR-0044, SR-0285..SR-0299). This graph fixes what those
declarations are.

| register | holds |
|---|---|
| `vision/` INT | why: every consumer reads a standard the same way |
| `registers/` REG | the registers every standard holds: INT (exactly one), REG, TYPE, ENUM, ATTR, LINK, LT; and the two only this graph holds, BASE and CONS (`scope: this-graph`) |
| `attributes/` ATTR | each register's attributes, typed by TYPE and ENUM items |
| `types/` TYPE, `enums/` ENUM | the named types and value sets those attributes use, built on the base types |
| `links/` LINK | the links between declarations: an attribute `belongs_to` one register and `has_type` one type; a link declaration runs `from`, `to` and `via`, or, with `outside` (ATTR-0040), `from` and `via` to any item of a graph the follower composes without taking its schema from |
| `link-types/` LT | `derives_from`, `belongs_to`, `has_type`, `from`, `to`, `via`, `aliases` |
| `base-types/` BASE | string, text, int, float, bool, date, enum, file: how each is written, how it compares, and values every implementation must accept and refuse |
| `constraints/` CONS | min, max, pattern (a subset that reads the same in Python and JavaScript), list |

A standard follows this graph with `schema = true` (namespace `meta`, the name it
suggests). It can never add a base type: a new base type is a new version of this
graph, `[project] meta_standard`, which a Tool implementing another version refuses.
`throughline.toml` holds no `[types]` or `[links]` tables: tl reads them from the
items (throughline 4.6.0 and later).
