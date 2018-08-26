  list = getList("image.titles");
	if (list.length <= 0) { 
		exit("Error: No valid images open")
	}

  
  Dialog.create("Create cross-section");
  Dialog.addChoice("Image 1:", list);
  Dialog.addNumber("Min:", 0);
  Dialog.addNumber("Max:", 115);
  Dialog.addChoice("Image 2:", list);

  //Dialog.addCheckbox("Open in 3D (Not working yet)", true);
  //Dialog.addChoice("3D plugin:", newArray("3D-Viewer"));
  Dialog.show();
  
	image1 = Dialog.getChoice();
	minval = Dialog.getNumber();
	maxval = Dialog.getNumber();
	image2 = Dialog.getChoice();
	//chkopn3d = Dialog.getCheckbox();
    //get3dtype = Dialog.getChoice();
  
  //print(chkopn3d);
  //print(get3dtype);
  
selectImage(image1);
run("Duplicate...", "duplicate");
copy = getImageID();
selectImage(copy);

val = "code=[if(v<=" + minval + "){v=0;}else if(v>="+ maxval +"){v=0;}else{v=v;}] stack";
run("Macro...", val);
run("Make Binary", "method=Huang background=Default calculate black");

run("Divide...", "value=255 stack");

imageCalculator("Multiply create 32-bit stack", copy, image2);
rename("result.tif");

selectImage(copy);
close();