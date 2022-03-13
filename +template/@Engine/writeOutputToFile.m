function writeOutputToFile(obj)
%ENGINE.WRITEOUTPUTTOFILE Write rendered text to output file.

fid = fopen(obj.OutputFile,'w');
fprintf(fid, obj.RenderedText);
fclose(fid);

end