classdef AbstractTemplate < handle
    % Abstract class for templates.
    
    % See abstract properties below. These properties were made abstract so
    % that the derived class (see Template) can specify implementation 
    % details. This allows for flexibility in template format.
    
    properties
        % TemplateText
        %   A character array that contains the text contents of the 
        %   template.
        TemplateText = ''
        % RenderedText
        %   A character array that contains the rendered template text.
        RenderedText = ''
        % FileName
        %   A character array containing the name of a template file.
        FileName = ''
    end
    
    methods
        readFile(obj, varargin)
        render(obj, ctxt)
    end
    
    methods
        function set.FileName(obj,value)
            validateattributes(value, {'char'}, {})
            obj.FileName = value;
        end
        
        function set.TemplateText(obj,value)
            validateattributes(value, {'char'}, {})
            obj.TemplateText = value;
        end
    end
    
    
    methods (Access = private)
        assertFileExists(obj)
        parse(obj, ctxt)
        findTags(obj)
        constructTagObjects(obj)
        renderTags(obj, ctxt)
    end
    
    methods (Static, Access={?template.Tag})
        str = escapeSpecialCharacters(str)
    end
    
    methods (Static, Access = {?template.Tag})
        pat = createBeginTagRegexPat(keyword)
        pat = createEndTagRegexPat(keyword)
        pat = createTagRegexPat(keyword)
        tagType = getTagTypeFromTagString(tagStr)
    end
    
    properties (Abstract, Constant, GetAccess={?template.Tag})
        % TagStartPat 
        %   Marks the beginning of a tag expression.
        TagStartPat
        % TagEndPat 
        %   Marks the end of a tag expression.
        TagEndPat
        % VarStartPat
        %   VarStartPat pattern marks the beginning of a variable 
        %   expression.
        VarStartPat
        % VarEndPat
        %   VarEndPat marks the end of a variable expression.
        VarEndPat
        
        % TagKeywords
        %   Stores the tag keywords that are expected to be found at the 
        %   beginning of each tag.
        TagKeywords
        
        % CharactersToEscape
        %   CharactersToEscape are escaped in regex operations.
        CharactersToEscape
        % ValidOperators
        %   A list of supported operators (in tag {%...%} logic).
        ValidOperators
    end
    
    properties (Access = private)
        % Tags
        %   A cell array containing Tag objects.
        Tags
        % RawTags
        %   A cell array containing tags obtained from TemplateText. Each
        %   element of RawTags is a character array containing one tag
        %   (includes TagStartPat and TagEndPat).
        RawTags
        % TagStartIxs
        %   TagStartIxs is an array containing the indices of each 
        %   TagStartPat stringn in TemplateText.
        TagStartIxs
        % TagStopIxs
        %   TagStopIxs is an array containing the indices of each 
        %   TagEndPat stringn in TemplateText.
        TagStopIxs
    end
    
end