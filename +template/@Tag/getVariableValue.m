function val = getVariableValue(varargin)
%GETVARIABLEVALUE Get the value specified by variable epxression STR.
%   VAL = TEMPLATE.TAG.GETVARIABLEVALUE(STR, CONTEXT) returns VAL, the value 
%   specified in character array STR. CONTEXT is the Context object that is
%   used to render text from the Tag. Any whitespace and tag/variable
%   start/stop patterns in STR are ignored.
%
%   VAL = TEMPLATE.TAG.GETVARIABLEVALUE(STR, CONTEXT, 'LoopVariable', P, ...
%   'LoopVariableValue',Q) can be used to index a variable. For example, if
%   STR = 'myVar(ix)', LoopVariable = 'ix', and LoopVariableValue = 2, then
%   the value that results from evaluating myVar(2) will be returned in 
%   output VAL.

% Known limitations:
%   Indexing into Context.Map values is not supported. For example, if
%   Context.Map contains a key 'v' with value [1,2,3], the input STR =
%   'v(3)' will result in an error. The input must simply be 'v'.

opts = parseAndValidateInputs(varargin{:});

% Remove braces and extra whitespace.
str = template.Tag.removeBraces(opts.str);
str = strtrim(str);

% If str is a numeric or boolean scalar, get its value and return.
if template.Tag.isNumericVal(str)
    val = str2double(str);
    return
end
if template.Tag.isLogicalVal(str)
    if strcmpi(str,'true')
        val = true;
    else
        val = false;
    end
    return;
end

val = evaluateVariableExpression(str, opts);

end


%--------------------------------------------------------------------------
function val = evaluateVariableExpression(str, opts)

Context = opts.context;

exprInfo = parseExpressionWithBraces(str);

varExistsInMap = Context.isKey(str);
if exprInfo.HasBraces
    varExistsInMap = Context.isKey(exprInfo.VarName);
end

if varExistsInMap
    if exprInfo.HasBraces
        var = context.at(exprInfo.VarName);
        if strcmp(opts.LoopVariable, exprInfo.BracesContents)
            exprInfo.BracesContents = opts.LoopVariableValue;
        end
        if strcmp(exprInfo.BraceType,'paren')
            val = var(exprInfo.BracesContents);
        else % Expression has curly braces.
            val = var{exprInfo.BracesContents};
        end 
    else
        val = Context.at(str);
    end
else
    % Replace loop variable if provided.
    % For example, if the input is 'var(k)' and the loop variable is 'k'
    % with value 2, transform the input to 'var(2)'.
    if opts.LoopVarProvided
        str = doLoopVariableReplacement(str, opts.LoopVariable, ...
            opts.LoopVariableValue);
    end
    % Get the value specified by the input character array. If cmd cannot 
    % be evaluated, return empty char array ''.
    try
        val = eval(str);
    catch
        warning(['Engine:getVariableValue:evaluateVariableExpression:' ...
            'invalidCommand'], ...
            'Could not evaluate command\n%s\nReturning empty char.', ...
            str);
        val = '';
    end
end

end % evaluateVariableExpression


%--------------------------------------------------------------------------
function exprInfo = parseExpressionWithBraces(str)
% Parse an expression with braces.
% Returns a struct with variable name, brace type and contents of braces.
% If STR = 'myvar(1)', output has the following fields and associated
% values.
%
%   VarName         'myVar'
%   BraceType       'paren'
%   BracesContents  '1'
%   HasBraces       true

validateattributes(str, {'char'}, {})

exprInfo = struct('VarName', '-1', 'BraceType', '-1', ...
    'BracesContents', '-1', 'HasBraces', false);

hasParens = doesInputHaveParens(str);
hasCurlies = doesInputHaveCurlyBraces(str);
hasBraces = hasParens || hasCurlies;
exprInfo.HasBraces = hasBraces;
if hasParens && hasCurlies
    error('getVariableValue:parseExpressionWithBraces:unsupportedInput',...
        ['Input "%s" has more than one type of braces (parens or '      ...
        'curly braces). Only one type is allowed'], str);
end

if hasBraces
    if hasParens
        exprInfo.BraceType = 'paren';
        openingBrace = '(';
        closingBrace = ')';
    end
    if hasCurlies
        exprInfo.BraceType = 'curly';
        openingBrace = '{';
        closingBrace = '}';
    end
    brace1ix = strfind(str, openingBrace);
    brace2ix = strfind(str, closingBrace);
    exprInfo.VarName = strtrim( str(1:brace1ix-1) );
    exprInfo.BracesContents = strtrim( str(brace1ix+1 : brace2ix-1) );
end

end % parseExpressionWithBraces


%--------------------------------------------------------------------------
function opts = parseAndValidateInputs(varargin)

p = inputParser();
p.addRequired('str', @(s) ischar(s) || isstring(s));
p.addRequired('context', @(v) isa(v,'template.Context'));
defaultLoopVar = '-1';
p.addParameter('LoopVariable', defaultLoopVar, @ischar);
defaultLoopVarVal = -1;
p.addParameter('LoopVariableValue', defaultLoopVarVal, @isnumeric);
p.parse(varargin{:});

opts = p.Results;

% If input has parens, assert that loop variable PV pair inputs were
% provided by the user.
loopVarProvided = ~strcmp(opts.LoopVariable, defaultLoopVar);
% Make sure that LoopVariable and LoopVariableValue inputs are either (1)
% both not provided or (2) both provided.
loopVarValProvided = ~isequal(opts.LoopVariableValue, defaultLoopVarVal);
numLoopInputs = nnz([loopVarProvided,loopVarValProvided]);
numLoopInputsValid = numLoopInputs==0 || numLoopInputs==2;
if ~numLoopInputsValid
    error('Tag:getVariableValue:invalidInputCombination', ...
        ['When LoopVariable input is provided, LoopVariableValue must ' ...
        'also be provided.']);
end

opts.LoopVarProvided = loopVarProvided;

end


%--------------------------------------------------------------------------
function out = doLoopVariableReplacement(in, loopVar, loopVarValue)
loopVarValue = num2str(loopVarValue);
out = regexprep(in, ['\(\s*',loopVar,'\s*\)'], ['(',loopVarValue,')']);
end


%--------------------------------------------------------------------------
function tf = doesInputHaveParens(str)
validateattributes(str, {'char'}, {})
tf = contains(str,'(') && contains(str,')');
end


%--------------------------------------------------------------------------
function tf = doesInputHaveCurlyBraces(str)
validateattributes(str, {'char'}, {})
tf = contains(str,'{') && contains(str,'}');
end


%--------------------------------------------------------------------------
function tf = doesInputHaveBraces(str)
% Does input STR have braces ( () or {} )?
validateattributes(str, {'char'}, {})
tf = doesInputHaveParens(str) || doesInputHaveCurlyBraces(str);
end