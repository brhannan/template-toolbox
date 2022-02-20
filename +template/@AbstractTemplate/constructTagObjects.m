function constructTagObjects(obj)
%CONSTRUCTTAGOBJECTS Creates Tag objects from the contents of the RawTag
% property. The resulting Tag objets are put into an array, which is stored
% in the Tags property.

numTags = numel(obj.RawTags);

% Initialize an array of Tag objects.
obj.Tags = repmat(template.Tag(''), 1, numTags);

for nt = 1:numTags
    tagText = obj.RawTags{nt};
    obj.Tags(nt) = template.Tag(tagText);
end

end