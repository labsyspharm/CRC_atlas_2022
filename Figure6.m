%% Plot 2D TLS with 3D outlines (#097 only) ==> Fig6A

data1 = dataTNP097;
figure('units','normalized','outerposition',[0.5 0 0.5 1]);
data2 = datasample(data1,50000,'replace',false);
scatter(data2.Xt,data2.Yt,5,repmat([0.8 0.8 0.8],50000,1),'fill');
xlims = xlim;
ylims = ylim;
hold on;

data4 = data1(data1.ROI>0,:);
data4 = datasample(data4,20000,'replace',false);
scatter(data4.Xt,data4.Yt,6,repmat([0.65 0.65 0.65],20000,1),'fill');

data3 = data1(data1.TLS>0,:);
CycIF_tumorview(data3,'TLS',12);
daspect([1 1 1]);
xlim(xlims);
ylim(ylims);
grid off;

title('2D TLS in #097');


%% Plot 3D network ==> Fig6B
figure('units','normalized','outerposition',[0.5 0 0.5 1]);

%---Plot all cells---
data1 = allsample_re;
data1 = datasample(data1,50000,'replace',false);
scatter(data1.Xtt,data1.Ytt,5,repmat([0.8 0.8 0.8],50000,1),'fill');
xlims = xlim;
ylims = ylim;
hold on;

data1 = allsample_re(allsample_re.ROI>0,:);
data1 = datasample(data1,20000,'replace',false);
scatter(data1.Xtt,data1.Ytt,5,repmat([0.65 0.65 0.65],20000,1),'fill');
xlim(xlims);
ylim(ylims);

%----Plot TLS, colored by clusters----
data2 = allTLS;
CycIF_tumorviewTTX(data2,'label1',9,50000);
xlim(xlims);
ylim(ylims);
grid off;
daspect([1 1 1]);

title('3D Networks (2D projected)');
set(gcf,'color','w');

list1 = [5,7,11,13,14,62,71];
name1 = {'A','B','C','D','E','F','G'};
for i = 1:length(list1)
    data3 = allTLS(allTLS.label1==list1(i),:);
    %k = boundary(data3.Xtt,data3.Ytt);
    %plot(data3.Xtt(k),data3.Ytt(k),'k','LineWidth',1);
    text(mean(data3.Xtt),mean(data3.Ytt),name1{i},'FontSize',18);
end

%% TLS cluster heatmap (CRC1) ==> Fig6D

sum1 = sumAllTLS4;

sum1{:,strcat('mean_',labelp2)} = zscore(sum1{:,strcat('mean_',labelp2)});

sum2 = varfun(@mean,sum1,'GroupingVariables','idx1');

figure('units','normalized','outerposition',[0.4 0.4 0.6 0.6]);


subplot(1,10,1:8.5);
imagesc(sum2{:,strcat('mean_mean_',labelp2)});
colormap(redbluecmap);

set(gca,'xtick',1:length(labelp2));
set(gca,'xticklabels',labelp3);
set(gca,'xticklabelrotation',90);
ylabel('TLS cluster');
caxis([-1.5 1.5]);

subplot(1,10,9:10);
barh(sum2.GroupCount);
set(gca,'ytick',[]);
%set(get(h,'Parent'),'xdir','r')
ylim([0.5 7.5]);
xlabel('TLS count');
text(sum2.GroupCount,1:7,num2str(sum2.GroupCount));
set(gca, 'YDir','reverse')

%% Plot 3D network (outline big clusters) ==> Fig6E (new version)
figure('units','normalized','outerposition',[0.5 0 0.5 1]);

%---Plot all cells---
data1 = allsample_re;
data1 = datasample(data1,50000,'replace',false);
scatter(data1.Xtt,data1.Ytt,5,repmat([0.8 0.8 0.8],50000,1),'fill');
xlims = xlim;
ylims = ylim;

%----Plot TLS, colored by clusters----
hold on;
data2 = allTLS;
CycIF_tumorviewTTX(data2,'idx1',4,0);
colormap(jet(7));
colorbar off;
xlim(xlims);
ylim(ylims);
grid off;
daspect([1 1 1]);

%----Outline large 3D networks----
list1 = [5,7,11,13,14,62,71];
name1 = {'A','B','C','D','E','F','G'};

for i = 1:length(list1)
    data3 = allTLS(allTLS.label1==list1(i),:);
    k = boundary(data3.Xtt,data3.Ytt);
    plot(data3.Xtt(k),data3.Ytt(k),'k','LineWidth',1);
    text(mean(data3.Xtt),mean(data3.Ytt),name1{i},'FontSize',18);
end

set(gcf,'color','w');
title('TLS network (colored by clusters)');

  
%% Generate color legends  ==> Fig 6E

figure,scatter(ones(7,1),1:7,150,1:7,'fill');
colormap(jet(7));
xlim([0.5 1.5]);
ylim([0.5 7.5]);
text(ones(7,1)+0.05,1:7,num2str((1:7)'),'FontSize',20,'HorizontalAlign','left');
box off;
set(gca,'XColor', 'none','YColor','none')
set(gcf,'color','w');



%% 3D view of block 7, with boundary lines  ==> Fig6G

data3 = allTLS(allTLS.label1 ==7,:);

figure('units','normalized','outerposition',[0.5 0 0.5 1]);
scatter3(data3.Xtt,data3.Ytt,data3.Ztt,5,data3.idx1,'fill');
set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');

hold on;
colormap(jet(7));
daspect([1 1 0.15]);
%colorbar;
set(gcf,'color','w');

zlim([0 600]);
ylim([10500 15500]);
xlim([5500 13500]);
view(-16,28);

temp1 = tabulate(data3.slice);
temp1 = temp1(temp1(:,2)>0,:);
for i = 1:size(temp1,1)
    slice = temp1(i,1);
    data4 = data3(data3.slice == slice,:);
    temp2 = tabulate(data4.TLS);
    temp2 = temp2(temp2(:,2)>0,:);
    for j = 1:size(temp2,1)
        TLS = temp2(j,1);
        data5 = data4(data4.TLS == TLS,:);
        k = boundary(data5.Xtt,data5.Ytt);
        %plot3(data5.Xtt(k),data5.Ytt(k),repmat(data5.Ztt(1),length(k),1),'k','LineWidth',1.5);
        scatter3(data5.Xtt(k),data5.Ytt(k),repmat(data5.Ztt(1),length(k),1),5,'k','fill');
        plot3(data5.Xtt(k),data5.Ytt(k),repmat(data5.Ztt(1),length(k),1),'k','LineWidth',1.5);
    end
end


%% 3D view of block 7, Shu's PCA version ==> Fig6H

data3 = allTLS(allTLS.label1 ==7,:);
temp1 = sumAllTLS4(:,{'slice','TLS','PCA1','PCA2','PCA3'});
data3 = join(data3,temp1,'keys',{'slice','TLS'});

% --------------
figure('units','normalized','outerposition',[0.5 0 0.5 1]);
scatter3(data3.Xtt,data3.Ytt,data3.Ztt,3,data3.PCA1,'fill');
set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');

colormap(cool);
daspect([1 1 0.15]);
%colorbar;
set(gcf,'color','w');
title('Color by PC1');
caxis([-3 3]);
colorbar;

zlim([0 600]);
ylim([10500 15000]);
xlim([5500 14000]);
view(-16,28);

% ----------------
figure('units','normalized','outerposition',[0.5 0 0.5 1]);
scatter3(data3.Xtt,data3.Ytt,data3.Ztt,3,data3.PCA2,'fill');
set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');

colormap(cool);
daspect([1 1 0.15]);
%colorbar;
set(gcf,'color','w');
title('Color by PC2');
caxis([-2.5 2.5]);
colorbar;

zlim([0 600]);
ylim([10500 15000]);
xlim([5500 14000]);
view(-16,28);

