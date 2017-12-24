load f2
global letter label gfeatureSet gfeatureSet2 
fileID = fopen('out.txt','w');

%p={'usr_112/','usr_113/','usr_114/','usr_115/','usr_116/','usr_117/','usr_118/','usr_119/',...
 %   'usr_120/','usr_121/','usr_122/','usr_123/','usr_124/','usr_125/','usr_126/','usr_127/','usr_128/','usr_29/',...
 %   'usr_130/','usr_131/','usr_132/','usr_133/','usr_134/','usr_135/','usr_136/','usr_137/','usr_138/','usr_39/',...
%    'usr_140/','usr_141/','usr_142/','usr_143/','usr_144/','usr_145/','usr_146/'};
p={'Test/','Test1/','Test2/','Test3/'};

gInd=1;

for i=1:4
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
                    [test tfeatureSet]=feature11(test);
                    [tfeatureSet2]=feature1(test);
                    distance=[];
                    distance2=[];
                    for i=1:size(letter,2)
                         sum=0;
                         sum2=0;
                         for j=1:size(gfeatureSet,2)
                             sum=sum+(tfeatureSet(j)-gfeatureSet(i,j))^2;
                         end
                         for j=1:size(gfeatureSet2,2)
                             sum2=sum2+(tfeatureSet2(j)-gfeatureSet2(i,j))^2;
                         end
                         
                         distance(i)=sqrt(sum);
                         distance2(i)=sqrt(sum2);                         
                         
                    end

                     m1=0;
                     m2=0;
                     for i=1:size(letter,2)
                        if(m1<distance(i))
                            m1=distance(i);
                        end

                        if(m2<distance2(i))
                            m2=distance2(i);
                        end
                     end
                    
                     adistance=[];%normalized distance sum

                     for i=1:size(letter,2)
                        adistance(i)=distance(i)/m1 + distance2(i)/m2;
                     end
                     sadistance=sort(adistance);
              
                     modarray = sadistance(1:11);
                     for i=1:11
                        for j=1:size(letter,2)
                            if(modarray(i)==adistance(j))
                                lab=label{j};
                                break;
                            end
                        end
    %                     1NN comment from 101 to 110
                        for k=i+1:11
                           for j=1:size(letter,2)
                                if(modarray(k)==adistance(j))
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
                            if(mod==adistance(i))
                                word = [word label(i)];
                                break;
                            end
                     end
                    fprintf(fileID,'%6s\r\n',word{1});
end                     
fclose(fileID);