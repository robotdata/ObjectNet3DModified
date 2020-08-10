# ObjectNet3DModified
This is a modified code for the ObjectNet3D toolbox. The original object net 3D toolbox is https://github.com/yuxng/ObjectNet3D_toolbox.

### New Added Features: 
1. Initially, the object net 3D toolbox simply had jpeg images getting annotated, we have modified the code and all formats can now be annotated using the new tool.
2. Now, we can have user controlled bounding boxes.
3. The script AddCAD.m is used to add new cad models into the root cads file. This is a new feature.
4. The script Display_White_CAD.m is used to display only the CAD models and the corresponding image becomes black.
5. The script quadmesh.m is a new script added inorder to read quadmeshes along with trimesh. The original objectNet3D only supported Trimeshes.
6. The script readAnnotation files is used to read the annotation files and create JSON output annotations.
7. The readImgDir.m is used to create annotation files of the newly added images.

#### How to use the tool?
1. Download the executable file from 
2. Once downloaded install it and start using refering to the readme document as shown in the application.
