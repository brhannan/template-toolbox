function readFile(obj, varargin)
%READFILE Read a template file and store its contents.
%   TEMPLATE.READFILE(FILENAME) sets the FileName
%   property of the Template object to FILENAME (character array). The file
%   is read and its contents are stored to the TemplateText property.
%
%   TEMPLATE.READFILE() called with no input arguments reads the file with 
%   the name that is specified by the Template object's TemplateFile 
%   property and stores the contents to the TemplateText property.

narginchk(1, 2)
if nargin > 1
    fileName = varargin{1};
    validateattributes(fileName, {'char'}, {})
    obj.FileName = filename;
end

% Take no action if FileName property is unset. This allows Engine.render()
% to call readFile() when FileName was not provided.
if ~isempty(obj.FileName)
    obj.assertFileExists();
    obj.TemplateText = fileread(obj.FileName);
end

end