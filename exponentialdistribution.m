function [result1, result2, sampleMean1, sampleMean2, sampleVar1, sampleVar2] = exponentialdistribution(lambda1, lambda2, N)
    
    close all;

    sampleMean1=0;
    result1 = zeros(1, N);
    for i=1:N
        u=rand;
        result1(i)=-1/lambda1.*log(1-u);
        sampleMean1=sampleMean1+result1(i);
    end
    sampleMean1=sampleMean1/N;
    
    sampleMean2=0;
    for i=1:N
        u=rand;
        result2(i)=-1/lambda2.*log(1-u);
        sampleMean2=sampleMean2+result2(i);
    end
    sampleMean2=sampleMean2/N;
    
    %Mean
    mean1 = 1/lambda1;
    mean2 = 1/lambda2;
    
    %Variance
    var1 = 1/(lambda1*lambda1);
    var2 = 1/(lambda2*lambda2);
    
    %Sample Variances
    sampleVar1=0;
    sampleVar2=0;
    for i=1:N
        sampleVar1 = sampleVar1 + ((result1(i)-sampleMean1)*(result1(i)-sampleMean1));
    end
    sampleVar1 = sampleVar1/(N-1);
    
    for i=1:N
        sampleVar2 = sampleVar2 + ((result2(i)-sampleMean2)*(result2(i)-sampleMean2));
    end
    sampleVar2 = sampleVar2/(N-1);
    
    %Plotting CDF with experimental data 
    figure;
    
    subplot(2,2,1);
    [f,x] = ecdf(result1); 
    plot(x,f);
    legend('Experimental');
    
    subplot(2,2,2);
    [f,x] = ecdf(result2); 
    plot(x,f);
    legend('Experimental');
    
    %Plotting CDF with analytical data
    subplot(2,2,3);
    x = 1:1:50;
    c = 1-exp(-lambda1*x);
    hold on;
    h = plot(x,c,'ok');  % Plot the CDF using circles
    set(h,'MarkerFaceColor','w')
    hold off
    str = sprintf('lambda = %d', lambda1);
    title(str);
    legend('Analytical');  
    
    subplot(2,2,4);
    x = 1:1:50;
    c = 1-exp(-lambda2*x);
    hold on;
    h = plot(x,c,'ok');  % Plot the CDF using circles
    set(h,'MarkerFaceColor','w')
    hold off
    str = sprintf('lambda = %d', lambda2);
    title(str);
    legend('Analytical');  
end