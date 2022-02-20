function pat = createTagRegexPat(keyword)
%CREATETAGREGEXPAT Create a tag regex pattern.
%   PAT = TEMPLATE.TEMPLATE.CREATETAGREGEXPAT(KEYWORD) creates a regex 
%   pattern that may be used to identify a keyword-specific tag in a 
%   string. Output PAT is a character array containing a regex pattern
%   that will match a tag pattern for keyword KEYWORD (character
%   array).
%
%   This function is not intended to be used to create patterns for
%   beginning/ending tag patterns. Instead, use this function for tags that
%   appear between begin/end tags. Example: else/elseif tags.
%
%   Leading/trailing whitespaces are ignored.
%
%   % EXAMPLE:
%       % When TagStartPat is '{%' and TagEndPat is '%}', the call below 
%       % will return a regex pattern that can be used to find instances 
%       % of '{% else %}' in a template.
%       template.Template.createTagRegexPat('else')

validateattributes(keyword, {'char','string'}, {})

% In an end tag, the end<keyword> string is preceeded/followed only by  
% optional whitespace.
pat = sprintf('%s\\s*%s\\s*?%s', ...
    template.Template.escapeSpecialCharacters(template.Template.TagStartPat), ...
    keyword, ...
    template.Template.escapeSpecialCharacters(template.Template.TagEndPat));

end