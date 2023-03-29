clc;
clear all;
close all;

data=load('D:\Yekra\OneDrive - BUET\MatLab works\DSP Project\ECG-ID Database\Person-87\rec_1m.mat');
raw=data.val(1,:)/200;
filt=data.val(2,:)/200;
fs=500;
figure
subplot(211)
plot(raw);
title('Raw ECG signal');

%Low-pass filtering
hd1=lpf2;
fil1=filter(hd1,raw);

subplot(212)
plot(fil1)
title('Output of the LPF')


%Baseline Removal
y1=medfilt1(fil1,100);
y2=medfilt1(y1,300);
base_remove=fil1-y2;
figure
subplot(211)
plot(fil1);hold on;
plot(y2,'LineWidth',2);title('LPF output along with wandering baseline');
subplot(212)
plot(base_remove);title('Final denoised data')


%%Spectrum plotting
[P1,f]=freqspec(raw,fs);
figure
subplot(311)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of the raw data')
xlabel('f (Hz)')
ylabel('|P1(f)|')

[P1,f]=freqspec(fil1,fs);
subplot(312)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum after using LPF')
xlabel('f (Hz)')
ylabel('|P1(f)|')

[P1,f]=freqspec(base_remove,fs);
subplot(313)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum after baseline wander removal')
xlabel('f (Hz)')
ylabel('|P1(f)|')








