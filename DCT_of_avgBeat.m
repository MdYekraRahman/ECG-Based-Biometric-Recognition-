clc;
clear all;
close all;
Fs = 500;
for j=1:3
    pno=num2str(j);
    for i=1:5
        id=num2str(i);
        Data1=load(['D:\Yekra\OneDrive - BUET\MatLab works\DSP Project\ECG-ID Database\Person-' pno '\rec_' id 'm.mat']);
        raw_data=Data1.val(1,:);
        yf=preprocessing(raw_data);
        yf=yf/200;
        t=1:length(yf);
        tx=t./Fs;
        wt=modwt(yf,8,'sym4');
        wtrec=zeros(size(wt));
        wtrec(3:5,:)=wt(3:5,:);
        y=imodwt(wtrec,'sym4');
        % figure
        % plot(y);
        y=abs(y).^2;
        avg=mean(y);
        [Rpeaks,Rlocs]=findpeaks(y,t,'MinPeakHeight',8*avg,'MinPeakDistance',50);
        RPeaks=yf(Rlocs);
        
        % figure
        % plot(t,yf,Rlocs,RPeaks,'*')
        
        
        wl=300;
        dr=wl*2/3;
        dl=wl*1/3;
        
        jog=zeros(1,wl+1);
        cnt=0;
        for i=2:length(Rlocs)-1
            xl=Rlocs(i)-dl;
            xr=Rlocs(i)+dr;
            
            if xl<1 || xr>10000
                continue
            end
            normal=normalize(yf(xl:xr));
            jog=jog+normal;
            cnt=cnt+1;
        end
        avg_beat=jog/cnt;
        dct_avg=dct(avg_beat);
        plot(dct_avg(1:10),'LineWidth',1);
        grid on;
        hold on;
    end
end

