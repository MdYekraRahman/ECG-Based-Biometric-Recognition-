function [avg_beat]=Avg_Beat_function(yf)
Fs=500;
yf=yf/200;
t=1:length(yf);
tx=t./Fs;
wt=modwt(yf,8,'sym4');
wtrec=zeros(size(wt));
wtrec(3:5,:)=wt(3:5,:);
y=imodwt(wtrec,'sym4');
y=abs(y).^2;
avg=mean(y);
[Rpeaks,Rlocs]=findpeaks(y,t,'MinPeakHeight',8*avg,'MinPeakDistance',50);
RPeaks=yf(Rlocs);
wl=300;
dr=wl*2/3;
dl=wl*1/3;

jog=zeros(1,wl+1);
cnt=0;
for i=2:length(Rlocs)-1
    xl=Rlocs(i)-dl;
    xr=Rlocs(i)+dr;
    if xl<1 || xr>1000
        continue
    end
    normal=normalize(yf(xl:xr));
    jog=jog+normal;
    cnt=cnt+1;
end
avg_beat=jog/cnt;
end


