function [simi]=MSSIM(real,res)
%Compute the mean structural similarity index to measure the similarity of
%two images in terms of luminance (l), contrast (c) and structure (s)that
%is designed to provide a good approximation of perceptual image quality


%real = exact phantom
%res = reconstructed image
real=real(:);
res=res(:);

N=length(real);

%compute the mean pixel values of the two images
meanreal=sum(real)/N;
meanres=sum(res)/N;


%Luminance comparison

K1=0.01; %K1 is a small constant <<1
d=max(real)-min(real); % d is the dynamic range of the pixel values. Check!
% max(real)
% min(real)
% max(res)
% min(res)
l=((2*meanreal*meanres)+(K1*d)^2)/((meanreal)^2+(meanres)^2+(K1*d)^2);

%Contrast comparison
K2=0.03;  %K2 is a small constant <<1
sreal=std(real);
sres=std(res);

c=((2*sreal*sres)+(K2*d)^2)/((sreal)^2+(sres)^2+(K2*d)^2);

%Structure comparison

diffreal=real-meanreal;
diffres=res-meanres;

delta=(1/(N-1))*sum(diffreal.*diffres);

s=(delta+(((K2*d)^2)/2))/((sreal*sres)+(((K2*d)^2)/2));


%Calculate MSSIM
simi=(1/N)*sum(l*c*s);

end