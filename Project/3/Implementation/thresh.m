function [ seg ] = thresh( v,t )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
 level = multithresh(v,cal(t));
 seg= imquantize(v,level);

end
