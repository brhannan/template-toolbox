function renderTags(obj, ctxt)
%RENDERTAGS Render all Tag objects storedin Tags property.

validateattributes(ctxt, {'template.Context'}, {})

for nt = 1:numel(obj.Tags)
    tagObj = obj.Tags(nt);
    tagObj.render(ctxt);
end

end