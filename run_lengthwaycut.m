% Run reconstuction and ocr on lengthway cut paper
% Made on 12/01/2017
clear all; close all; clc;
%% Input Parameters
NUM_SPLIT = [1 14]; % row and colum

%% Split paper to get the preprocessed data
split_paper_main

%% Algorithm Running
lengthway_reconstruction_main

%% Image OCR and txt saving 
ocr_paper_to_txt