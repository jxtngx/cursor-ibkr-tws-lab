---
name: curriculum-plan
description: Master 13-lesson Cursor IBKR TWS Lab (Python, ib-interface). After the lab, cursor-tws-plugin and local KYC.
---

# 13-lesson curriculum

Source of truth: [lessons/README.md](../../../lessons/README.md).

Client: [ib-interface](https://github.com/jxtngx/ib-interface). Wire: TWS API + official `ibapi` protobuf.
After lab: [cursor-tws-plugin](https://github.com/jxtngx/cursor-tws-plugin).

## Intent

Python types → L2 book + quoter + risk gates (MES first). Offline until optional paper hello in 12.
No live ports. Student writes the code.

## Agent rules

`@start-lesson N`: open spec, confirm reading, 10–20 lines of the concept, stop.
Do not implement. Do not `placeOrder` live. Do not assume retail (plugin KYC is after the lab).
