classdef Template < template.AbstractTemplate
    
    methods
        function obj = Template(varargin)
            p = inputParser();
            p.addParameter('TemplateText', '-1', @ischar);
            p.parse(varargin{:});
            obj.TemplateText = p.Results.TemplateText;
        end
    end
    
    properties (Constant, GetAccess={?template.Tag})
        % TagStartPat
        %   TagStartPat marks the beginning of a tag expression.
        TagStartPat = '{%'
        % TagEndPat
        %   TagEndPat marks the end of a tag expression.
        TagEndPat = '%}'
        % VarStartPat
        %   VarStartPat pattern marks the beginning of a variable 
        %   expression.
        VarStartPat = '{{'
        % VarEndPat
        %   VarEndPat marks the end of a variable expression.
        VarEndPat = '}}'
        
        % TagKeywords
        %   Stores the tag keywords that are expected to be found at the 
        %   beginning of each tag.
        TagKeywords = { 'for', 'if', 'comment' }
        
        % CharactersToEscape
        %   CharactersToEscape are escaped in regex operations.
        CharactersToEscape = { '(', ')', '+', '-', '*', '/', '%', ...
            '{', '}' }
        % ValidOperators
        %   A list of supported operators (in tag {%...%} logic).
        ValidOperators = { '>', '>=', '<', '<=', '~=', '==' }
    end
    
end