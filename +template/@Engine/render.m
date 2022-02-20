function varargout = render(obj)
%RENDER Render text from template and context.
%   ENGINE.RENDER renders the template stored in the Engine
%   object's Template property using the contents of the
%   Context property. The result is stored in the RenderedText
%   property.
%
%   S = ENGINE.RENDER renders the template and stores the
%   result in the RenderedText property. The contents of
%   RenderedText are output in character array S.

% Make sure the Template object's file name property has been updated.
obj.Template.FileName = obj.TemplateFileName;

obj.Template.render(obj.Context);
obj.RenderedText = obj.Template.RenderedText;

% Output rendered text if requested.
if nargout
    varargout{1} = obj.RenderedText;
end

end