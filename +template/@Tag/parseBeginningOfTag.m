function parseBeginningOfTag(obj)
%PARSEBEGINNINGOFTAG Parse the contents of 1st part of a tag {% ... %}.

obj.Type  = template.Template.getTagTypeFromTagString(obj.TemplateText);

if obj.isFor
    parseForTag(obj);
elseif obj.isIf
    parseIfTag(obj);
elseif obj.isComment
    % No action is necessary a comment.
else
    error('Tag:parseBeginningOfTag:invalidTagType', ...
        'Unrecognized tag type.');
end

end


%--------------------------------------------------------------------------
function parseForTag(obj)
% FOR tag must have the form {% for X = Y:Z %}. This has four "parts":
% FOR, X, =, Y:Z.

beginTagParts = strsplit(obj.removeBraces(obj.Parts{1}), ' ');

isTagLengthValid = numel(beginTagParts) == 4;
if ~isTagLengthValid
    error('Tag:parseBeginningOfTag:invalidForTagLength', ...
        ['Tag "%s" is invalid. FOR tags must contains 4 ', ...
        'space-separated elements. Example: ' ...
        '{% for X in Y %}.'], obj.TemplateText);
end

obj.LoopVariable = beginTagParts{2};
if ~strcmpi(beginTagParts{3},'=')
    error('Tag:parseBeginningOfTag:invalidForTagFormat', ...
        ['Tag\n"%s"\nis invalid. The 3rd element of the beginning of ', ...
        'the tag must be "=".'], obj.TemplateText);
end

% Element 4 has form A:B.
loopBounds = beginTagParts{4};
validateLoopBoundString(loopBounds);
loopBoundsParts = strsplit(loopBounds, ':');
assert(numel(loopBoundsParts) == 2)
obj.LoopLowerBound = loopBoundsParts{1};
obj.LoopUpperBound = loopBoundsParts{2};

end


%--------------------------------------------------------------------------
function validateLoopBoundString(loopBound)
%VALIDATELOOPBOUND Assert that LOOPBOUND has form 'X:Y'.

validateattributes(loopBound, {'char','string'}, {})
loopBoundHasExpForm = regexp(loopBound,'\S+:\S+') == 1 ...
        && numel(strfind(loopBound,':')) == 1;
if ~loopBoundHasExpForm
    error('Tag:parseBeginningOfTag:invalidLoopBoundFormat', ...
        ['Loop boundary string "%s" is invalid. Loop boundaries ' ...
        'are expected to have the form "X:Y".'], ...
        loopBound);
end

end


%--------------------------------------------------------------------------
function parseIfTag(obj)

beginTagParts = strsplit(obj.removeBraces(obj.Parts{1}), ' ');

beginTagText = obj.removeBraces(obj.Parts{1});
obj.ConditionalText = strtrim(regexprep(beginTagText, 'if', '', 'once'));

% TODO: remove Object<1/2> code.
obj.Object1 = beginTagParts{2};
if numel(beginTagParts) > 2 % Form is {% if X OPER Y %}
    % Validate operator string.
    obj.Operator = beginTagParts{3};
    obj.Object2 = beginTagParts{4};
end

end