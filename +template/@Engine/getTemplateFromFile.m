function getTemplateFromFile(obj, varargin)
%GETTEMPLATEFROMFILE Read a template from file.
%   TEMPLATE.GETTEMPLATEFROMFILE(FILENAME) reads the file specified
%   by character array FILENAME. The contents of FILENAME are
%   stored in the TemplateText property.

narginchk(1,2)
fileNameProvided = false;
if nargin > 1
    fileName = varargin{1};
    fileNameProvided = true;
end

if fileNameProvided
    obj.TemplateFileName = fileName;
end

obj.Template.FileName = fileName;
obj.Template.readFile();

end