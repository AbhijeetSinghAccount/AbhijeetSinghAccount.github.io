%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         This code is for the implementaion of the paper
%        Pectoral muscle segmentation on digital mammograms by  Non Linear Diffusion Filtering
%                                       Authors
%                      H.MIRZAALIAN, M.R. AHMADZADEH, S. SADRI
%    Published : 2007 IEEE Pacific Rim Conference on Communications, Computers and Signal Processing |
%                         Date: 22-24 Aug.2007|Page no.: 581-584
% presented by:
% abhijeet singh 1301CH01
% aman prakash singh 1301EE02
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ref: MLO IMAGE taken from the MIAS mdb012

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%reading image as input 


rgb=imread('C:\Users\rajeshraj\Desktop\mammo1.png');




%since the input image is a rgb image, converting it to grayscale


img=rgb2gray(rgb);

%prepocessing of the image by removing its label


o=removeLabel1(img);
%imshow(o);
%impixelinfo;



%imshow(o);
%converrting uint8 image to double for manipulation

a=double(o);

%calculation of the rows and columns of the image for the defining our ROI

[rows,columns]=size(o);

%declaration of matrix u

u=zeros((rows/2)-30,(columns/2)-85);


for p=30:rows/2
      for q=40:columns/2-45
           u(p-29,q-39)=o(p,q);
      end
end

% declaration of the d and grad matrixes for further use 

%imshow(u/255)

d=zeros((rows/2)-30,(columns/2)-85);
grad=zeros((rows/2)-29,(columns/2)-84);


div=zeros((rows/2)-29,(columns/2)-84);
% declaring sigma of gaussian filter

sigma=1;
% cutoff=3*sigma;
% h=fspecial('gaussian',2*cutoff+1,sigma);

%for t=1:30

%u=conv2(u,h,'same');
for t = 1:30
    
% calling gaussian function     
u = gaussian(u,sigma);

v = u/255;

%subplot(2,2,1);
%imshow(v)
%calculating the gradient of the image

g=imgradient(u);
% subplot(2,2,1);
% imshow(g)

%diffuusion filter

% declaring constants of the dependent on the image

power=100;
lamda=3;
Cm=6.4746;

for m=1:rows/2-29
    for n=1:columns/2-84
        d(m,n)=(1-exp(-(Cm/((g(m,n)/lamda)^power))));
    end
end

%subplot(3,10,t);
% subplot(2,2,2);
% imshow(d)

%calculation of the divergence of the function of the modified image

grad=divergence(d,g)/255;
% subplot(2,2,3);
% imshow(grad)
% updating ROI


 % updating the value of my ROI for every successful iteration 
 
 u=u+200*(grad)/255;
 v = u/255;
 
 
%applying thrsholding on image
 seg= thresh(v,t);
 %figure;
 
 %imshow(v);
 

%plotting figure
subplot(6,5,t);
imshow(seg,[]);
end

%figure;
%imshow(seg,[]);

%final counter comes out to be as shown in the figure

% the user/radiologist manually seectes the region for the pectoral muscle

