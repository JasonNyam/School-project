function score = precAtK(K,V,Gt,mode)
    len=size(V,1);
    dist=zeros(len,len);
        for i=1:len
            for j=1:len
                dist(i,j)=norm(V(i,:)-V(j,:));
            end
        end
    score=0;
    for i=1:len
        [~,test]=mink(dist(i,:),K+1);%indices in test
        test=test(2:K+1)
        for j=1:K; % to eliminate the zero part
            if Gt(i)==Gt(test(j))
                score=score+1;
            end
        end
    end
    score=score/(len*K);
end
