% Make a function that reads an imagedirectory and creates a annotation for all the corresponding image files

function X = readImgDir(varargin)
uiwait(msgbox('Add the image directory now'));
imgdir = uigetdir;
if imgdir == 0
    return
end
uiwait(msgbox('Add the CADs Directory now'));
CADDir = uigetdir;
if CADDir == 0
    return
end
filepath = sprintf('%s/cads.mat',CADDir);
originalCad = load(filepath);
class_names = originalCad.class_names;
uiwait(msgbox('Add the annotation directory now'));
ann_dir = uigetdir;
if ann_dir == 0
    return
end
files = dir(sprintf('%s/*', imgdir));
files(1) = [];
files(1) = [];
no_of_imgfiles = length(files);
i = 1;
demo = load('demo.mat');
sample_object = demo.record.objects(1);
while i<=no_of_imgfiles
    temp = demo;
    filename = files(i).name;
    foldername = files(i).folder;
    merged_name = strcat(foldername,'\',filename);
    imread(merged_name)
    imshow(merged_name)
    temp.record.filename = filename;
    id = filename(1:end-4);
    prompt = sprintf('How many objects do you wish to add for %s',filename);
    no_of_objects = inputdlg(prompt);
    if length(no_of_objects) == 0
        return;
    end
    no_of_objects = str2num(no_of_objects{1});
    j = 1;
    objecttemp = sample_object;
    while j<= no_of_objects
        prompt = sprintf('Enter the class of the %d object',j);
        [indx,tf] = listdlg('PromptString',prompt,'SelectionMode','single','ListString',class_names)
        if tf == 0
            return
        end
        if j == 1
            temp.record.objects(1).class = class_names(indx);
            disp(j);
            j = j+1;
            continue;
        end
        disp(j);
        objecttemp.class = class_names(indx);
        temp.record.objects(j) = objecttemp;
        j = j+1;
    end
    disp(no_of_objects);
    annotation_path = sprintf('%s/%s.mat',ann_dir,id);
    record = temp.record;
    save(annotation_path,'record');
    fullpath = sprintf('%s/%s',imgdir,filename);
    try
        I = imread(fullpath);
    catch
        msg = sprintf('There is a problem reading %s',filename);
        msg_1 = sprintf('Please delete such files and continue later');
        uiwait(msgbox(msg));
        uiwait(msgbox(msg_1));
        return;
    end
    J = imresize(I,[500 500]);
    imwrite(J,fullpath);
    i = i+1;
end
uiwait(msgbox('Done creating annotation files, please check your annotation directory now'));