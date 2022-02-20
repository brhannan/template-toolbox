function add(obj, name, value)
%ADD Add a map name-value pair.
%   CONTEXT.ADD(NAME,VALUE) adds a map entry with key NAME and value VALUE.

validateattributes(name, {'char'}, {})
obj.assertNameIsNotReserved(name);
obj.Map(name) = value;

end