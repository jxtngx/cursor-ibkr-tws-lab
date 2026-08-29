# Lesson 12 — Paper readiness

> Spine: your risk package · [TWS API intro](https://interactivebrokers.github.io/tws-api/introduction.html) · [ib-interface](https://github.com/jxtngx/ib-interface)
> Last lab lesson. Then the **plugin**, not more syllabus here.

## Contract

Live ports forbidden.
Paper `IB.connect("127.0.0.1", 7497, clientId=…)` is **optional stretch**. Default pytest still skips without TWS.

The tutor does not write `SessionClock`, `ForceFlat`, or a connect script.

## You write

- Session windows (pre-market / lunch — you define, fake `now` in tests)
- Outside window: pull quotes; if inventory ≠ 0, flatten **intent** (do not send unless stretch)
- `NOTES.md`: your types → `ib_interface` (`Contract`, `Order`, depth)
- MES flatten only

## Stretch (paper only)

```python
from ib_interface import IB
ib = IB()
ib.connect("127.0.0.1", 7497, clientId=1)
print(ib.isConnected(), ib.client.serverVersion())
ib.disconnect()
```

No live `placeOrder`. Tests skip if TWS is down.

## After this lab

Stop adding lessons to this repo.

1. New **trading** repository.
2. Install [cursor-tws-plugin](https://github.com/jxtngx/cursor-tws-plugin).
3. `/kyc-flow` → `{repo}/.cursor/tws-kyc.yaml` (does not assume retail).
4. Wire **your** book/quoter to `ib_interface` on paper under that profile.

## Definition of done

You can say when the system quotes, pulls, or would flatten, without a live broker.
You know the plugin is the next harness, not a hidden lesson 13 in this lab.
