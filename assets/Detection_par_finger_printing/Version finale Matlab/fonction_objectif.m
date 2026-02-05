function [F] = fonction_objectif(x,d,AP,I) 
        ecart = (d(:) - sqrt(abs(x(1)-AP(:,1)).^2 + abs(x(2)-AP(:,2)).^2)).^2;
            if (I==1)
                e5=0.9*ecart(1,:)+0.1*ecart(2,:)+0.1*ecart(3,:)+0.1*ecart(4,:);
            end
            if (I==2)
                e5=0.1*ecart(1,:)+0.9*ecart(2,:)+0.1*ecart(3,:)+0.1*ecart(4,:);
            end
            if (I==3)
                e5=0.1*ecart(1,:)+0.1*ecart(2,:)+0.9*ecart(3,:)+0.1*ecart(4,:);
            end
            if (I==4)
                e5=0.1*ecart(1,:)+0.1*ecart(2,:)+0.1*ecart(3,:)+0.9*ecart(4,:);
            end
        
   F= e5;


