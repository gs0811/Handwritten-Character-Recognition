function [img featureSet] = feature2(img)
featureSet = [];
    zones=mat2cell(img,[5 5 5 5 5 5 5 5 5 5],[5 5 5 5 5 5 5 5 5 5]);

    for i=1:size(img,1)/5
        for j=1:size(img,2)/5
            image=zones{i,j};
            [f]=fun(image);
            featureSet = [featureSet f];
        end
    end
    
function [f]=fun(image)
f=[];
count=0;
for i=1:size(image,1)
    for j=1:size(image,2)
        if(image(i,j)==1)
             count=count+1;
        end
    end
    f = [f count];
end