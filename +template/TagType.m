classdef TagType < uint8
    %TEMPLATE.TAGTYPE Tag type enumeration.
    
    enumeration
        IF (0)
        FOR (1)
        COMMENT (2)
    end
    
    methods (Static)
        
        function default = getDefaultValue()
            default = template.TagType.IF;
        end
        
        function types = getValidTagTypeStrings()
            % Returns a cell array containing the valid type strings.
            types = {'if', 'for', 'comment'};
        end
        
        function tagType = stringToTagType(str)
            % Converts a string to template.TagType.
            validateattributes(str, {'char','string'}, {})
            switch lower(str)
                case 'if'
                    tagType = template.TagType.IF;
                case 'for'
                    tagType = template.TagType.FOR;
                case 'comment'
                    tagType = template.TagType.COMMENT;
                otherwise
                    error('Tag:stringToTagType:invalidKeyword', ...
                        'Invalid keyword "%s". Allowed keywords are: %s.', ...
                        str, strjoin(obj.ValidTagTypes, ', '));
            end
        end
        
    end
    
end