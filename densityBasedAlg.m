load f2
global letter label gfeatureSet gfeatureSet2 
fileID = fopen('out.txt','w');

p={'usr_112/','usr_113/','usr_114/','usr_115/','usr_116/','usr_117/','usr_118/','usr_119/',...
    'usr_120/','usr_121/','usr_122/','usr_123/','usr_124/','usr_125/','usr_126/','usr_127/','usr_128/','usr_29/',...
    'usr_130/','usr_131/','usr_132/','usr_133/','usr_134/','usr_135/','usr_136/','usr_137/','usr_138/','usr_39/',...
    'usr_140/','usr_141/','usr_142/','usr_143/','usr_144/','usr_145/','usr_146/'};
gInd=1;

for i=1:35
    i
    imgPath = 'F:/study/4-2/project/Implementation/Templates/hpl-telugu-iso-char-test-offline-1.0/hpl-telugu-iso-char-offline-test/';
    imgPath = strcat(imgPath,p{i});
    imgType = '*.bmp'; % change based on image type
    images  = dir([imgPath imgType]);
    for idx = 1:length(images)   
        letter1{gInd} = imread([imgPath images(idx).name]);    
        threshold = graythresh(letter1{gInd});%Otzsu
        letter1{gInd} =~im2bw(letter1{gInd},threshold);
        gInd=gInd+1;
    end
end
for in=1:size(letter1,2)
    in
    word=[ ];
        test=letter1{in};
                    [test tfeatureSet]=feature2(test);
                    distance=[];
                    for i=1:size(letter,2)
                         sum=0;
                         sum2=0;
                         for j=1:size(gfeatureSet,2)
                             sum=sum+(tfeatureSet(j)-gfeatureSet(i,j))^2;
                         end
                         distance(i)=sqrt(sum);                    
                         
                    end
                     sdistance=distance;
                     sdistance=sort(sdistance);
                     %display(sdistance);
                     %3-NN
                     modarray = sdistance(1:5);
                     for i=1:5
                        for j=1:size(letter,2)
                            if(modarray(i)==distance(j))
                                lab=label{j};
                                break;
                            end
                        end
    %                     1NN comment from 104 to 113
                        for k=i+1:5
                           for j=1:size(letter,2)
                                if(modarray(k)==distance(j))
                                    if(strcmp(lab,label{j}))
                                        modarray(k)=modarray(i);
                                    end
                                    break;
                                end
                           end         
                        end
                     end

                     for i=1:size(letter,2)
                            mod=mode(modarray);
                            if(mod==distance(i))
                                word = [word label(i)];
                                break;
                            end
                     end
                    fprintf(fileID,'%6s\r\n',word{1});
end                     
fclose(fileID);