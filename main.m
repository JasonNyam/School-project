datapath = '.\Data\singerDb'; 

[V,label2,label10]=computefeatures(datapath);
function [ V,label2,label10 ] = computefeatures(datapath)
    struct=dir(datapath);
    names={struct.name};
    len=length(names);
    V=[];
    label2=[];
    label10=[];
    alphabets=['a','b','c','d','e','f','g','h','i','j'];
    for i=1:len
        trackname=char(names(i));
        if ~isempty(strfind(trackname, '.wav'))
            audiopath=strcat(datapath,'\',trackname);
            [y,Fs]=audioread(audiopath);
            X=pSpec(y,2048,1024,1024/4);
            X=mean(X'); % mean value over time or X=mean(X,2);
            V=[V;X];

            if ~isempty(strfind(trackname,'voice'))
                label2=[label2;1];
            else
                label2=[label2;2];
            end
            index=find(alphabets==trackname(1));
            label10=[label10;index];
        end
    end
end 

function [ X ] = pSpec( x,nfft,nwin,hopsize)
    S=spectrogram(x,nwin,hopsize,nfft);
    X=abs(S);
end

dataVisu(V,label2)

function dataVisu( V,label)
    [coeff,score]=pca(V);
    gscatter(score(:,1),score(:,2),label);
end

K=10;
Gt=label2;
scores=[];
for K=1:20
    scores=[scores;precAtK(K,V,Gt)];
end
plot(scores);
[~,K]=max(scores);
score=precAtK(K,V,Gt;
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

[x,Fs]=audioread('bent_music.wav');
originalFs = 44100;
desiredFs = 5513;
[p,q] = rat(desiredFs / originalFs);
x=resample(x,p,q);
label= detectVoice( x,K,V,label2);

function [ label ] = detectVoice( x,K,V,label2)
    X=pSpec(x,2048,1024,1024/4);
    X=mean(X'); % mean value over time or mean(X,2) it is the same.
    len=size(V,1);
    dist=zeros(1,80);
    for i=1:len
        dist(i)=norm(V(i,:)-X);
    end
    [~,test]=mink(dist,K);
    label=label2(test);
    label=round(mean(label));
end

