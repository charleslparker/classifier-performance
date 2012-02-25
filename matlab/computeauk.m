function [auk x y] = computeauk(scores, labels)
    if cols(scores) == 1 && cols(labels == 1)
        n0 = sum(labels == 0);
        n1 = sum(labels == 1);
        total = length(scores);
        [F0 F1] = computeroc(scores, labels);   

        x = zeros(length(F0), 1);
        y = zeros(length(F0), 1);
        
        for i = 1:length(F0)
            tp = (n1 - F1(i))/total;
            fp = (n0 - F0(i))/total;
            tn = F0(i)/total;
            fn = F1(i)/total;
            
            p = tp + fn;
            n = fp + tn;
            phat = tp + fp;
            nhat = fn + tn;
            t = tp/p;
            f = fp/n;
            a = tp + tn;
            
            pc = p*phat + n*nhat;
            ckap = (a - pc)/(1 - pc);
            x(i) = f;
            y(i) = ckap;
        end
        x = x(end:-1:1);
        y = y(end:-1:1);
        auk = trapz(x, y);
    else
        auk = zeros(1, cols(labels));
        for i = 1:cols(labels)
            auk(i) = computeauk(scores(:,i), labels(:,i));
        end
    end
end