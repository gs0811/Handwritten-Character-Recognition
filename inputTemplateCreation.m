
fileID = fopen('in.txt','w');
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

p={'usr_112/','usr_113/','usr_114/','usr_115/','usr_116/','usr_117/','usr_118/','usr_119/',...
    'usr_120/','usr_121/','usr_122/','usr_123/','usr_124/','usr_125/','usr_126/','usr_127/','usr_128/','usr_29/',...
    'usr_130/','usr_131/','usr_132/','usr_133/','usr_134/','usr_135/','usr_136/','usr_137/','usr_138/','usr_39/',...
    'usr_140/','usr_141/','usr_142/','usr_143/','usr_144/','usr_145/','usr_146/'};


for i=1:35
    i
    imgPath = 'F:/study/4-2/project/Implementation/Templates/hpl-telugu-iso-char-test-offline-1.0/hpl-telugu-iso-char-offline-test/';
    imgPath = strcat(imgPath,p{i});
    imgType = '*.bmp'; % change based on image type
    images  = dir([imgPath imgType]);
    for idx = 1:length(images)
        k=images(idx).name;
        [v ind]=ismember(k(1:3),A);
        fprintf(fileID,'%6s\r\n',B{ind});
    end
end
         
fclose(fileID);