# Testing

Tests run with [tytanic](https://github.com/typst-community/tytanic) (the `tt` command).

## Setup

Install these versions. Tytanic 0.4.1 is the release that targets Typst 0.15.1, and other Typst versions can change the rendered references.

- [Typst](https://github.com/typst/typst) 0.15.1
- [tytanic](https://github.com/typst-community/tytanic/releases) 0.4.1

## Commands

Run these anywhere inside the project.

| Command | What it does |
| --- | --- |
| `tt run` | Run all tests and stop at the first failure |
| `tt run binary-tree/basics` | Run one test |
| `tt list` | List all tests |
| `tt update binary-tree/basics` | Accept the current output of a test as its new reference |
| `tt delete binary-tree/my-test` | Delete a test |

## Structure

Every folder with a `test.typ` is one test, and its path is the test's name.
Commit `test.typ` and `ref/`. Tytanic generates `out/` and `diff/` and ignores them in git automatically.

## When a test fails

`tt run` compares the images, and the failing test's folder then contains:
- `out/`: what the code renders now
- `ref/`: what it should render
- `diff/`: the difference between the two

Then decide which one is right:
- **The change is a bug:** fix the code.
- **The change is intended:** run `tt update <test>`, check the new `ref/` image, and commit it with the code change.
