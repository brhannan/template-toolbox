function value = at(obj, name)
%AT Retrieve a map value.
%   VALUE = CONTEXT.AT(NAME) returns the value associated with key NAME.

validateattributes(name, {'char'}, {})
value = obj.Map(name);

end