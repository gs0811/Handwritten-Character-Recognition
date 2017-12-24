
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
    'usr_20/','usr_21/','usr_22/','usr_23/','usr_24/','usr_25/','usr_26/','usr_27/','usr_28/','usr_29/',...
    'usr_30/','usr_31/','usr_32/','usr_33/','usr_34/','usr_35/','usr_36/','usr_37/','usr_38/','usr_39/',...
    'usr_40/','usr_41/','usr_42/','usr_43/','usr_44/','usr_45/','usr_46/','usr_47/','usr_48/','usr_49/',...
    'usr_50/','usr_51/','usr_52/','usr_53/','usr_54/','usr_55/','usr_56/','usr_57/','usr_58/','usr_59/',...
    'usr_60/','usr_61/','usr_62/','usr_63/','usr_64/','usr_65/','usr_66/','usr_67/','usr_68/','usr_69/',...
    'usr_70/','usr_71/','usr_72/','usr_73/','usr_74/','usr_75/','usr_76/','usr_77/','usr_78/','usr_79/',...
    'usr_80/','usr_81/','usr_82/','usr_83/','usr_84/','usr_85/','usr_86/','usr_87/','usr_88/','usr_89/',...
    'usr_90/','usr_91/','usr_92/','usr_93/','usr_94/','usr_95/','usr_96/','usr_97/','usr_98/','usr_99/',...
    'usr_100/','usr_101/','usr_102/','usr_103/','usr_104/','usr_105/','usr_106/','usr_107/','usr_108/','usr_109/',...
    'usr_110/','usr_111/'};
globalIndex=1;
label={};
gfeatureSet=[];
gfeatureSet2=[];

for i=1:112
    %i
    imgPath = 'F:/study/4-2/project/Implementation/Templates/hpl-telugu-iso-char-offline-train/';
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

size(letter)
for i=1:size(letter,2)
    i
    if size(letter{i},3)==3 %RGB image
        letter{i}=rgb2gray(letter{i});
    
        threshold = graythresh(letter{i});%Otzsu
        letter{i} =~im2bw(letter{i},threshold);
        % Remove all object containing fewer than 30 pixels
        letter{i} = bwareaopen(letter{i},30);
    end
    
    [letter{i} featureSet]=feature11(letter{i});
    [letter{i} featureSet2]=feature1(letter{i});
    %[featureSet2]=feature1(letter{i});
    gfeatureSet = cat(1,gfeatureSet,featureSet);
    gfeatureSet2 = cat(1,gfeatureSet2,featureSet2);
    %break;
end
size(letter)
save('f2');    