classdef Engine < handle
%ENGINE Template engine.
%   ENG = TEMPLATE.ENGINE creates an instance of the template code  
%   generation system.
%
%   ENGINE methods:
%       getTemplateFromFile()   -   Initialize template from file.
%       getTemplateFromText()   -   Initialize template from a  
%                                   user-provided character array or 
%                                   string.
%       render()                -   Render output text.
%       add()                   -   Add a new variable map name/value pair.
%       remove()                -   Remove a variable map name/value pair.
%       keys()                  -   Return map keys.
%       at()                    -   Get a map value.
%       
%   ENGINE properties:
%       RenderedText     - A character array contianing the rendered 
%                          output text.
%       TemplateFileName - A character array containing a template file
%                          name. If the template text was provided by the 
%                          user, this property is an empty character array 
%                          ('').
%
%
%   % EXAMPLE 1:
%       % Provide a template and a variable name/value pair that maps all
%       % instances of 'myVar' to 'world'.
%       eng = template.Engine;
%       eng.getTemplateFromText('hello {{ myVar }}');
%       eng.add('myVar','world');
%       renderedText = eng.render
%
%   % EXAMPLE 2:
%       % Read a template file named myTemplate.tmpl and render output.
%       eng = template.Engine;
%       eng.getTemplateFromFile('myTemplate.tmpl');
%       eng.add('myVar','world');
%       renderedText = eng.render
%
%   % EXAMPLE 3:
%       % Read a template file named myTemplate.txt and render output.
%       eng = template.Engine;
%       eng.getTemplateFromFile('myTemplate.txt');
%       eng.add('myVar','world');
%       renderedText = eng.render

    properties
        % RenderedText
        %   A character array containing the rendered result.
        RenderedText = ''
        % TemplateFileName
        %   A character array containing the name of a file that contains a
        %   template.
        TemplateFileName = ''
        % OutputFile
        %   The name (and optionally path) of a file that the output will
        %   be written to.
        OutputFile = ''
    end
    
    methods
        function obj = Engine(varargin)
            p = inputParser();
            p.addParameter('TemplateText', '', @(s) isstring(s) || ...
                ischar(s));
            p.addParameter('Template', template.Template(), ...
                @(v) isa(v, 'template.Template'));
            p.addParameter('Context', template.Context(), ...
                @(v) isa(v, 'template.Context'));
            p.addParameter('RenderedText', '-1', ...
                @(s) ischar(s) || isstring(s));
            p.parse(varargin{:});
            obj.Template = p.Results.Template;
            obj.Context = p.Results.Context;
            obj.RenderedText = p.Results.RenderedText;
            % Set Template object's TemplateText property.
            obj.Template.TemplateText = p.Results.TemplateText;
        end
        
        function set.TemplateFileName(obj, value)
            validateattributes(value, {'char','string'}, {})
            obj.TemplateFileName = value;
            obj.Template.readFile();
        end
        
        function set.OutputFile(obj, val)
            validateattributes(val, {'char','string'}, {});
            obj.OutputFile = val;
        end
    end
    
    methods
        getTemplateFromFile(obj, varargin)
        getTemplateFromText(obj, text)
        
        varargout = render(obj)
        
        add(obj, name, value)
        remove(obj, name)
        keyset = keys(obj)
        value = at(obj, name)
    end
    
    
    properties (Access = private)
        TemplateText
        Template
        Context
        IsSimulinkTemplate
    end
    
end
