function keyset = keys(obj)
%KEYS Return all keys in map.
%   KEYSET = ENGINE.KEYS returns a cell array containing all map keys.

keyset = obj.Context.keys();

end