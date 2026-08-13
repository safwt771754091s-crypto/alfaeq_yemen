import React, { useState } from 'react';

export type FindWidgetProps = {
  onSearch: (query: string, isHex?: boolean) => void;
  onNext: () => void;
  onPrev: () => void;
};

export const FindWidget: React.FC<FindWidgetProps> = ({ onSearch, onNext, onPrev }) => {
  const [query, setQuery] = useState('');
  const [isHex, setIsHex] = useState(false);

  const handleSearch = () => {
    onSearch(query, isHex);
  };

  return (
    <div style={{ display: 'flex', gap: 8, alignItems: 'center' }}>
      <input
        aria-label="Find"
        value={query}
        onChange={e => setQuery(e.target.value)}
        placeholder={isHex ? 'e.g. 0A FF 1B' : 'Search text...'}
        style={{ padding: 6 }}
      />
      <button onClick={handleSearch}>Search</button>
      <button onClick={onPrev} aria-label="Previous">Prev</button>
      <button onClick={onNext} aria-label="Next">Next</button>
      <label style={{ marginLeft: 8 }}>
        <input type="checkbox" checked={isHex} onChange={e => setIsHex(e.target.checked)} /> Hex
      </label>
    </div>
  );
};

export default FindWidget;
