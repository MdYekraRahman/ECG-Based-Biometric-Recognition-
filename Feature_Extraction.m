function Features=Feature_Extraction(n)

Fs=500;
Features=zeros(1,n);
idx=1;
for Person=1:90
    rec_number=size(dir(['D:\Yekra\OneDrive - BUET\MatLab works\DSP Project\ECG-ID Database\Person-'+string(Person)+'/*.mat']),1);
    for j=1:rec_number
        Data1=load('D:\Yekra\OneDrive - BUET\MatLab works\DSP Project\ECG-ID Database\Person-'+string(Person)+'\rec_'+string(j)+'m.mat');
        raw_data=Data1.val(1,:);
        %% Preprocessing
        yf=preprocessing(raw_data);
        
        yf=yf/200;
        t=1:length(yf);
        tx=t./Fs;
        %% R peak Detection
        [RPeaks,Rlocs]=R_Peak_Detection(yf);
        %% PQRST Detection
        wl=300;
        dr=wl*2/3;
        dl=wl*1/3;
        [QPeaks,Qlocs,SPeaks,Slocs,TPeaks,Tlocs,PPeaks,Plocs]=PQST_Detection(Rlocs,yf);
        %% PQRST Plotting
%         plot(t,yf,Rlocs,RPeaks,'*','LineWidth',2)
%         hold on
%         plot(Qlocs,QPeaks,'o','LineWidth',2)
%         hold on
%         plot(Plocs,PPeaks,'d','LineWidth',2)
%         hold on
%         plot(Slocs,SPeaks,'+','LineWidth',2)
%         hold on
%         plot(Tlocs,TPeaks,'s','LineWidth',2)
        %% Average Beat
        avg=Avg_Beat(Rlocs,yf);
        %% Feature Selection
        % Fiducial Features
        HP=abs(PPeaks);
        HQ=abs(QPeaks);
        HR=abs(RPeaks);
        HS=abs(SPeaks);
        HT=abs(TPeaks);
        PQ=sqrt((Qlocs-Plocs).^2+(QPeaks-PPeaks).^2);
        QR=sqrt((Rlocs-Qlocs).^2+(RPeaks-QPeaks).^2);
        RS=sqrt((Slocs-Rlocs).^2+(SPeaks-RPeaks).^2);
        ST=sqrt((Tlocs-Slocs).^2+(TPeaks-SPeaks).^2);
        Fid_Features=[mean(HP) mean(HQ) mean(HR) mean(HS) mean(HT) mean(PQ) mean(QR) mean(RS) mean(ST)];
        
        % Non-Fiducial Features
        coef=dct(avg);
        Non_Fid_features=coef(2:15);
        Features(idx,:)=[Non_Fid_features Fid_Features Person];
        idx=idx+1;
    end
end
end
