function base_remove=preprocessing(raw)
%% Low-pass filtering
hd1=lpf2;
fil1=filter(hd1,raw);

%% Baseline Removal
y1=medfilt1(fil1,100);
y2=medfilt1(y1,300);
base_remove=fil1-y2;

end