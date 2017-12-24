function [img featureSet featureSet2] = feature11(img)
featureSet = [];
featureSet2 = [];
img=imresize(img,[50 50]);
x=0;
y=0;
count=0;
%display(size(img,1));
%display(size(img,2));
for i=1:size(img,1)
    for j=1:size(img,2)
       if(img(i,j)==1)
           count=count+1;
           x=x+j;
           y=y+i;
       end
    end
end
if(count~=0)
    centroidx=round(x/count);
    centroidy=round(y/count);
    zones=mat2cell(img,[10 10 10 10 10],[10 10 10 10 10]);

    for i=1:size(img,1)/10
        for j=1:size(img,2)/10
            image=zones{i,j};
            [f f2]=fun(image,centroidx,centroidy);
            featureSet = [featureSet f];
            featureSet2 = [featureSet2 f2/count];
            
        end
    end
end

function [f f2]=fun(image,x,y)
f=[];
f2=[];
count=0;
c1=0;
for i=1:size(image,1)%this for row
    dist=0;
    
    for j=1:size(image,2)
        if(image(i,j)==1)
             c1=c1+1;
             count=count+1;
             dist = dist + sqrt((x-j)^2+(y-i)^2); 
        end
    end
%     f = [f dist/size(image,2)];
    if c1<=0
        f = [f 0];
    else
       f = [f dist/c1]; 
    end
 c1=0;
end
f2= [f2 count];
for i=1:size(image,2)%this for column
    for j=1:size(image,1)
        if(image(j,i)==1)
             dist = dist + sqrt((x-i)^2+(y-j)^2); 
        end
    end
%     f = [f dist/size(image,1)];
    if c1<=0
        f = [f 0];
    else
        f = [f dist/c1]; 
    end
    c1=0;
end