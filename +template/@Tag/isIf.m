function tf = isIf(obj)
% Returns true if this is an IF tag.

obj.errorIfTagTypeUnset();
tf = obj.Type == template.TagType.IF;

end