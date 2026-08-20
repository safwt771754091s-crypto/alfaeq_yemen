/*
Notes for highlightDecoration.ts

In a real VS Code extension you would use the TextEditorDecorationType API to decorate ranges in an editor.
This file contains a brief example / notes showing how to apply decorations for found ranges.

Example (in extension code - pseudo):

const highlightDecoration = vscode.window.createTextEditorDecorationType({
  backgroundColor: 'rgba(255,255,0,0.3)'
});

editor.setDecorations(highlightDecoration, ranges.map(r => new vscode.Range(...)));

Adaptation required: hex editor deals with bytes; if using custom editor you may need to map byte offsets to editor positions.
*/

export const notes = `Use vscode.window.createTextEditorDecorationType and editor.setDecorations to highlight results. Map byte offsets to document ranges according to the editor's model.`;
