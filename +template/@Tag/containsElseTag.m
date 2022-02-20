function tf = containsElseTag(tagStr)
%CONTAINSELSETAG Returns true if Tag contains one or more ELSE/ELSEIF tags.

validateattributes(tagStr, {'char','string'}, {})

elseTagPat = template.Template.createTagRegexPat('else');
elseIxs = regexpi(tagStr, elseTagPat);

elseifTagPat = template.Template.createTagRegexPat('elseif');
elseifIxs = regexpi(tagStr, elseifTagPat);

tf = ~isempty([elseIxs, elseifIxs]);

end