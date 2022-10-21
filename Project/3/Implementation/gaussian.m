function [ u ] = gaussian( u,sigma )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
sigma=1;
cutoff=3*sigma;
h=fspecial('gaussian',2*cutoff+1,sigma);
u = imgaussfilt(u,sigma);

end
