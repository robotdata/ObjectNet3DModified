function X = readAnnotationFiles(varargin)
uiwait(msgbox('Add your annotation directory'));
anndir = uigetdir;
if anndir == 0
    return
end
uiwait(msgbox('Add your output directory'));
outputdir = uigetdir;
files = dir(sprintf('%s/*',anndir));
files(1) = [];
files(1) = [];
no_of_annotationfiles = length(files)
i = 1;
while i<=no_of_annotationfiles
    name = files(i).name
    folder = files(i).folder
    read_file = strcat(folder,'\',name)
    file_mat = load(read_file)
    get_json = file_mat.record 
    json_file = jsonencode(get_json)
    exact_name = name(1:end-4)
    fileoutput = strcat(exact_name,'.','json')
    outputlocation = strcat(outputdir,'\',fileoutput)
    fileID = fopen(outputlocation,'w');
    fprintf(fileID,'%s',json_file)
    fclose(fileID)
    i=i+1
end
uiwait(msgbox('Thanks we have saved the annotations in json format'))