  list = getList("image.titles");
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

  //print(image1);
  //print(minval);
  //print(maxval);
  //print(image2);

  
  //print(chkopn3d);
  //print(get3dtype);
  
selectImage(image1);
run("Duplicate...", "duplicate");
copy = getImageID();
selectImage(image1);
selectImage(copy);

val = "code=[if(v<=" + minval + "){v=0;}else if(v>="+ maxval +"){v=0;}else{v=v;}] stack";
run("Macro...", val);
run("Make Binary", "method=Huang background=Default calculate black");

imageCalculator("Multiply create 32-bit stack", copy, image2);
result = "Result of " + image1;
run("16-bit");


/*
selectWindow("t1-head-1.tif");
run("Make Binary", "method=Default background=Default calculate");
imageCalculator("Multiply create 32-bit stack", "t1-head.tif","t1-head-1.tif");
selectWindow("Result of t1-head.tif");
*/
