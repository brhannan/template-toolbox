function replaceTagsWithRenderedText(obj)
%REPLACETAGSWITHRENDEREDTEXT Replace tags in TemplateText with the text
% that was rendered by each Tag object.

numTags = numel(obj.Tags);
obj.RenderedText = obj.TemplateText;
for nTag = 1:numTags
    tagObj = obj.Tags(nTag);
    obj.RenderedText = strrep(obj.RenderedText, tagObj.TemplateText, ...
        tagObj.RenderedText);
end

end