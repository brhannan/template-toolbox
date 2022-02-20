function parse(obj)
%TAG.PARSE Parse a tag.

% TODO: add a check for matching start/end keyword.

obj.getTagStartAndStopPatternIxs();
obj.validateTagFormat();
obj.segmentTagStringAndSetPartsProperty();
obj.parseBeginningOfTag();
obj.Body = strtrim(obj.Parts{2});

end