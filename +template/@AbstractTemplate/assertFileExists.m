function assertFileExists(obj)
%ASSERTFILEEXISTS Assert that obj.FileName exists.

isFileNameValid = exist(obj.FileName, 'file') == 2;
if ~isFileNameValid
    error('Template:assertFileExists:fileNotFound', ...
        'File "%s" was not found.', obj.FileName);
end

end