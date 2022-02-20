function tf = isFor(obj)
% Returns true if this is a FOR tag.

obj.errorIfTagTypeUnset();
tf = obj.Type == template.TagType.FOR;

end