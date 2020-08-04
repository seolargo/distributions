function [result1, result2, sampleMean1, sampleMean2, sampleVariance1, sampleVariance2] = normaldistribution(mean1, mean2, var1, var2, N)
    
    close all;
    
    %Generation of 1000 samples
    sampleMean1=0;
    mu = mean1;
    sigma = var1;
    for i=1:N
        u=rand;
        z=sigma*(sqrt(2*log(1/(1-u))));
        result1(i)=mu+z*cos(2*pi*u);
        %result1(i)=mu+z*sin(2*pi*u);
        sampleMean1=sampleMean1+result1(i);
    end
    sampleMean1=sampleMean1/N;
    
    sampleMean2=0;
    mu = mean2;
    sigma = var2;
    for i=1:N
        u = rand;
        z=sigma*(sqrt(2*log(1/(1-u))));
        result2(i)=mu+z*cos(2*pi*u);
        %result2(i)=mu+z*sin(2*pi*u);
        sampleMean2=sampleMean2+result2(i);
    end
    sampleMean2=sampleMean2/N;
    
    %Calculate sample variance
    sampleVariance1=0;
    sampleVariance2=0;
    
    for i=1:N
        sampleVariance1 = sampleVariance1 + ((result1(i)-sampleMean1)*(result1(i)-sampleMean1));
    end
    sampleVariance1 = sampleVariance1/(N-1);
    
    for i=1:N
        sampleVariance2 = sampleVariance2 + ((result2(i)-sampleMean2)*(result2(i)-sampleMean2));
    end
    sampleVariance2 = sampleVariance2/(N-1);
    
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
    c = 1/2*(1+erf((x-mean1)/sqrt(var1*2)));
    hold on;
    h = plot(x,c,'ok');  % Plot the CDF using circles
    set(h,'MarkerFaceColor','w')
    hold off
    str = sprintf('mean = %d, var = %d', mean1, var1);
    title(str);
    legend('Analytical');  
    
    subplot(2,2,4);
    x = 1:1:50;
    c = 1/2*(1+erf((x-mean2)/sqrt(var2*2)));
    hold on;
    h = plot(x,c,'ok');  % Plot the CDF using circles
    set(h,'MarkerFaceColor','w');
    hold off;
    str = sprintf('mean = %d, var = %d', mean1, var1);
    title(str);
    legend('Analytical');  
    
end