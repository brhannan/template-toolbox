function parse(obj, ctxt)
%PARSE Parse a template.
%   TEMPLATE.PARSE identifies all tags in TemplateText. The tags are stored
%   in the Tags property.

validateattributes(ctxt, {'template.Context'}, {})

obj.findTags();
obj.constructTagObjects();
obj.renderTags(ctxt);

end