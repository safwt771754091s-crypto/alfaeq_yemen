// Simple Jest-like tests (pseudo)
import { searchBuffer } from '../src/editor/findController';

test('search text simple', () => {
  const buf = new TextEncoder().encode('hello world');
  const res = searchBuffer(buf, 'world', false);
  if (!(res.length === 1 && res[0].start === 6 && res[0].length === 5)) throw new Error('test failed');
});

test('search hex sequence', () => {
  const buf = new Uint8Array([0x0a, 0xff, 0x1b, 0x00, 0x0a, 0xff, 0x1b]);
  const res = searchBuffer(buf, '0A FF 1B', true);
  if (!(res.length === 2 && res[0].start === 0 && res[1].start === 4)) throw new Error('test failed');
});
