function outstr = removeTagStarAndEndPat(instr)
%REMOVEBRACES Remove tag start/end pat from input.
%   OUTSTR = TAG.REMOVETAGSTARANDENDPAT(INSTR) removes the tag start and 
%   end patterns from INSTR and returns the result in OUTSTR.
%
%   Examples:
%       '{% p q %}        -> 'p q'
%       '{% {{ a }} b %}' -> '{{ a }} b'
%
%   SEE ALSO removeBraces

validateattributes(instr, {'char'}, {}, 'removeTagStarAndEndPat', 'instr')

outstr = regexprep(instr, ...
    {template.Template.TagStartPat, template.Template.TagEndPat}, '');
outstr = strtrim(outstr);

end