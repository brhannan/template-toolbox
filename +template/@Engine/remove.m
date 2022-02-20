function remove(obj, name)
%REMOVE Remove a map name-value pair.
%   ENGINE.REMOVE(NAME) removes the map entry with key NAME.

validateattributes(name, {'char','string'}, {})
obj.Context.remove(name);

end