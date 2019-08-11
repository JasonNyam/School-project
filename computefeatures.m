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
            a udiopath=strcat(datapath,'\',trackname);
            [y,Fs]=audioread(audiopath);
            X=pSpec(y,2048,1024,1024/4);
            X=mean(X'); %mean value over time or X=mean(X,2);
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
