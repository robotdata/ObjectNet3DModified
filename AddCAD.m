%Add a new CAD Model
function a = AddCAD(varargin)
uiwait(msgbox('Add the root CAD directory now'));
CADDir = uigetdir;
if CADDir == 0
    return
end
filepath = sprintf('%s/cads.mat',CADDir);
original_Cad = load(filepath);
l = length(original_Cad.cads);
uiwait(msgbox('Add the root Obj Files directory now'));
objDir = uigetdir;
if objDir == 0
    return 
end
objFiles = dir(sprintf('%s/*.obj', objDir));
no_of_objFiles= length(objFiles);
i = 1;
while i<=no_of_objFiles
    filename = objFiles(i).name;
    [V,F3,F4] = load_obj_file(filename,objDir);
    prompt = sprintf('Give the classname for %s',filename);
    classname = inputdlg(prompt);
    disp(class(classname{1}));
    original_Cad.class_names{l+i,1} = classname{1};
    new_V = transpose(V);
    new_F3 = transpose(F3);
    new_F4 = transpose(F4);
    new_struct.vertices = new_V;
    new_struct.faces = new_F3;
    new_struct.face4 = new_F4;
    new_struct.azimuth_extent = [];
    original_Cad.cads{l+i,1} = new_struct;
    i = i + 1;
end
cads = original_Cad.cads;
class_names = original_Cad.class_names;
uiwait(msgbox('Enter the folder where you want to store the new CAD file'));
newCadDir = uigetdir;
filepath = sprintf('%s/cads.mat',newCadDir);
save(filepath,'cads','class_names');
