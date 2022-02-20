function pat = createBeginTagRegexPat(keyword)
%CREATEBEGINTAGREGEXPAT Create a beginning tag regex pattern.
%   PAT = TEMPLATE.TEMPLATE.CREATEBEGINTAGREGEXPAT(KEYWORD) creates a regex 
%   pattern that may be used to identify a keyword-specific beginning tag 
%   in a string. Output PAT is a character array containing a regex pattern
%   that will match a beginning tag pattern for keyword KEYWORD (character
%   array).
%
%   A beginning tag has the following form.
%       'TB keyword <arbitrary logic may go here> TE'
%   In the tag above, TB and TE represent TagStartPat and TagEndPat (see
%   template.AbstractTemplate). Examples of valid tag start patterns may be
%   the folowing:
%       '{% if %}', '{% for k = 1:3 %}', '{% comment %}'
%
%   Leading/trailing whitespaces are ignored.

validateattributes(keyword, {'char','string'}, {})

% In a beginning tag, the keyword is preceeded only by optional whitespace.
% Any characters may follow the keyword.
pat = sprintf('%s\\s*%s.*?%s', ...
    template.Template.escapeSpecialCharacters(template.Template.TagStartPat), ...
    keyword, ...
    template.Template.escapeSpecialCharacters(template.Template.TagStartPat));

end