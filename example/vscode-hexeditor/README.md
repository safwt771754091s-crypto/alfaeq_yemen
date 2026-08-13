# vscode-hexeditor — Simple Find skeleton

This folder contains a minimal skeleton for a "Simple Find" feature (UI + controller + tests) inspired by microsoft/vscode-hexeditor issue #1. It's provided as an example and does not integrate with your Flutter app — it's intended for reference or porting.

Files:
- src/view/findWidget.tsx — simple React/TSX find widget (input + next/prev buttons)
- src/editor/findController.ts — search logic (plain byte/text search)
- src/editor/highlightDecoration.ts — notes about VS Code decoration usage
- tests/find.spec.ts — simple tests (Jest-like)
- package.json — minimal package for building/testing this example

How to use
1. Inspect files in this branch `feat/simple-find`.
2. Copy/translate the logic into your target environment (VS Code extension in TypeScript or other).
3. Open a PR to upstream or adapt locally.
