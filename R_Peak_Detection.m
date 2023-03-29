function [RPeaks,Rlocs] =R_Peak_Detection(yf)
t=1:length(yf);
wt=modwt(yf,8,'sym4');

wtrec=zeros(size(wt));
wtrec(3:5,:)=wt(3:5,:);

y=imodwt(wtrec,'sym4');
y(y<0)=0;

avg=mean(abs(y).^2);
[Rpeaks,Rlocs]=findpeaks(abs(y).^2,t,'MinPeakHeight',8*avg,'MinPeakDistance',50);
RPeaks=yf(Rlocs);
RPeaks(end-1:end)=[];
Rlocs(end-1:end)=[];
end