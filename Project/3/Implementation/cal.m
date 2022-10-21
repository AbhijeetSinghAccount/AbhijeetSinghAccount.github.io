function [ k] = cal( t )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes he
if (t<19)
   k=20-floor((t+1)/2);
   %k = 21-t;
else
    k=32-t;
end

end
