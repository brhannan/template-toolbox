function getTemplateFromText(obj, text)
%GETTEMPLATEFROMTEXT Prodcue template from text input.

validateattributes(text, {'char'}, {})
obj.Template = template.Template('TemplateText', text);

end