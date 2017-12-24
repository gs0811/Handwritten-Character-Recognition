% %CREATE TEMPLATES
%Letter

function largeGA()

A={'000','001','002','003','004','005','006','007','008','009',...
    '010','011','012','013','014','015','016','017','018','019',...
    '020','021','022','023','024','025','026','027','028','029',...
    '030','031','032','033','034','035','036','037','038','039',...
    '040','041','042','043','044','045','046','047','048','049'};
B={'a','A','i','I','u','U','R','Ru','e','E',...
    'ai','o','O','au','sz','dz','ka','Ka','ga','Ga',...
    '~m','cha','Cha','ja','Ja','~n','Ta','Tha','Da','Dha',...
    'Na','ta','tha','da','dha','na','pa','fa','ba','Ba',...
    'ma','ya','ra','la','va','Sa','sha','sa','ha','La'};

p={'usr_0/','usr_1/','usr_2/','usr_3/','usr_4/','usr_5/','usr_6/','usr_7/','usr_8/','usr_9/',...
    'usr_10/','usr_11/','usr_12/','usr_13/','usr_14/','usr_15/','usr_16/','usr_17/','usr_18/','usr_19/',...
    'usr_20/','usr_21/',...
    'usr_112/','usr_113/'};

globalIndex=1;
checkpoint=0;
label={};

gfeatureSetx=[];
gfeatureSety=[];

for i=1:24
    %i
    if i==23
        checkpoint = globalIndex;
    end
    if i<= 22
        imgPath = 'F:/study/4-2/project/Implementation/Templates/hpl-telugu-iso-char-offline-train/';
    end
    if i>22
        imgPath = 'F:/study/4-2/project/Implementation/Templates/hpl-telugu-iso-char-test-offline-1.0/hpl-telugu-iso-char-offline-test/';
    end
    imgPath = strcat(imgPath,p{i});
    imgType = '*.bmp'; % change based on image type
    images  = dir([imgPath imgType]);
    for idx = 1:length(images)
        letter{globalIndex} = imread([imgPath images(idx).name]);
        k=images(idx).name;
        [v ind]=ismember(k(1:3),A);
        label{globalIndex}=B{ind};    
        threshold = graythresh(letter{globalIndex});%Otzsu
        letter{globalIndex} =~im2bw(letter{globalIndex},threshold);
        globalIndex=globalIndex+1;
    end
end


for i=1:size(letter,2)
    i
   if size(letter{i},3)==3 %RGB image
        letter{i}=rgb2gray(letter{i});    
        threshold = graythresh(letter{i});%Otzsu
        letter{i} =~im2bw(letter{i},threshold);
        % Remove all object containing fewer than 30 pixels
        letter{i} = bwareaopen(letter{i},30);
    end
    
    letter{i}=imresize(letter{i},[51 51]);
    [letter{i} xarr yarr]=GAfeatures(letter{i});
 
    gfeatureSetx = cat(1,gfeatureSetx,xarr);
    gfeatureSety = cat(1,gfeatureSety,yarr);
   
    imshow(letter{i});
end


px=[];
py=[];
lambda=[];
for i=1:10
    px=cat(1,px,randperm(51,9));
    py=cat(1,py,randperm(51,9));
    lambda=cat(1,lambda,rand(1,9)*10);
end
accu = eff(px,py,lambda,letter,gfeatureSetx,gfeatureSety,label,checkpoint);  
            for iter=1:50
                iter
                            
%               SELECTION
                accu
                acc = sort(accu);
                acc = acc(5:10);
                acc = unique(acc);
                
                pop=[];
                for i=1:size(acc,2)
                    for j=1:10
                       if size(pop,2)==6
                           break;
                       end
                       if acc(size(acc,2)+1-i)==accu(j)
                           pop = [pop j];
                       end
                    end
                    if size(pop,2)==6
                           break;
                    end
                end
                popc=[];
                for i=1:10
                    if i~=pop
                        popc = [popc i];
                    end
                end
                topx=px(pop(1),:);
                topy=py(pop(1),:);
                toplambda=lambda(pop(1),:);

                epx1=px(pop(1),:);
                epy1=py(pop(1),:);
                elambda1=lambda(pop(1),:);
                
                epx2=px(pop(2),:);
                epy2=py(pop(2),:);
                elambda2=lambda(pop(2),:);
                
                epx3=px(pop(3),:);
                epy3=py(pop(3),:);
                elambda3=lambda(pop(3),:);
                
                epx4=px(pop(4),:);
                epy4=py(pop(4),:);
                elambda4=lambda(pop(4),:);
                
