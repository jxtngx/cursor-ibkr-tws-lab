# Cursor IBKR TWS Lab

Learn **algorithmic trading in Python** against Interactive Brokers, with SuperGrok and Cursor.
This repo is a **lab**, not a factory.
You read the official TWS API docs and [ib-interface](https://github.com/jxtngx/ib-interface), you write the Python, you sit with pytest until the book and the risk gates make sense.
SuperGrok and Cursor are the tutor and the reviewer.
They are not allowed to do the work for you.

> **Audience.** You can write a little Python. You intend to go from types and an L2 book to a paper-ready MES → ES path on **paper TWS**.
> You have [SuperGrok](https://grok.com) and [Cursor](https://cursor.com) open on this repo.
> You will type every function yourself.
>
> **Bias.** Interaction over generation.
> Official IBKR docs and `ib_interface` over a homemade socket client.
> Depth over a pasted notebook you cannot recreate.

This is the same contract as [cursor-rust-lab](https://github.com/jxtngx/cursor-rust-lab) and [cursor-data-engineering-lab](https://github.com/jxtngx/cursor-data-engineering-lab): the student does the work.
It is the opposite of a **factory**.
If an agent opens a PR with a complete OMS you did not write, the lab failed.

The client is **[jxtngx/ib-interface](https://github.com/jxtngx/ib-interface)** (`ib_interface`): a modernization of ib-insync that delegates protobuf encode/decode to official **`ibapi`** on TWS/Gateway server 201+.
Do not generate a parallel `EClient` stack.
Do not import archived `ib_insync` in new code.

`ib-interface` is in **active modernization, not production-ready**. This lab does not pretend otherwise.

Lessons 00–11 are **offline** (fixtures, mocks). Lesson 12 may **paper-connect** (TWS `7497` / Gateway `4002`) as stretch; tests still skip without a socket.
**Live ports 7496 / 4001 are forbidden.**

This is not trading advice.

---

## What this repo is

A thin Cursor harness around:

| Spine | Official thing |
| --- | --- |
| Client | [ib-interface](https://github.com/jxtngx/ib-interface) |
| Wire | [TWS API](https://interactivebrokers.github.io/tws-api/introduction.html) · official `ibapi` protobuf |
| Python | 3.12+ · pytest · ruff · `uv` |

Thirteen **specs** live in [`lessons/`](lessons/README.md). They are not solutions.

## After the lab

This syllabus ends when you can explain *your* book, quoter, and risk gates, and (optionally) a paper hello via `ib_interface`.

Then you leave the lab:

1. Create a **separate trading repo** (do not turn this lab into a product).
2. Install the Cursor plugin **[cursor-tws-plugin](https://github.com/jxtngx/cursor-tws-plugin)** (rules, quant-team skills, KYC flow).
3. Run **`/kyc-flow`**. Agents write `{trading-repo}/.cursor/tws-kyc.yaml`. They do not assume a retail trader.
4. Use `ib_interface` on **paper** until that file and you both allow live.

```bash
git clone https://github.com/jxtngx/cursor-tws-plugin.git
mkdir -p ~/.cursor/plugins/local
ln -s "$(pwd)/cursor-tws-plugin" ~/.cursor/plugins/local/cursor-tws-plugin
```

Reload Cursor → Customize → enable **cursor-tws-plugin**.

## The 13 lessons

Full table: [lessons/README.md](lessons/README.md).

| # | Lesson | Spine | You build |
| --- | --- | --- | --- |
| 00 | [Dev standards](lessons/00-dev-standards/LESSON.md) | ruff, pytest, uv | toolchain smoke |
| 01 | [Getting started](lessons/01-getting-started/LESSON.md) | ib-interface README, TWS API | install client, paper ports, no live |
| 02 | [Language foundations](lessons/02-language-foundations/LESSON.md) | Python types | ticks, multipliers, MES first |
| 03 | [Async and events](lessons/03-async-events/LESSON.md) | asyncio, ib_interface events | event-shaped callbacks |
| 04 | [Contracts and orders](lessons/04-structs-enums/LESSON.md) | TWS contracts/orders | `Side`, `Tif`, `Inventory` |
| 05 | [Packages](lessons/05-packages/LESSON.md) | packaging | `tick` / `book` / `order` / `risk` |
| 06 | [Collections](lessons/06-collections-iterators/LESSON.md) | TWS market depth | L2, microprice, imbalance |
| 07 | [Errors](lessons/07-error-handling/LESSON.md) | IB error codes | paper risk gates |
| 08 | [Protocols](lessons/08-protocols/LESSON.md) | `typing.Protocol` | `MarketData`, `OrderRouter` |
| 09 | [Tests](lessons/09-tests-docs/LESSON.md) | pytest | replay fixtures, no TWS required |
| 10 | [CLI](lessons/10-cli-io/LESSON.md) | argparse | replay + quote print |
| 11 | [Concurrency](lessons/11-concurrency/LESSON.md) | asyncio tasks | feed / book / quoter |
| 12 | [Paper readiness](lessons/12-paper-readiness/LESSON.md) | session, force-flat | optional paper hello; then the plugin |

## How you are supposed to work

```
read the official page  →  write a failing test  →  ask SuperGrok / Cursor  →  fix *your* code  →  pytest
```

1. Open `lessons/NN-*/LESSON.md` and finish **Read first** before you prompt.
2. Write a failing pytest yourself.
3. Ask the tutor to explain the failure, not to paste the book.
4. `@review-python` only after tests are green.
5. `@checkpoint` when you think you are done.

### What the harness must not do

- Implement `@start-lesson`
- Dump a complete OMS or port of ib-interface
- Use live ports or submit a live order
- Assume you are a retail trader (KYC is the **plugin**, after the lab)

## Tooling baseline

```bash
python3 --version   # 3.12+
# install ib-interface from source when lesson 01 says so
git clone https://github.com/jxtngx/ib-interface.git
uv pip install -e ./ib-interface
```

Paper: TWS **7497**, Gateway **4002**. Live **7496** / **4001** must not appear as defaults.

## Definition of done for a lesson

- [ ] Name the official page and the one concept
- [ ] pytest green (no TWS required except optional 12 stretch)
- [ ] You can rewrite the core function from a blank file
- [ ] No live port, no account number, no live `placeOrder`

## License

Apache-2.0. See [LICENSE](LICENSE).
Not affiliated with Interactive Brokers or Anysphere.
