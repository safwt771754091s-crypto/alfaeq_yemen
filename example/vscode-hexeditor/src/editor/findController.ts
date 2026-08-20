// Basic search controller for buffers (Node/Browser compatible)
// NOTE: This is a minimal implementation for demonstration and may need adaptation

export type Range = { start: number; length: number };

function hexStringToBytes(hex: string): number[] {
  // Accepts strings like "0A FF 1B" or "0aff1b"
  const cleaned = hex.replace(/[^0-9a-fA-F]/g, '');
  if (cleaned.length % 2 !== 0) throw new Error('Invalid hex string');
  const bytes: number[] = [];
  for (let i = 0; i < cleaned.length; i += 2) {
    bytes.push(parseInt(cleaned.substr(i, 2), 16));
  }
  return bytes;
}

export function searchBuffer(buffer: Uint8Array, query: string, isHex = false): Range[] {
  if (query.length === 0) return [];
  let pattern: number[];
  if (isHex) {
    pattern = hexStringToBytes(query);
  } else {
    // simple UTF-8 encoding for query
    pattern = Array.from(new TextEncoder().encode(query));
  }

  const results: Range[] = [];
  const n = buffer.length;
  const m = pattern.length;
  if (m === 0 || n === 0 || m > n) return results;

  // naive search (linear scan)
  for (let i = 0; i <= n - m; i++) {
    let j = 0;
    for (; j < m; j++) {
      if (buffer[i + j] !== pattern[j]) break;
    }
    if (j === m) results.push({ start: i, length: m });
  }
  return results;
}

// Simple controller class to track position
export class FindController {
  private results: Range[] = [];
  private index = -1;

  setResults(ranges: Range[]) {
    this.results = ranges;
    this.index = ranges.length > 0 ? 0 : -1;
  }

  next(): Range | null {
    if (this.results.length === 0) return null;
    this.index = (this.index + 1) % this.results.length;
    return this.results[this.index];
  }

  prev(): Range | null {
    if (this.results.length === 0) return null;
    this.index = (this.index - 1 + this.results.length) % this.results.length;
    return this.results[this.index];
  }

  current(): Range | null {
    if (this.results.length === 0 || this.index < 0) return null;
    return this.results[this.index];
  }
}
