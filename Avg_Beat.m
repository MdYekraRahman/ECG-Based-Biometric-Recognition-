function avg=Avg_Beat(Rlocs,yf)
wl=300;
dr=wl*2/3;
dl=wl*1/3;
sum=zeros(1,wl+1);
cnt=0;
for i=1:length(Rlocs)
    xl=Rlocs(i)-dl;
    xr=Rlocs(i)+dr;
    
    if xl<1 || xr>10000
        continue
    end
    normal=normalize(yf(xl:xr));
    sum=sum+normal;
    cnt=cnt+1;
end
avg=sum/cnt;
end