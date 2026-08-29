# Lessons

Lesson 00 is the toolchain.
Lessons 01–12 go from Python + [ib-interface](https://github.com/jxtngx/ib-interface) reading to a paper-ready MES → ES book + risk gates.

The **wire** is `ib_interface` (official `ibapi` protobuf under it).
Lessons 00–11 do not connect. Lesson 12 may paper-connect as stretch.
Live ports are forbidden.

After lesson 12: a **separate** trading repo + [cursor-tws-plugin](https://github.com/jxtngx/cursor-tws-plugin) (`/kyc-flow`).

You write every package. Agents quiz and review. They do not implement. They do not place live orders.

| # | Folder | Spine | You build |
| --- | --- | --- | --- |
| 00 | [00-dev-standards](00-dev-standards/LESSON.md) | ruff, pytest, uv | toolchain |
| 01 | [01-getting-started](01-getting-started/LESSON.md) | ib-interface, TWS API | install, paper ports |
| 02 | [02-language-foundations](02-language-foundations/LESSON.md) | Python types | ticks, MES first |
| 03 | [03-async-events](03-async-events/LESSON.md) | asyncio | event callbacks |
| 04 | [04-structs-enums](04-structs-enums/LESSON.md) | TWS contracts | Side, Tif, Inventory |
| 05 | [05-packages](05-packages/LESSON.md) | packages | tick / book / order / risk |
| 06 | [06-collections-iterators](06-collections-iterators/LESSON.md) | market depth | L2, microprice |
| 07 | [07-error-handling](07-error-handling/LESSON.md) | IB errors | paper gates |
| 08 | [08-protocols](08-protocols/LESSON.md) | Protocol | MarketData, OrderRouter |
| 09 | [09-tests-docs](09-tests-docs/LESSON.md) | pytest | fixtures, no TWS |
| 10 | [10-cli-io](10-cli-io/LESSON.md) | argparse | replay CLI |
| 11 | [11-concurrency](11-concurrency/LESSON.md) | asyncio | feed / book / quoter |
| 12 | [12-paper-readiness](12-paper-readiness/LESSON.md) | session, flatten | optional paper hello |

## How to start

```bash
cd lessons/00-dev-standards
# you create pyproject / tests
```

`@start-lesson 00` then `@review-python` after pytest is green.
