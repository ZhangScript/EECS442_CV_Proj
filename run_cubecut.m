clear all; close all; clc;
%% Input Parameters
NUM_SPLIT = [4 5]; % row and colum
%% Algorithm Running
% split the paper to cube
split_paper_main
% run the algorithm of reconstruction
laterial_vertical_bar_reconstruction_main

%% Image OCR and txt saving 
reconstructed_image_ocr