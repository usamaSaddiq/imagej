selectWindow("t1-head-1.tif");
run("Make Binary", "method=Default background=Default calculate");
imageCalculator("Multiply create 32-bit stack", "t1-head.tif","t1-head-1.tif");
selectWindow("Result of t1-head.tif");

