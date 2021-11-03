
fileID=fopen('1AA.txt');
cac=textscan(fileID,'imageBounds[%f,%f,%fx%f,%s  time%f:%f:%f:%f  zoom%f  imagePoint(%f,%f)' );
fclose(fileID);


I=imread('1AAT.jpg');
[a,b,c]=size(I);
ratio=63.28;


imageBound_x=round(cac{1,1}/ratio);
imageBound_y=round(cac{1,2}/ratio);
imageBound_width=round(cac{1,3}/ratio);
imageBound_height=round(cac{1,4}/ratio);
degree=cac{1,5};
time_hour=cac{1,6};
time_minute=cac{1,7};
time_second=cac{1,8};
time_millisecond=cac{1,9};
zoom=cac{1,10};
imagePoint_x=round(cac{1,11}/ratio);
imagePoint_y=round(cac{1,12}/ratio);

k=length(imageBound_x);
time=time_minute*60000+time_second*1000+time_millisecond;
interval=zeros(k,1);
for i=1:k-1
    interval(i)=time(i)-time(i+1);
end
milli=zeros(k,1);
milli(1)=interval(1);
for i=2:k
    milli(i)=milli(i-1)+interval(i);
end
inde=zeros(k,1);
for i=1:k
    inde(i)=i;
end
center_x=round(imageBound_x+0.5*imageBound_width);
center_y=round(imageBound_y+0.5*imageBound_height);

log_matrix=[inde,milli,imageBound_x,imageBound_y,imageBound_width,imageBound_height,center_x,center_y,imagePoint_x,imagePoint_y,zoom,interval];

T=array2table(log_matrix);
T.Properties.VariableNames(1:12)={'index','millisecond','imageBound_x','imageBound_y','imageBound_width','imageBound_height','center_x','center_y','imagePoint_x','imagePoint_y','zoom','interval'};
writetable(T,'1AA.csv');      