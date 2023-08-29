clc;clear;close all;
data = readmatrix('Table_NRMS_Record1.xlsx','Sheet', 1, 'Range', 'B2:C617');
%%
figure;
% average NRMS with respect to different missing type
dat_cul = 0;
for n = 1:14
    for i = 1:11
        for j = 1:4
            dat_cul = data((n-1)*44+j+(i-1)*4,1)+dat_cul;
        end
        dat_typ(i) = dat_cul/4;
        dat_cul = 0;
    end
     subplot(7,2,n);
    X = categorical({'AE','AG','AL','AN','AW','C','NE','NG','NL','NN','NW'});
    X = reordercats(X,{'AE','AG','AL','AN','AW','C','NE','NG','NL','NN','NW'});
    bar(X,dat_typ);
    xlabel(['Data',num2str(n)]);
    ylabel('NRMS_{average}');
end

figure
% average Runtime with respect to different missing type
dat_runtime = 0;
for n = 1:14
    for i = 1:11
        for j = 1:4
            dat_runtime = data((n-1)*44+j+(i-1)*4,2)+dat_runtime;
        end
        dat_time(i) = dat_runtime/4;
        dat_runtime = 0;
    end
     subplot(7,2,n);
    X = categorical({'AE','AG','AL','AN','AW','C','NE','NG','NL','NN','NW'});
    X = reordercats(X,{'AE','AG','AL','AN','AW','C','NE','NG','NL','NN','NW'});
    bar(X,dat_time);  
    xlabel(['Data',num2str(n)]);
    ylabel('Runtime_{Average}');
end
%%
figure
% average Runtime with respect to different missing type
nrms_1 = 0;
nrms_5 = 0;
nrms_10 = 0;
nrms_20 = 0;
for n = 1:14
    for i = 1:11
        nrms_1 = data((n-1)*44+(i-1)*4+1,2)+nrms_1;
        nrms_5 = data((n-1)*44+(i-1)*4+2,2)+nrms_5;
        nrms_10 = data((n-1)*44+(i-1)*4+3,2)+nrms_10;
        nrms_20 = data((n-1)*44+(i-1)*4+4,2)+nrms_20;
    end
    run_time(n,:) = [nrms_1 nrms_5 nrms_10 nrms_20]/11;
    nrms_1 = 0;
    nrms_5 = 0;
    nrms_10 = 0;
    nrms_20 = 0;
end
% subplot(7,2,n);
%     X = categorical({'Data1','Data2','Data3','Data4','Data5','Data6','Data7','Data8','Data9','Data10','Data11'});
%     X = reordercats(X,{'AE','AG','AL','AN','AW','C','NE','NG','NL','NN','NW'});
%     X=1:14;
    bar(run_time);  
    xlabel('Data');
    ylabel('Runtime_{Average}');
    legend({'1%','5%','10%','20%'});

    
    %%
figure
% average Runtime with respect to different missing type
nrms_1 = 0;
nrms_5 = 0;
nrms_10 = 0;
nrms_20 = 0;
for n = 1:14
    for i = 1:11
        nrms_1 = data((n-1)*44+(i-1)*4+1,1)+nrms_1;
        nrms_5 = data((n-1)*44+(i-1)*4+2,1)+nrms_5;
        nrms_10 = data((n-1)*44+(i-1)*4+3,1)+nrms_10;
        nrms_20 = data((n-1)*44+(i-1)*4+4,1)+nrms_20;
    end
    NR_MS(n,:) = [nrms_1 nrms_5 nrms_10 nrms_20]/11;
    nrms_1 = 0;
    nrms_5 = 0;
    nrms_10 = 0;
    nrms_20 = 0;
end
% subplot(7,2,n);
%     X = categorical({'Data1','Data2','Data3','Data4','Data5','Data6','Data7','Data8','Data9','Data10','Data11'});
%     X = reordercats(X,{'AE','AG','AL','AN','AW','C','NE','NG','NL','NN','NW'});
%     X=1:14;
    bar(NR_MS);  
    xlabel('Data');
    ylabel('NRMS_{Average}');
    legend({'1%','5%','10%','20%'});