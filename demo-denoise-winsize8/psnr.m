function y=psnr(im1,im2)
%------------------------�����ֵ����ȳ��򡪡���������������������������-----
%  ininput ------ im1 : the original image matrix
%                 im2 : the modified image matrix   
%  output  ------ y   :  the PSNR between the input images
%------------------------------NOTES---------------------------------------
% Written    :  30/04/07
% Contact    : zxxyj0506@sina.com
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (size(im1))~=(size(im2))
    error('������������ͼ��Ĵ�С��һ��');
end
% if ~isrgb(im1)&&~isrgb(im2)
    [m,n]=size(im1);
    A=double(im1);
    B=double(im2);
    sum1=m.*n.*max(max(A.^2));
    sum2=sum(sum((A-B).^2));
    sum3=sum(sum(B.^2));
    sum4=sum(sum(abs(A-B)));
if  sum2==0
    sum2=1;
end
mse=sum2/(m*n);
MAE=sum4/(m*n)
snr=10*log10(sum3/sum2);
y=10*log10(sum1/sum2);
% else 
%     error('��������ͼ��Ϊ��ɫͼ��,ӦΪ uint8  ͼ��');
% end
    
    

