# EECS442_CV_Proj

This repo is the final proj for EECS442 Computer Vision in Umich F18 titled Document Reconstruction and Contextualization.

//---------
2017/12/02:
Step0: split image in nonrandom size mode (done) and randome size mode (TBA)
Step1: vertical bar reconstruction (done)
Step2: laterial bar reconstruction (TBA)

//---------
2017/12/03:
1. fix the bidirection problem in vertical bar reconstruction bug. Now just start from left side. 
2. go through the cube_cut case. Finished it in full_text case. 
3. Next stage is to improve the performance of reconstruction. And start contextualization (i.e. ocr).

//---------
2017/12/04:
1. Add and test the matlab ocr and text saving. Finish the example. Next step is to make it a general case. 
2. TODO: improve the cubecut performance and prevent mismatching dimension error in programming.  

//--------
2017/12/05:
Submit your project report and the code as separate files, e.g., one pdf and one zip file. If your group created a GitHub repo, you could include the link in your report (but you still need to upload code here). 



//-------------//-------------//-------------//-------------//-------------//-------------//-------------//
You are required to write a four page report that describes the problem, your method and your results.



Four pages include the images and reference. 

The report should have 

an introduction section, (documentation reconstruction significant + context)  ----> dzhang

a related work section, (iteration: vertical, cube, ocr) ---> pwl 

a methods section, ( method:vertical->similarity, cube->space indent, ocr->matlab build-in function ) ---> dzhang

a results section ( vertical -> niubi, [3,5] niubi, space is big-> cube niubi, space is small-> cube beng ) -----> pwl

a discussion (linear scoring, limit) ---> dzhang, pwl . 


Grammer check and refine: YY & zhaoyic



 You don't need to put your code or table of contents in your report. 
//-------------//-------------//-------------//-------------//-------------//-------------//-------------//



The assignment is due Dec 7, 14:59 pm EST. Note that there are 20 points for on-time submission. One group just need to submit once; any one team member can do that job.
