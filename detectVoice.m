function [ label ] = detectVoice( x,K,V,label2)
    X=pSpec(x,2048,1024,1024/4);
    X=mean(X'); %mean value over time or mean(X,2) it is the same.
    len=size(V,1);
    dist=zeros(1,80);
    for i=1:len
        dist(i)=norm(V(i,:)-X);
    end
    [~,test]=mink(dist,K);
    label=label2(test);
    label=round(mean(label));
end
