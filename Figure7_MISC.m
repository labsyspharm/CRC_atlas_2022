%% PD-1 & PD-L1 interaction (all slides)

k=10;
minD = 15;
tic;
for i = 1:length(slideName)
    disp(strcat('Processing:',slideName{i}));
    data1 = eval(strcat('data',slideName{i}));
    
    % ---- Calculate interaction----
    [idx,d]=knnsearch(data1{:,{'Xt','Yt'}},data1{data1.PD1p,{'Xt','Yt'}},'k',k+1);
    idx = idx(:,2:k+1);
    d = d(:,2:k+1);
    idx1 = idx(d<=minD);
    idx1 = unique(idx1);
    data1.PD1nb = false(size(data1,1),1);
    data1.PD1nb(idx1) = true;
    toc;
    
    [idx,d]=knnsearch(data1{:,{'Xt','Yt'}},data1{data1.PDL1p,{'Xt','Yt'}},'k',k+1);
    idx = idx(:,2:k+1);
    d = d(:,2:k+1);
    idx1 = idx(d<=minD);
    idx1 = unique(idx1);
    data1.PDL1nb = false(size(data1,1),1);
    data1.PDL1nb(idx1) = true;
    toc;
    
    data1.PD1intPDL1 = false(size(data1,1),1);
    data1.PD1intPDL1(data1.PD1p & data1.PDL1nb) = true;
    data1.PD1intPDL1(data1.PDL1p & data1.PD1nb) = true;
    eval(strcat('data',slideName{i},'=data1;'));
end

%% assign allPD1/PDL1

allPD1i = alldata(alldata.PD1p & alldata.PD1intPDL1,:);
allPDL1i = alldata(alldata.PDL1p & alldata.PD1intPDL1,:);
sumPD1i = varfun(@mean,allPD1i,'GroupingVariables','slideName');
sumPDL1i = varfun(@mean,allPDL1i,'GroupingVariables','slideName');

allPD1ni = alldata(alldata.PD1p & ~alldata.PD1intPDL1,:);
allPDL1ni = alldata(alldata.PDL1p & ~alldata.PD1intPDL1,:);
sumPD1ni = varfun(@mean,allPD1ni,'GroupingVariables','slideName');
sumPDL1ni = varfun(@mean,allPDL1ni,'GroupingVariables','slideName');


%% plot PD-1 PD-L1 cells composition (in all PD1-PDL1 pairs)
figure('units','normalized','outerposition',[0 0 1 1]);

subplot(2,2,1);
violinplot(sumPDL1i{:,strcat('mean_',labelp2)});
set(gca,'xticklabels',labelp3);
set(gca,'xticklabelrotation',90);
xlim([0 length(labelp3)+1]);
title('PD-L1+(in PD1-PDL1) cells');

subplot(2,2,2);
violinplot(sumPDL1ni{:,strcat('mean_',labelp2)});
set(gca,'xticklabels',labelp3);
set(gca,'xticklabelrotation',90);
xlim([0 length(labelp3)+1]);
title('PD-L1+(not in PD1-PDL1) cells');

subplot(2,2,3);
violinplot(sumPD1i{:,strcat('mean_',labelp2)});
set(gca,'xticklabels',labelp3);
set(gca,'xticklabelrotation',90);
xlim([0 length(labelp3)+1]);
title('PD-1+(in PD1-PDL1) cells');

subplot(2,2,4);
violinplot(sumPD1ni{:,strcat('mean_',labelp2)});
set(gca,'xticklabels',labelp3);
set(gca,'xticklabelrotation',90);
xlim([0 length(labelp3)+1]);
title('PD-1+(not in PD1-PDL1) cells');

%% Pair-wise violinplot for interactor and non-interactors (PD1+ and PDL1+);
figure('units','normalized','outerposition',[0 0 1 1]);

for i = 1:length(labelp2)
    marker1 = strcat('mean_',labelp2{i});
    list1 = sumPDL1i{:,marker1};
    list2 = sumPDL1ni{:,marker1};
    subplot(4,4,i)
    myviolin2(list1,list2,'Int.','Non-int.');
    title(labelp3{i},'fontsize',12);
end
