function getTagStartAndStopPatternIxs(obj)
% Identifies the location of all tag start/end patterns and stores the 
% results at TagStartPatternIxs and TagStopPatternIxs.

tagStartIxs = regexp(obj.TemplateText, template.Template.TagStartPat);
tagStopIxs = regexp(obj.TemplateText, template.Template.TagEndPat);
obj.TagStartPatternIxs = tagStartIxs;
obj.TagStopPatternIxs = tagStopIxs;

end