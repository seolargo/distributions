function [result1, result2, sampleMean1, sampleVar1, sampleMean2, sampleVar2] = poissondistribution(lambda1, lambda2, N)
    close all;

%     for i=1:N
%         result1(i) = poissrnd(lambda1);
%         result2(i) = poissrnd(lambda2);
%     end
    
    sampleMean1=0;
    sampleMean2=0;
    
    %Generating samples
    for i=1:N
        k=0;
        p=1;
        u=rand;
        p=p*u;
        while p>=exp(-lambda1)
            u=rand;
            p=p*u;
            k=k+1;
        end
        result1(i)=k;
        sampleMean1=sampleMean1+result1(i);
    end
    sampleMean1 = sampleMean1/N;
    
    for i=1:N
        k=0;
        p=1;
        u=rand;
        p=p*u;
        while p>=exp(-lambda2)
            u=rand;
            p=p*u;
            k=k+1;
        end
        result2(i)=k;
        sampleMean2=sampleMean2+result2(i);
    end
    sampleMean2 = sampleMean2/N;
    
    %Sample Variances
    sampleVar1=0;
    sampleVar2=0;
    
    nSize=N;
    for i=1:nSize
        sampleVar1 = sampleVar1 + ((result1(i)-sampleMean1)*(result1(i)-sampleMean1));
    end
    sampleVar1 = sampleVar1/(N-1);
    
    for i=1:nSize
        sampleVar2 = sampleVar2 + ((result2(i)-sampleMean2)*(result2(i)-sampleMean2));
    end
    sampleVar2 = sampleVar2/(N-1);
        
    %Mean
    mean1 = lambda1;
    mean2 = lambda2;
    
    %Variance
    variance1 = lambda1;
    variance2 = lambda2;
    
    % Draw random samples from uniform distribution in range 0 to 1:
    n_samples = N;
    figure;
    
    subplot(2,1,1);
    a = 1:1000; 
    p = result1;
    stem(a, p);
    set(gca, 'xlim', [1 1000]);
    xlabel('Poisson distribution lambda=6, N=1000');
    hold on;
    %plot(result1, '--k');
    
    str = sprintf('%d Generated Data', N);
    title(str);
    
    subplot(2,1,2);
    a = 1:1000; 
    p = result2;
    stem(a, p);
    set(gca, 'xlim', [1 1000]);
    xlabel('Poisson distribution lambda=4.5, N=1000');
    hold on;
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
    
    % Compare with analytic pdf for lambda1
    subplot(2, 2, 3);
    %figure;
    for x=1:50
        c(x) = (lambda1.^x)*exp(-lambda1)/factorial(x);
    end
    x=1:50;
    hold on;
    length(c)
    length(x)
    h = plot(x,c,'ok');  % Plot the PDF using circles
    set(h,'MarkerFaceColor','w');
    hold off;
    str = sprintf('lambda: %d', 6);
    title(str);
    legend('Analytical');
    
    % Compare with analytic pdf for lambda2
    subplot(2, 2, 4);
    %figure;
    %x = 1:1:3;          
    %p = (lambda2.^x)*exp(-lambda2)/factorial(x);
    for x=1:50
        c(x) = (lambda2.^x)*exp(-lambda2)/factorial(x);
    end
    x=1:50;
    hold on;
    h = plot(x,c,'ok');  % Plot the PDF using circles
    set(h,'MarkerFaceColor','w');
    hold off;
    str = sprintf('Binomial Distribution: n=50, p=0.5');
    title(str);
    legend('Analytical');   
    
end