# Lesson 08 — Protocols

> Spine: `typing.Protocol`

## You write

`MarketData` and `OrderRouter` protocols. A `Quoter` that depends on them, not on `IB()`.
Fake implementations for tests. Inventory-aware quotes on MES.

## Definition of done

You can swap a fake router without touching the book.
