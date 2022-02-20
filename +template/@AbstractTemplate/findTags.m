function findTags(obj)
%FINDTAGS Finds all tags in a template. The results are stored to Tags
% property.

[begTags, endTags] = findBeginAndEndTags(obj);
checkForBalancedNumTags(obj, begTags, endTags);

numTags = numel(begTags);
obj.RawTags = cell(1, numTags);

% Store the index of the end of the region of the template that has been  
% scanned so far.
templateScanIx = 0;

for nt = 1:numTags
    begTag = begTags{nt};
    endTag = endTags{nt};
    % Find all instances of this beginning and ending tag.
    ixsBegTag = strfind(obj.TemplateText, begTag);
    ixsEndTag = strfind(obj.TemplateText, endTag);
    % Get the 1st index of the begin/end tags that occur in the un-scanned
    % portion of the template.
    ixBeginTag = getFirstArrayValGreaterThanThresh(ixsBegTag, ...
        templateScanIx);
    ixEndTag = getFirstArrayValGreaterThanThresh(ixsEndTag, ...
        templateScanIx);
    obj.RawTags{nt} = obj.TemplateText(ixBeginTag : ...
        ixEndTag + length(endTag) - 1);
end

end


%--------------------------------------------------------------------------
function checkForBalancedNumTags(obj, begTags, endTags)

if numel(begTags) ~= numel(endTags)
    error('Template:findTags:unbalancedBeginAndEndTagPatterns', ...
        ['The number of beginning and ending tag patterns ' ...
        '(%s <keyword> %s ... %s end<keyword> %s) was unbalanced.'], ...
        obj.TagStartPat, obj.TagEndPat, obj.TagStartPat, obj.TagEndPat);
end

end


%--------------------------------------------------------------------------
function [beginTags, endTags] = findBeginAndEndTags(obj)
% Returns cell arrays containing all beginning and ending tags found in
% the template. Outputs are not guaranteed to be unique.

[beginTagPat, endTagPat] = getBeginAndEndTagPatterns(obj);
beginTags = getTextThatMatchesTagPattern(obj.TemplateText, beginTagPat);
endTags = getTextThatMatchesTagPattern(obj.TemplateText, endTagPat);

end


%--------------------------------------------------------------------------
function tags = getTextThatMatchesTagPattern(templateText, tagPat)
% Perform a case-independent regex operation to return all tokens in
% templateText that match the pattern tagPat. Output is a cell array of the
% tokens returned by the regex operation.

tags = regexpi(templateText, tagPat, 'match');
% Remove empty elements.
tags(cellfun(@isempty, tags)) = [];
% Remove extra layer of cell.
for k = 1:numel(tags)
    tags{k} = tags{k}{1};
end

end


%--------------------------------------------------------------------------
function [beginTagPat, endTagPat] = getBeginAndEndTagPatterns(obj)
% Returns regex patterns for tag beginning and end. Each output is a cell
% array of character arrays, one for each element of TagKeywords.

numKeywords = numel(obj.TagKeywords);

beginTagPat = cell(1, numKeywords);
endTagPat = cell(1, numKeywords);

for nKeyword = 1:numKeywords
    beginTagPat{nKeyword} = template.Template.createBeginTagRegexPat( ...
                                            obj.TagKeywords{nKeyword});
    endTagPat{nKeyword} = template.Template.createEndTagRegexPat( ...
                                            obj.TagKeywords{nKeyword});
end

end


%--------------------------------------------------------------------------
function val = getFirstArrayValGreaterThanThresh(array, thresh)
% Returns the 1st element of array that is greater than thresh.

isAboveThresh = array > thresh;
if all(isAboveThresh == false)
    error('Template:findTags:getFirstArrayValGreaterThanThresh', ...
        'Problem encountered while searching for tags in template.');
end

ixFirstAboveThreshElem = find(isAboveThresh, 1);
val = array(ixFirstAboveThreshElem);

end