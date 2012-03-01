function makeallplots(comps, c_labs, d_labs, m_labs, s_m_labs)
    figure('OuterPosition', [200 100 1024 768]);
    minoritysizeplot(comps);
    figure('OuterPosition', [200 100 1024 768]);
    minoritymeasureplot(comps, m_labs);
    figure('OuterPosition', [200 100 1024 768]);
    dimreduceplot(comps, d_labs);
    figure('OuterPosition', [200 100 1024 768]);
    classifierplot(comps, c_labs);
    figure('OuterPosition', [200 100 1024 768]);
    possizeplot(comps, m_labs);
    figure('OuterPosition', [200 100 1024 768]);
    agreementplot(comps, s_m_labs);
end