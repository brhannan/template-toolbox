function tf = isComment(obj)
% Returns true if this is a COMMENT tag.

obj.errorIfTagTypeUnset();
tf = obj.Type == template.TagType.COMMENT;

end