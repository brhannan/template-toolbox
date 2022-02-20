function tagType = getTagTypeFromTagString(tagStr)
%GETTAGTYPEFROMTAGSTRING Identify the type of input tag string.
%   TAGTYPE = TEMPLATE.GETTAGTYPEFROMTAGSTRING(TAGSTR) identifies the type 
%   (examples: if, for, comment) of the input tag string TAGSTR (character 
%   array). Output TAGTYPE is a template.TagType (enum) that specifies the 
%   tag type.
%
%   The input TAGSTR is a complete tag. For example, TAGSTR may have the
%   form 
%       TAGSTR = '{% if true %} hello world {% endif %}'
%
%   Compare this function to template.TagType.stringToTagType(), which 
%   accepts keyword input.

validateattributes(tagStr, {'char','string'}, {})

% Get the "beginning" of the tag. Example: '{% if true %}'.
[ixFirstTagStartPat, ixFirstTagEndPat] = getIxsTagStartAndEndPat(tagStr);
tagBeginning = tagStr( ...
    ixFirstTagStartPat : ...
    ixFirstTagEndPat+length(template.Template.TagEndPat) - 1);
% Get the contents of the beginning of the tag. Split at whitespace.
tagParts = strsplit(template.Tag.removeBraces(tagBeginning), ' ');
% The tag keyword (examples: if, for) is expected to be the 1st word.
tagKeyword = tagParts{1};
tagType = template.TagType.stringToTagType(tagKeyword);

end


%--------------------------------------------------------------------------
function [ixStart, ixEnd] = getIxsTagStartAndEndPat(tagStr)
% Returns the indices of the start of the first tag start pattern and the
% start of the first tag end pattern in tag string TAGSTR.

ixsTagStartPat = strfind(tagStr, template.Template.TagStartPat); 
if isempty(ixsTagStartPat)
    error('getTagType:noTagStartPatternsFound', ...
        'Expected tag\n%s\n to contain at least one "%s".', ...
        tagStr, obj.TagStartPat);
end
ixStart = ixsTagStartPat(1);

ixsTagEndPat = strfind(tagStr, template.Template.TagEndPat); 
if isempty(ixsTagStartPat)
    error('getTagType:noTagStopPatternsFound', ...
        'Expected tag\n%s\n to contain at least one "%s".', ...
        tagStr, template.Template.TagEndPat);
end
ixEnd = ixsTagEndPat(1);

end