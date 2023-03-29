function [QPeaks,Qlocs,SPeaks,Slocs,TPeaks,Tlocs,PPeaks,Plocs]=PQST_Detection(Rlocs,yf)
wl=300;
dr=wl*2/3;
dl=wl*1/3;
rec1=zeros(1,length(yf));
rec2=zeros(1,length(yf));
QPeaks=zeros(1,length(Rlocs));
Qlocs=zeros(1,length(Rlocs));
SPeaks=zeros(1,length(Rlocs));
Slocs=zeros(1,length(Rlocs));
TPeaks=zeros(1,length(Rlocs));
Tlocs=zeros(1,length(Rlocs));
PPeaks=zeros(1,length(Rlocs));
Plocs=zeros(1,length(Rlocs));
%% Windowing
for i=1:length(Rlocs)
    xl=Rlocs(i)-dl;
    xr=Rlocs(i)+dr;
    if xl<1 || xr>10000
        continue
    end
    mx=max(yf(xl:xr));
    mn=min(yf(xl:xr));
    rec1(xl:xr)=mx;
    rec2(xl:xr)=mn;
    %% PQST Detection
    
    x1=50;
    x2=5;
    y2=50;
    
    a= Rlocs(i)-x1;
    b=Rlocs(i);
    [QPeaks(i),Qlocs(i)]=min(yf(a:b));
    Qlocs(i)=Qlocs(i)+a-1;
    c= Rlocs(i)+x2;
    d=Rlocs(i)+y2;
    [SPeaks(i),Slocs(i)]=min(yf(c:d));
    Slocs(i)=Slocs(i)+c-1;
    e= Slocs(i);
    f=xr;
    [TPeaks(i),Tlocs(i)]=max(yf(e:f));
    Tlocs(i)=Tlocs(i)+e-1;
    g= xl;
    h=Qlocs(i);
    [PPeaks(i),Plocs(i)]=max(yf(g:h));
    Plocs(i)=Plocs(i)+g-1;
end