classdef Tag < handle
    %TEMPLATE.TAG Template language tag.
    %   T = TEMPLATE.TAG(TEXT) creates a TAG object from tage text TEXT. 
    %   TEXT is a character array or string containing a tag. A tag is 
    %   expected to have a form such as '{% if x %} ... {% endif %}'.
    %
    %   Tag objects are used to store tag text and to transform it into an
    %   intermediate representation that may be used by an Engine object to
    %   render output text.
    %
    %   % EXAMPLE:
    %       t = template.Tag('{% if true %} hello world {% endif %}')
    %       t.parse
    
    properties
        % TemplateText
        %   A character array containing the original tag text.
        TemplateText = ''
        % RenderedText
        %   A character array containing the output text produced by
        %   calling Tag.render().
        RenderedText = ''
    end
    
    methods
        render(obj, ctxt)
        tf = isIf(obj)
        tf = isFor(obj)
        tf = isComment(obj)
    end
    
    methods
        function obj = Tag(text)
            p = inputParser();
            p.addRequired('TemplateText', @(s) ischar(s) || isstring(s));
            p.parse(text);
            obj.TemplateText = p.Results.TemplateText;
        end
        
        function set.TemplateText(obj, val)
            validateattributes(val, {'char','string'}, {});
            if isstring(val)
                val = char(val);
            end
            obj.TemplateText = val;
        end
        
        function set.Type(obj, val)
            validateattributes(val, {'template.TagType'}, {});
            obj.Type = val;
        end
    end
    
    
    properties (Access = private)
        % Type
        %   Indicates the tag type (example: if, for). Type is an enum
        %   (template.TagType).
        Type
        % IsIfElse
        %   Indicates whether the tag contains else/elseif block(s).
        IsIfElse
        % Parts
        %   A cell array that separates the major parts of the tag.
        Parts
        % TagStartPatternIxs
        %   An array of indices that mark the start of each start pattern.
        TagStartPatternIxs
        % TagStopPatternIxs
        %   An array of indices that mark the start of each stop pattern.
        TagStopPatternIxs
        % LoopLowerBound
        %   A character array containing the lower boundary of a FOR loop.
        LoopLowerBound
        % LoopUpperBound
        %   A character array containing the upper boundary of a FOR loop.
        LoopUpperBound
        % LoopVariable
        %   A character array containing the name of a for loop's iterator
        %   variable.
        LoopVariable
        %ConditionalText
        %   A character array containing the code to be evaluated. For
        %   example, in the IF statement "if x>y, disp('hello'), end", the
        %   value of ConditionalText is 'x>y'.
        ConditionalText
        % Body
        %   A character array containing the body of the tag text. For
        %   example, in the tag '{% if true %} hello world {% endif %}', 
        %   the body is 'hello world'.
        Body = ''
        % TagControlTokens
        %   A cell array containing the parts of the tag wrapped in 
        %   {% ... %}. For example, if the tag is 
        %   '{% if true %} x {% else %} y {% endif %}', then
        %   TagControlTokens has the value
        %   { '{% if true %}', '{% else %}', '{% endif %}' }
        TagControlTokens
    end
    
    methods (Access = private)
        parse(obj)
        parseBeginningOfTag(obj, context)
        validateTagFormat(obj)
        segmentTagStringAndSetPartsProperty(obj)
        segmentTagText(obj)
        getTagStartAndStopPatternIxs(obj)
        validateNumTagStartAndStopPatterns(obj)
        tf = evaluateIfStatement(obj, ctxt)
        errorIfTagTypeUnset(obj)
    end
    
    methods (Static, Access = private)
        tf = isNumericVal(str)
        tf = isLogicalVal(str)
        str = escapeSpecialCharacters(str)
        outStr = getIfStatementLogicToTest(beginTagStr)
    end
    
    methods (Static, Access = {?template.AbstractTemplate})
        vars = getVariableExpressions(str)
        outstr = removeBraces(instr)
    end
    
    methods (Static, Access={?template.Engine,?template.AbstractTemplate})
        val = getVariableValue(varargin)
    end
    
end