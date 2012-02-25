function perf = computeallperf(scores, labels)
    auk = computeauk(scores, labels);
    auc = computeauc(scores, labels);
    rp = computerp(scores, labels);
    ap = computeap(scores, labels);
    h = computeh(scores, labels);
    [f1 mcc] = computef1(scores, labels);
    
    perf = [mcc f1 rp h auc ap auk];
end