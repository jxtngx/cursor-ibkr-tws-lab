# Lesson 01 — Getting started

> Spine: [ib-interface](https://github.com/jxtngx/ib-interface) · [TWS API intro](https://interactivebrokers.github.io/tws-api/introduction.html)
> No `IB.connect` this week.

## Read first

- [ ] ib-interface README (protobuf / `ibapi`, not production-ready)
- [ ] TWS API: enable socket, paper vs live ports
- [ ] Install from source: `uv pip install -e ../path/to/ib-interface` (or clone beside the lab)

## You write

- `NOTES.md`: paper vs live ports; why `ib_interface` not `ib_insync`; why not raw `EClient`
- A module that **parses** a port and **rejects** 7496/4001
- Tests. No socket.

## Definition of done

You can explain what ib-interface is and why this lab does not connect yet.
