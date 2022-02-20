function assertNameIsNotReserved(obj, name)
% Check whether input NAME is a reserved keyword. Errors if NAME is a
% reserved keyword.

validateattributes(name, {'char','string'}, {})

isReserved = contains( lower(name), lower(obj.ReservedKeywords) );
if isReserved
    error('Context:assertNameIsNotReserved:varNameIsReserved', ...
        ['Reserved keyword "%s" may not be used as a ' ...
        'variable name.'], name);
end

end