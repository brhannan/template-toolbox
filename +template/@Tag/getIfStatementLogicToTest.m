function outStr = getIfStatementLogicToTest(beginTagStr)
%GETIFSTATEMENTLOGICTOTEST Get a string containing boolean test logic.
%   OUTSTR = TEMPLATE.TAG.GETIFSTATEMENTLOGICTOTEST(BEGINTAGSTR) parses
%   input BEGINTAGSTR (string or character array) and returns the text that
%   follows "if" or "elseif". Tag begin/end patterns and leading/trailing
%   whitespace are removed.
%
%   For example, if the input is '{% if x > 3 %}', OUTSTR will equal 
%   'x > 3'.

validateattributes(beginTagStr, {'char','string'}, {})

tagRegexPats = getTagRegexPatterns();
outStr = beginTagStr;

outStr = regexprep(outStr, tagRegexPats.elseifStart, '');
outStr = regexprep(outStr, tagRegexPats.elseStart, '');
outStr = regexprep(outStr, tagRegexPats.ifStart, '');
outStr = regexprep(outStr, tagRegexPats.tail, '');
                                
end


%--------------------------------------------------------------------------
function tagRegexPatterns = getTagRegexPatterns()
% Returns regex patterns that match the beginning and ending of
% elseif/else/if tags.

tagRegexPatterns = struct('ifStart', '', 'elseStart','', ...
    'elseifStart', '', 'tail', '');

getTagStartPat = @(keyword) sprintf('\\s*%s', ...
    template.Template.escapeSpecialCharacters( ...
                                    template.Template.TagStartPat), ...
    keyword);

tagRegexPatterns.ifStart = getTagStartPat('if');
tagRegexPatterns.elseStart = getTagStartPat('else');
tagRegexPatterns.elseifStart = getTagStartPat('elseif');

tagRegexPatterns.tail = sprintf('\\s*%s\\s*', ...
    template.Template.escapeSpecialCharacters( ...
                                    template.Template.TagEndPat));

end