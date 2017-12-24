function otherBPtest()

load fbp;
global V1 W1 B1
V1
W1
size(V1)
size(W1)
size(B1)
    fileID = fopen('out.txt','w');
   p1={'usr_112/','usr_113/','usr_114/','usr_115/','usr_116/','usr_117/','usr_118/','usr_119/',...
    'usr_120/','usr_121/','usr_122/','usr_123/','usr_124/','usr_125/','usr_126/','usr_127/','usr_128/','usr_29/',...
    'usr_130/','usr_131/','usr_132/','usr_133/','usr_134/','usr_135/','usr_136/','usr_137/','usr_138/','usr_39/',...
    'usr_140/','usr_141/','usr_142/','usr_143/','usr_144/','usr_145/','usr_146/'};
gInd=1;

for i=1:35
    i
    imgPath = 'F:/study/4-2/project/Implementation/Templates/hpl-telugu-iso-char-test-offline-1.0/hpl-telugu-iso-char-offline-test/';
    imgPath = strcat(imgPath,p1{i});
    imgType = '*.bmp'; % change based on image type
    images  = dir([imgPath imgType]);
    for idx = 1:length(images)   
        letter1{gInd} = imread([imgPath images(idx).name]);    
        threshold = graythresh(letter1{gInd});%Otzsu
        letter1{gInd} =~im2bw(letter1{gInd},threshold);
        gInd=gInd+1;
    end
end

for i=1:100
        i
            %separate characters in text
        %word=[ ];
        letter1{i}=imresize(letter1{i},[32 32]);
        temp=letter1{i}(1:32,1:32);
        Input = [];
        for p=1:size(temp,1)
            for q=1:size(temp,2)
                Input = [Input temp(p,q)];
            end
        end
        Op=op(Input',V1,W1);
        maxxy = -1000;
        index=0;
        for yy=1:size(Op,1)
            if maxxy<Op(yy)
                maxxy = Op(yy);
                index=yy;
            end
        end
       % index=find(Op==max(Op));
%                     Op
        %word=[word label{index}];
               
        fprintf(fileID,'%6s\r\n',B1{index});
    end
    
    fclose(fileID);
end

function Output_of_OutputLayer = op(Input, V, W)
digits(6);
     Output_of_InputLayer = Input;
 
     Input_of_HiddenLayer = V' * Output_of_InputLayer; 
     [m n] = size(Input_of_HiddenLayer);
 
     Output_of_HiddenLayer = vpa(1./(1+exp(-Input_of_HiddenLayer)));
 
     Input_of_OutputLayer = W'*Output_of_HiddenLayer;
 
     clear m n;
     [m n] = size(Input_of_OutputLayer);
 
     Output_of_OutputLayer = vpa(1./(1+exp(-Input_of_OutputLayer)));
 end
