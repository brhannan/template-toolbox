function pat = createEndTagRegexPat(keyword)
%CREATEENDTAGREGEXPAT Create an end tag regex pattern.
%   PAT = TEMPLATE.TEMPLATE.CREATEENDTAGREGEXPAT(KEYWORD) creates a regex 
%   pattern that may be used to identify a keyword-specific end tag in a 
%   string. Output PAT is a character array containing a regex pattern
%   that will match an end tag pattern for keyword KEYWORD (character
%   array).
%
%   An end tag has the following form.
%       'TB end<keyword> TE'
%   In the tag above, TB and TE represent TagStartPat and TagEndPat (see
%   template.AbstractTemplate). Examples of valid tag end patterns may be
%   the folowing:
%       '{% endif %}', '{% endfor %}', '{% endcomment %}'
%
%   Leading/trailing whitespaces are ignored.

validateattributes(keyword, {'char','string'}, {})

% In an end tag, the end<keyword> string is preceeded/followed only by  
% optional whitespace.
pat = sprintf('%s\\s*end%s\\s*?%s', ...
    template.Template.escapeSpecialCharacters(template.Template.TagStartPat), ...
    keyword, ...
    template.Template.escapeSpecialCharacters(template.Template.TagEndPat));

end