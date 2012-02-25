function [f1 mcc pre rec] = computef1(scores, labels)
    if cols(scores) == 1 && cols(labels == 1)
        n0 = sum(labels == 0);
        n1 = sum(labels == 1);
        [F0 F1] = computeroc(scores, labels);   

        f1 = 0;
        pre = 0;
        rec = 0;
        mcc = 0;
        
        for i = 1:length(F0)
            tp = n1 - F1(i);
            fp = n0 - F0(i);
            tn = F0(i);
            fn = F1(i);
            
            if (tp > 0)
                pretemp = tp/(tp + fp);
                rectemp = tp/(tp + fn);
                f1temp = 2*((pretemp*rectemp)/(pretemp + rectemp));
                mcctemp = ((tp*tn) - (fp*fn))/sqrt((tp + fp)*(tp + fn)*(tn + fp)*(tn + fn));
            else
                f1temp = 0;
                pretemp = 0;
                rectemp = 0;
                mcctemp = 0;
            end
            
            if f1temp > f1
                f1 = f1temp;
                pre = pretemp;
                rec = rectemp;
            end
            
            if mcctemp > mcc
                mcc = mcctemp;
            end
        end
    else
        f1 = zeros(1, cols(labels));
        pre = zeros(1, cols(labels));
        rec = zeros(1, cols(labels));
        for i = 1:cols(labels)
            [f1(i) pre(i) rec(i)] = computef1(scores(:,i), labels(:,i));
        end
    end
end