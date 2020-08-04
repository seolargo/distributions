function [result1, result2, sampleMean1, sampleVar1, sampleMean2, sampleVar2] = binomialdistribution(N, n1, p1, n2, p2)
    close all;

    q1 = 1-p1;
    q2 = 1-p2;
    
    %Mean
    mean1 = n1*p1;
    mean2 = n2*p2;
    
    %Variance
    var1 = n1*p1*q1;
    var2 = n2*p2*q2;
    
    %for i=1:N
    %    result1(i)=binornd(n1, p1)
    %    result2(i)=binornd(n2, p2)
    %end
    
    %Calculating sample mean's.
    sampleMean1=0;
    sampleMean2=0;
    
    for i=1:N
        u=rand(1,n1);
        y=(u<=p1);
        result1(i)=sum(y);
        sampleMean1=sampleMean1+result1(i);
    end
    sampleMean1=sampleMean1/N;
    
    for i=1:N
        u=rand(1,n2);
        y=(u<=p2);
        result2(i)=sum(y);
        sampleMean2=sampleMean2+result2(i);
    end
    sampleMean2=sampleMean2/N;
    
    %Calculate sample variance
    sampleVar1=0;
    sampleVar2=0;
    
    nSize = N;
    for i=1:nSize
        sampleVar1 = sampleVar1 + ((result1(i)-sampleMean1)*(result1(i)-sampleMean1));
    end
    sampleVar1 = sampleVar1/(N-1);
    
    for i=1:nSize
        sampleVar2 = sampleVar2 + ((result2(i)-sampleMean2)*(result2(i)-sampleMean2));
    end
    sampleVar2 = sampleVar2/(N-1);
    
    % Draw random samples from uniform distribution in range 0 to 1:
    n_samples = N;
    figure;
    
    subplot(2, 1, 1);
    a = 1:1000; 
    p = result1;
    stem(a, p);
    set(gca, 'xlim', [1 1000]);
    %hold on;
    %plot(result1, '--k');
    xlabel('n=40, p=0.7, N=1000');
    
    str = sprintf('%d Generated Data', N);
    title(str);
    
    subplot(2, 1, 2);
    a = 1:1000; 
    p = result2;
    stem(a, p);
    set(gca, 'xlim', [1 1000]);
    %hold on;
    %plot(result2, '--k');
    xlabel('n=50, p=0.5, N=1000');
    
    figure;
    
    % Calculate histogram with bin width 1:
    subplot(2,2,1);
    binwidth = 1;
    bins = 1:1:50;
    N = histcounts(result1,bins);  % Number of x values in each bin
    f = N/n_samples/binwidth; % Observed frequency per x unit 
    bin_centres = (bins(1:end-1)+bins(2:end))/2;
    %figure;
    %bar(bin_centres, f);
    stem(bin_centres, f);
    hold on;
    plot(bin_centres, f, 'r', 'LineWidth', 2);
    legend('Experimental');
    
    % Calculate histogram with bin width 1:
    subplot(2,2,2);
    binwidth = 1;
    bins = 1:1:50;
    N = histcounts(result2, bins);  % Number of x values in each bin
    f = N/n_samples/binwidth; % Observed frequency per x unit 
    bin_centres = (bins(1:end-1)+bins(2:end))/2;
    %figure;
    %bar(bin_centres, f);
    stem(bin_centres, f);
    hold on;
    plot(bin_centres, f, 'r', 'LineWidth', 2);
    legend('Experimental');
    
    % Compare with analytic pdf for n1 and p1
    subplot(2, 2, 3);
    %figure;
    n_samples = n1;
    x = 1:1:n1;          
    p = p1;
    %p = lambda*exp(-lambda*x); Exponential PDF
    p = (factorial(n_samples)./(factorial(n_samples-x).*factorial(x))).*(p.^x).*((1-p).^(n_samples-x));
    hold on;
    h = plot(x,p,'ok');  % Plot the PDF using circles
    set(h,'MarkerFaceColor','w')
    hold off
    str = sprintf('Binomial Distribution: n=40, p=0.7');
    title(str);
    legend('Analytical');
    
    % Compare with analytic pdf for n2 and p2
    subplot(2, 2, 4);
    %figure;
    n_samples = n2;
    x = 1:1:n2;          
    p = p2;
    %p = lambda*exp(-lambda*x); Exponential PDF
    p = (factorial(n_samples)./(factorial(n_samples-x).*factorial(x))).*(p.^x).*((1-p).^(n_samples-x));
    hold on;
    h = plot(x,p,'ok');  % Plot the PDF using circles
    set(h,'MarkerFaceColor','w')
    hold off
    str = sprintf('Binomial Distribution: n=50, p=0.5');
    title(str);
    legend('Analytical');    
end