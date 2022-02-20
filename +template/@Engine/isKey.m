function tf = isKey(obj, key)
%ISKEY Test whether KEY is a valid map key.
%   TF = ENGINE.ISKEY(KEY) returns true if KEY is a valid map key.

validateattributes(key, {'char','string'}, {})
tf = obj.Context.isKey(key);

end