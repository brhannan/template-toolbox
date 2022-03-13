function outstr = removeBraces(instr)
%REMOVEBRACES Remove braces (parens or curly braces) from input.
%   OUTSTR = TAG.REMOVEBRACES(INSTR) removes the braces 
%   ( {% ... %} or {{ ... }} ) from INSTR and returns the result in OUTSTR.
%   INSTR and OUTSTR are character arrays.
%
%   Examples:
%       '{{ a b c }}'     -> 'a b c'
%       '{% p q %}        -> 'p q'
%
%   SEE ALSO removeTagStarAndEndPat

validateattributes(instr, {'char'}, {}, 'removeBraces', 'instr')

outstr = regexprep(instr, ...
    {template.Template.VarStartPat, template.Template.VarEndPat, ...
    template.Template.TagStartPat, template.Template.TagEndPat}, '');
outstr = strtrim(outstr);

end