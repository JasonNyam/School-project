datapath = '.\Data\singerDb'; 


[V,label2,label10]=computefeatures(datapath);

% Visualisation
dataVisu(V,label2)

% Evualuation of the descriptors system
K=10;
Gt=label2;
scores=[];
for K=1:20
    scores=[scores;precAtK(K,V,Gt)];
end
plot(scores);
[score,K]=max(scores);


% Search by similarity
[x,Fs]=audioread('bent_music.wav');
originalFs = Fs;
desiredFs = 5513;
[p,q] = rat(desiredFs / originalFs);
x=resample(x,p,q);
label= detectVoice( x,K,V,label2);




