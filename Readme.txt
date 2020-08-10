Step 1: Add new Images
1. You can add new images using this button.
2. The UI will first ask you to add the new image directory(the directory where your new images are stored)
3. Next add your root CAD directory("yourpath/roots/cad")
4. Add your root annotation directory("yourpath/root/Annotation")
5. Then for every image add the number of objects and add the class names for all these objects from the list
6. Copy these images from your directory, to the root images folder.
7. Now all these new images can be annotated.

Step 2: Start Annotating
1. Click on this button to start annotating
2. Click on open annotation directory and select the annotation directory from the root directory you downloaded in step 1
3. Now similarly, add the image and the cad directory

Step 3: Output Images
1. The annotations generated would be stored in the png file.
2. Add the root directory first.
3. Enter the output directory then
4. All your images would now be stored in the output directory

Step 4: Store JSON Output
1. First add the root annotation directory.
2. Once that is done, select the directory where you wish to store all your outputs
3. That's it, wait until the message pops out to say that the JSON output files have been stored

Step 5: Display CAD Model Output(Optional Output)
1. You can display CAD Models, such that the entire image is dark and only the CAD model is displayed.
2. The UI will first ask you to enter the root directory
3. Later the UI will ask you to enter the output directory, go ahead and add the output directory(this is the directory, where you want your images to get stored)
4. That's it, now you simply need to wait for the function to stop.

Step 6: Add CAD Models(Optional)(Function supported for obj files)
1. Sometimes, the CAD Model required by the user might not be there.
2. Thus, the user can input his/her own CAD model.
3. The UI will ask you to add the root cad directory. Add the "root(here root means the location where you stored the root folder)"/CAD as the cad directory
4. The UI will ask you to add the directory where all your obj files are stored.
5. Go ahead and select that directory
6. You will be asked to add the class names for all these obj files.
7. Add them very carefully.
8. Next you would be asked to enter the folder where you wish to download the new CAD file, simply select the folder where you wish to download the cad file.
9. A cads.mat file will be created and note that this is the new cad file. You can replace this new cad file with the cads.mat file with root/CAD/cads.mat file.
10. The CAD models would be added.
