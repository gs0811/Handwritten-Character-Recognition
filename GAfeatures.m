function [img xarr yarr] = GAfeatures(img)

[xarr yarr] = contour(img);
[x y] = lineProfiles(img);
xarr=[xarr x];
yarr = [yarr y];


function [x y]=contour(image)
x=[];
y=[];

% FOR LEFT
ya=zeros(1,51);
for i=1:51
    for j=1:51
       if image(i,j)==1
           ya(i)=j;
           break;
       end
    end
end
% ya
mx = find(max(ya)==ya);
mn = find(min(ya)==ya);
y = [y max(ya) min(ya)];
x = [x mx(1) mn(1)];

for i=1:50
    ya(52-i)=ya(52-i)-ya(51-i);
end

ya = ya(2:51);
% ya
mx = find(max(ya)==ya)+1;
mn = find(min(ya)==ya)+1;
x = [x mx(1) mn(1)];
for i=[mx(1) mn(1)]
    check=0;
    for j=1:51
        if image(i,j)==1
           check=1;
           y=[y j];
           break;
       end
    end
    if check==0
        y=[y 0];
    end
end

% FOR RIGHT
ya=zeros(1,51);
for i=1:51
    for j=1:51
       if image(i,52-j)==1
           ya(i)=52-j;
           break;
       end
    end
end

mx = find(max(ya)==ya);
mn = find(min(ya)==ya);
y = [y max(ya) min(ya)];
x = [x mx(1) mn(1)];

for i=1:50
    ya(52-i)=ya(52-i)-ya(51-i);
end

ya = ya(2:51);
mx = find(max(ya)==ya)+1;
mn = find(min(ya)==ya)+1;
x = [x mx(1) mn(1)];
for i=[mx(1) mn(1)]
    check=0;
    for j=1:51
        if image(i,52-j)==1
           check=1;
           y=[y 52-j];
           break;
       end
    end
    if check==0
        y=[y 0];
    end
end

% FOR TOP
xa=zeros(1,51);
for j=1:51
    for i=1:51
       if image(i,j)==1
           xa(j)=i;
           break;
       end
    end
end

mx = find(max(xa)==xa);
mn = find(min(xa)==xa);
x = [x max(xa) min(xa)];
y = [y mx(1) mn(1)];

for i=1:50
    xa(52-i)=xa(52-i)-xa(51-i);
end

xa = xa(2:51);
mx = find(max(xa)==xa)+1;
mn = find(min(xa)==xa)+1;
y = [y mx(1) mn(1)];
for i=[mx(1) mn(1)]
    check=0;
    for j=1:51
        if image(j,i)==1
           check=1;
           x=[x j];
           break;
       end
    end
    if check==0
        x=[x 0];
    end
end

% FOR BOTTOM
xa=zeros(1,51);
for j=1:51
    for i=1:51
       if image(52-i,j)==1
           xa(j)=52-i;
           break;
       end
    end
end

mx = find(max(xa)==xa);
mn = find(min(xa)==xa);
x = [x max(xa) min(xa)];
y = [y mx(1) mn(1)];

for i=1:50
    xa(52-i)=xa(52-i)-xa(51-i);
end

xa = xa(2:51);
mx = find(max(xa)==xa)+1;
mn = find(min(xa)==xa)+1;
y = [y mx(1) mn(1)];
for i=[mx(1) mn(1)]
    check=0;
    for j=1:51
        if image(52-j,i)==1
           check=1;
           x=[x 52-j];
           break;
       end
    end
    if check==0
        x=[x 0];
    end
end


function [x y] = lineProfiles(image)
x=[];
y=[];

%HORIZONTAL
k=[5 15 25 35 45];
for i=k
    check=0;
    for j=1:51
        if image(i,j)==1
            x=[x i];
            y=[y j];
            check=1;
            break;
        end
    end
    if check == 0
        x=[x 0];
        y=[y 0];
    end
    check=0;
    for j=1:51
        if image(i,52-j)==1
            x=[x i];
            y=[y 52-j];
            check=1;
            break;
        end
    end
    
    if check == 0
        x=[x 0];
        y=[y 0];
    end
end

%VERTICAL
k=[5 15 25 35 45];
for i=k
    check=0;
    for j=1:51
        if image(j,i)==1
            x=[x j];
            y=[y i];
            check=1;
            break;
        end
    end
    if check == 0
        x=[x 0];
        y=[y 0];
    end
    check=0;
    for j=1:51
        if image(52-j,i)==1
            x=[x 52-j];
            y=[y i];
            check=1;
            break;
        end
    end
    if check == 0
        x=[x 0];
        y=[y 0];
    end
end

% -45
% for i=1:51
%      if image(i,i)==1
%          x=[x i];
%          y=[y i];
%          break;
%      end
% end
% for i=1:51
%      if image(52-i,52-i)==1
%          x=[x 52-i];
%          y=[y 52-i];
%          break;
%      end
% end
% 
% % +45
% for i=1:51
%      if image(i,52-i)==1
%          x=[x i];
%          y=[y 52-i];
%          break;
%      end
% end
% for i=1:51
%      if image(52-i,i)==1
%          x=[x 52-i];
%          y=[y i];
%          break;
%      end
% end