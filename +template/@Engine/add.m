function add(obj, name, value)
%ADD Add a map name-value pair.
%   ENGINE.ADD(NAME,VALUE) adds a map entry with key NAME and value VALUE.

validateattributes(name, {'char','sring'}, {})
obj.Context.add(name, value);

end