classdef Context < handle
    % CONTEXT A Context object can be used to render a Template.
    %   CONTEXT objects store variable names and values that are used to
    %   fill a template.
    %
    %   % EXAMPLE:
    %       ctxt = Context()
    %       ctxt.add('x', 2)
    %       ctxt.add('y', 'hello')
    %       ctxt.at('x')
    %       ctxt.at('y')
    
    properties
        % Map
        %   A containers.Map object that stores variable names/values.
        Map
    end
    
    methods
        function obj = Context(varargin)
            p = inputParser();
            defaultMap = containers.Map();
            p.addParameter('Map', defaultMap, ...
                @(v) isa(v,'containers.Map'));
            p.parse(varargin{:});
            % Set properties from input PV pairs.
            inputParams = fields(p.Results);
            for np = 1:numel(inputParams)
                obj.(inputParams{np}) = p.Results.(inputParams{np});
            end
        end
        
        function set.Map(obj, value)
            validateattributes(value, {'containers.Map'}, {})
            obj.Map = value;
        end
    end
    
    methods
        add(obj, name, value)
        remove(obj, name)
        value = at(obj, name)
        tf = isKey(obj, key)
        keyset = keys(obj)
    end
    
    
    properties (Access = protected, Constant)
        % Elements of ReservedKeywords may not be used as variable names.
        ReservedKeywords = { 'Context' }
    end
    
    methods (Access = protected)
        assertNameIsNotReserved(obj, name)
    end
    
end