%               CROSSOVER
                alpha = rand(1);
                beta = rand(1);
                for i=[1 3 5]
                    px1=px(pop(i),:);
                    py1=py(pop(i),:);
                    lambda1=lambda(pop(i),:);
                    px2=px(pop(i+1),:);
                    py2=py(pop(i+1),:);
                    lambda2=lambda(pop(i+1),:);
                    for j=1:size(px1,2)
                        a1=round(alpha*px1(j)+(1-alpha)*px2(j));
                        b1=round(alpha*py1(j)+(1-alpha)*py2(j));
                        a2=round(alpha*px2(j)+(1-alpha)*px1(j));
                        b2=round(alpha*py2(j)+(1-alpha)*py1(j));
                        px1(j)=a1;
                        py1(j)=b1;
                        px2(j)=a2;
                        py2(j)=b2;
                        a1=beta*lambda1(j)+(1-beta)*lambda2(j);
                        b1=beta*lambda2(j)+(1-beta)*lambda1(j);
                        lambda1(j)=a1;
                        lambda2(j)=b1;
                    end
                    px(pop(i),:)=px1;
                    py(pop(i),:)=py1;
                    lambda(pop(i),:)=lambda1;
                    px(pop(i+1),:)=px2;
                    py(pop(i+1),:)=py2;
                    lambda(pop(i+1),:)=lambda2;
                end
                px(popc(1),:)=epx1;
                py(popc(1),:)=epy1;
                lambda(popc(1),:)=elambda1;
                
                px(popc(2),:)=epx2;
                py(popc(2),:)=epy2;
                lambda(popc(2),:)=elambda2;
                
                px(popc(3),:)=epx3;
                py(popc(3),:)=epy3;
                lambda(popc(1),:)=elambda3;
                
                px(popc(4),:)=epx4;
                py(popc(4),:)=epy4;
                lambda(popc(4),:)=elambda4;

%               MUTATION
                mut = randperm(10);
                mut = mut(1:4);
                phi = rand(1)*360;
                del_disp = 5;
                Niter = 300;
                v=rand(1);
                b=1;
                c=3;
                lambda_disp=.5;
                eta = rand(1);
                s=randperm(2)-1;
                del = del_disp*(1-v^((1-(iter/Niter))^b));
                for i=mut
                    for j=1:size(px,2)
                      px(i,j)=px(i,j)+del*cos(phi);
                      py(i,j)=py(i,j)+del*sin(phi);
                      lambda(i,j)= lambda(i,j)+(-1)^s(1)*lambda_disp*(1-eta^((1-(iter/Niter)^c)));
                    end
                end
                
%               ELITIST
                r=randperm(10,1);                
                px(r,:)=topx;
                py(r,:)=topy;
                lambda(r,:)=toplambda;
                accu = eff(px,py,lambda,letter,gfeatureSetx,gfeatureSety,label,checkpoint);
                
            end
r=find(accu==max(accu));            
display(px(r(1),:));
display(py(r(1),:));
display(lambda(r(1),:));
display(accu);

function [accu] = eff(px,py,lambda,letter,gfeatureSetx,gfeatureSety,label,checkpoint)
                accu=[];
                for k=1:10                 %pop
                    gfeatureSet=[];
                    for m=1:size(letter,2) %training and test set
                        ft=[];
                        for i=1:36         %features
                            for j=1:9      %zones
                                ft = [ft exp(-lambda(k,j)*sqrt((px(k,j)-gfeatureSetx(m,i))^2+(py(k,j)-gfeatureSety(m,i))^2))];
                            end
                        end
                        gfeatureSet = cat(1,gfeatureSet,ft);
                    end
                    
                    word=[];
                    for m=checkpoint:size(letter,2)
                        distance=[];
                        for i=1:checkpoint-1
                             sum=0;
                             for j=1:size(gfeatureSet,2)
                                 sum=sum+(gfeatureSet(m,j)-gfeatureSet(i,j))^2;
                             end
                             distance(i)=sqrt(sum);
                         end
                         %display(distance);
                         sdistance=distance;
                         sdistance=sort(sdistance);
                         %display(sdistance);
                         %3-NN
                         modarray = sdistance(1:1);
                         for i=1:1
                            for j=1:checkpoint-1
                                if(modarray(i)==distance(j))
                                    lab=label{j};
                                    break;
                                end
                            end
        %                     1NN comment from 78 to 87
%                             for k1=i+1:3
%                                for j=1:size(letter,2)
%                                     if(modarray(k1)==distance(j))
%                                         if(strcmp(lab,label{j}))
%                                             modarray(k1)=modarray(i);
%                                         end
%                                         break;
%                                     end
%                                end         
%                             end
                         end

                         for i=1:checkpoint-1
                                mod=mode(modarray);
                                if(mod==distance(i))
                                    word = [word label(i)];
                                    break;
                                end
                         end
                    end
                    count=0;
                    for i=checkpoint:size(letter,2)
                        if strcmp(word{i+1-checkpoint},label{i})
                            count=count+1;
                        end
                    end
                    accu = [accu count/(size(letter,2)-checkpoint+1)];
                end
