function segmentTagText(obj)
%TAG.SEGMENTTAGTEXT Split tag at tag begin/end pattern, keeping delimiters.
%
%   Example:
%   If input is 
%   '{% if pi > 3 %} hello {% else %} world {% endif %}'
%   then the output is the cell array
%   { '{% if pi > 3 %}', 'hello', '{% else %}', 'world', '{% endif %}' }
%
%   The result is stored to the Parts property.

numTagParts = 2 * numel(obj.TagStartPatternIxs) - 1;
tagParts = cell(1, numTagParts);

% Get all tokens that start/end with {% ... %}.
tagPat = [ template.Template.TagStartPat, '.*?', ...
    template.Template.TagEndPat ];
tagTokens = regexp(obj.TemplateText, tagPat, 'match');
% Get the text that occurs between each pair of {% ... %}.
textBetweenTagTokens = strsplit(obj.TemplateText, ...
    tagTokens);

% Expect there to be an empty char at the beginning and end of 
% textBetweenTagTokens because TemplateText begins and ends with 
% {% ... %}.
assert(numel(textBetweenTagTokens) >= 2);

% Put tag parts into a cell array.
tagParts(1:2:end) = tagTokens;
tagParts(2:2:end) = textBetweenTagTokens(2:end-1);

obj.TagControlTokens = tagTokens;
obj.Parts = tagParts;

end