function [ X ] = pSpec( x,nfft,nwin,hopsize)
    S=spectrogram(x,nwin,hopsize,nfft);
    X=abs(S);
end
