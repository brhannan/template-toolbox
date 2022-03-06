function parse(obj)
%TAG.PARSE Parse a tag.

obj.getTagStartAndStopPatternIxs();
obj.segmentTagText();
obj.validateTagFormat();
% obj.segmentTagStringAndSetPartsProperty();
obj.parseBeginningOfTag();
obj.Body = strtrim(obj.Parts{2});

end