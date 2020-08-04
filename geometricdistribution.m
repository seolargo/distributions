function [result1, result2, sampleMean1, sampleMean2, sampleVar1, sampleVar2]  = geometricdistribution(p1, p2, N)
    close all;
    
    %Mean
    mean1 = 1/p1;
    mean2 = 1/p2;
    
    q1=1-p1;
    q2=1-p2;
    %Variance
    var1 = q1/(p1*p1);
    var2 = q2/(p2*p2);
    
    sampleMean1=0;
    for i=1:N
        u=rand;
        result1(i)=ceil(log(1-u)/log(1-p1));
        sampleMean1=sampleMean1+result1(i);
    end
    sampleMean1=sampleMean1/N;
    
    sampleMean2=0;
    for i=1:N
        u=rand;
        result2(i)=ceil(log(1-u)/log(1-p2));
        sampleMean2=sampleMean2+result2(i);
    end
    sampleMean2=sampleMean2/N;
    
    %Calculate sample variance
    sampleVar1=0;
    sampleVar2=0;
    
    nSize=N;
    for i=1:nSize
        sampleVar1 = sampleVar1 + ((result1(i)-sampleMean1)*(result1(i)-sampleMean1));
    end
    sampleVar1 = sampleVar1/(nSize-1);
    
    for i=1:nSize
        sampleVar2 = sampleVar2 + ((result2(i)-sampleMean2)*(result2(i)-sampleMean2));
    end
    sampleVar2 = sampleVar2/(nSize-1);
    
    % Draw random samples from uniform distribution in range 0 to 1:
    n_samples = N;
    figure;
    
    subplot(2, 1, 1);
    a = 1:1000; 
    p = result1;
    length(p);
    stem(a, p);
    set(gca, 'xlim', [1 1000]);
    xlabel('Geometric Distribution p=0.7, N=1000');
    %hold on;
    %plot(result1, '--k');
    
    str = sprintf('%d Generated Data', N);
    title(str);
    
    subplot(2, 1, 2);
    a = 1:1000; 
    p = result2;
    stem(a, p);
    set(gca, 'xlim', [1 1000]);
    xlabel('Geometric Distribution p=0.5, N=1000');
    %hold on;
    %plot(result2, '--k');
    
    figure;
    
    % Calculate histogram with bin width 0.1:
    subplot(2,2,1);
    binwidth = 1;
    bins = 1:1:50;
    N = histcounts(result1,bins);  % Number of x values in each bin
    f = N/n_samples/binwidth; % Observed frequency per x unit 
    bin_centres = (bins(1:end-1)+bins(2:end))/2;
    %bar(bin_centres, f);
    stem(bin_centres, f);
    hold on;
    plot(bin_centres, f, 'r', 'LineWidth', 2);
    legend('Experimental');
    
    % Calculate histogram with bin width 0.1:
    subplot(2,2,2);
    binwidth = 1;
    bins = 1:1:50;
    N = histcounts(result2, bins);  % Number of x values in each bin
    f = N/n_samples/binwidth; % Observed frequency per x unit 
    bin_centres = (bins(1:end-1)+bins(2:end))/2;
    %bar(bin_centres, f);
    stem(bin_centres, f);
    hold on;
    plot(bin_centres, f, 'r', 'LineWidth', 2);
    legend('Experimental');
    
    % Compare with analytic pdf for p1
    subplot(2,2,3);
    n_samples = 50;
    x = 1:1:50;          
    p = p1;
    %p = lambda*exp(-lambda*x); Exponential PDF
    p = (1-p).^(x-1)*p; %Geometric PDF
    hold on;
    h = plot(x,p,'ok');  % Plot the PDF using circles
    set(h,'MarkerFaceColor','w')
    hold off
    str = sprintf('Geometric Distribution: p=0.3');
    title(str);
    legend('Analytical');
    
    % Compare with analytic pdf for p2
    subplot(2,2,4);
    n_samples = 50;
    x = 1:1:50;          
    p = p2;
    %p = lambda*exp(-lambda*x); Exponential PDF
    p = (1-p).^(x-1)*p; %Geometric PDF
    hold on;
    h = plot(x,p,'ok');  % Plot the PDF using circles
    set(h,'MarkerFaceColor','w')
    hold off
    str = sprintf('Geometric Distribution: p=0.5');
    title(str);
    legend('Analytical');
end