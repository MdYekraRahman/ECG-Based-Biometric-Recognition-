clc;
clear all;
close all;
Fs = 500;
for j=2:2
    pno=num2str(j);
    for i=1:1
        id=num2str(i);
        Data1=load(['F:\OneDrive - BUET\3-1\DSP Project\Code\DSP Project\ECG-ID Database\Person-' pno '\rec_' id 'm.mat']);
        raw_data=Data1.val(1,:);
        yf=preprocessing(raw_data);
        plot(yf)
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
        
        rec1=zeros(1,length(yf));
        rec2=zeros(1,length(yf));
        for i=1:length(Rlocs)-1
            xl=Rlocs(i)-dl;
            xr=Rlocs(i)+dr;
            if xl<1 || xr>10000
                continue
            end
            mx=max(yf(xl:xr));
            mn=min(yf(xl:xr));
            rec1(xl:xr)=mx;
            rec2(xl:xr)=mn;
            x1=50;
            x2=5;
            y2=50;
            
            % PQST Detection
            QPeaks=zeros(1,length(Rlocs));
            Qlocs=zeros(1,length(Rlocs));
            SPeaks=zeros(1,length(Rlocs));
            Slocs=zeros(1,length(Rlocs));
            TPeaks=zeros(1,length(Rlocs));
            Tlocs=zeros(1,length(Rlocs));
            PPeaks=zeros(1,length(Rlocs));
            Plocs=zeros(1,length(Rlocs));
            
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
            

            
%             plot(t,yf,Rlocs,RPeaks,'*')
%             hold on
%             plot(Qlocs,QPeaks,'o')
%             hold on
%             plot(Plocs,PPeaks,'d')
%             hold on
%             plot(Slocs,SPeaks,'+')
%             hold on
%             plot(Tlocs,TPeaks,'s')
            
        end
    end
    plot(yf);
    hold on;
    plot(rec1,'r','LineWidth',2);
    hold on;
    plot(rec2,'r','LineWidth',2);
    hold on;
    
end

