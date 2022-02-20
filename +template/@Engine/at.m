function value = at(obj, name)
%AT Retrieve a map value.
%   VALUE = ENGINE.AT(NAME) returns the map value associated with key NAME.

validateattributes(name, {'char','string'}, {})
value = obj.Context.at(name);

end