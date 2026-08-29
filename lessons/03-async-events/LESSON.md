# Lesson 03 — Async and events

> Spine: [asyncio](https://docs.python.org/3/library/asyncio.html) · ib-interface event-driven style (read, do not connect)

## You write

A tiny async callback registry: subscribe, emit a fake depth update, await a handler.
Tests with `pytest-asyncio` or `asyncio.run`.
No TWS.

## Definition of done

You can explain why `time.sleep` on the IB loop is a bug.
