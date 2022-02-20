function remove(obj, name)
%REMOVE Remove a map name-value pair.
%   CONTEXT.REMOVE(NAME) removes the map entry with key NAME.

validateattributes(name, {'char'}, {})
obj.Map.remove(name);

end