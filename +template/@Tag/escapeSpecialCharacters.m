function str = escapeSpecialCharacters(str)
%ESCAPESPECIALCHARACTERS Escape special characters in input string.
%   TAG.ESCAPESPECIALCHARACTERS(STR) escapes any special characters in 
%   input STR (a character array or string) by prepending each special 
%   character with a backslash.

validateattributes(str, {'char','string'}, {})

addEscapeBeforeChar = @(s, oper) strrep(s, oper, sprintf('\\%s',oper));

for operatorString = template.Template.CharactersToEscape
    str = addEscapeBeforeChar(str, operatorString{1});
end

end