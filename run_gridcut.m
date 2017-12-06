% Run reconstuction and ocr on grid cut paper
% Made on 12/01/2017
clear all; close all; clc;
%% Input Parameters
NUM_SPLIT = [4 5]; % row and colum

%% Split paper to get the preprocessed data
split_paper_main

%% Algorithm Running
grid_cut_reconstruction_main

%% Image OCR and txt saving 
ocr_paper_to_txt