A1=imread('F:/study/4-2/project/Implementation/Templates/test/PaperDemo/Test.png');

letter = {A1};
for i=1:1
    if size(letter{i},3)==3 %RGB image
            letter{i}=rgb2gray(letter{i});
    end
    threshold = graythresh(letter{i});%Otzsu
    letter{i} =~im2bw(letter{i},threshold);
    % Remove all object containing fewer than 30 pixels
    letter{i} = bwareaopen(letter{i},30);

    [f c]=find(letter{i});
    letter{i} = letter{i}(min(f)-10:max(f)+10,min(c)-10:max(c)+10);
    letter{i}=skeleton1(letter{i});
    filename=sprintf('F:\\study\\4-2\\project\\Implementation\\Templates\\test\\PaperDemo\\%04d.bmp',i+220);
    
    imwrite(letter{i},filename,'bmp');
end