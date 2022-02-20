function tf = isKey(obj, key)
%ISKEY Test whether KEY exists in map.

validateattributes(key, {'char','string'}, {})
tf = obj.Map.isKey(key);

end