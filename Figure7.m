%% display cell type (CD45+) & ROI (New 2022) ==> Fig7A

name1 = 'TNP097';
data1 = eval(strcat('data',name1));
marker1 = 'CD45p';
markname1 = 'CD45+ cells';

figure('units','normalized','outerposition',[0.5 0 0.5 1]);

%-----plot all cells--------
data4 = datasample(data1,50000);
colors = repmat([0.8 0.8 0.8],size(data4,1),1);
scatter(data4.Xt,data4.Yt,6,colors,'fill');
%xlims = xlim;
%ylimx = ylim;

hold on;
%----Plot ROI & labels----
data2 = data1(data1.ROI>0,:);
data2 = datasample(data2,10000,'replace',false);
colors = repmat([0.65 0.65 0.65],size(data2,1),1);
scatter(data2.Xt,data2.Yt,8,colors,'fill');

% for i = 1:6
%     x1 = mean(data1{data1.ROI==i,'Xt'});
%     y1 = mean(data1{data1.ROI==i,'Yt'});
%     text(x1,y1,num2str(i),'FontSize',20,'Color','k');
% end
set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');

%---Plot budding & labels---
data2 = data1(data1.budding>0,:);
colors = repmat([0.5 0.5 0.5],size(data2,1),1);
scatter(data2.Xt,data2.Yt,8,colors,'fill');
%text(mean(data2.Xt),mean(data2.Yt),'TB','FontSize',25,'Color','k');

%---Plot marker -----
data3 = data1(data1{:,marker1},:);
data3 = datasample(data3,20000,'replace',false);
scatter(data3.Xt,data3.Yt,3,'m','fill');
dscatter(data3.Xt,data3.Yt,'PLOTTYPE','CONTOUR');
legend off;

daspect([1 1 1]);

for i = 1:6
    x1 = mean(data1{data1.ROI==i,'Xt'});
    y1 = mean(data1{data1.ROI==i,'Yt'});
    text(x1,y1,num2str(i),'FontSize',20,'Color','k');
end
xlim([50 16000]);
ylim([0 18000]);
text(mean(data2.Xt),mean(data2.Yt),'TB','FontSize',25,'Color','k');

legend('All','ROIs','Budding','CD45+','Density');
set(gca,'xticklabel',[]);
set(gca,'yticklabel',[]);

%% display cell type (CD8+ & CD4+FOXP3+) & ROI (New 2022) ==> Fig7B

name1 = 'TNP097';
data1 = eval(strcat('data',name1));

figure('units','normalized','outerposition',[0.5 0 0.5 1]);

%-----plot all cells--------
data4 = datasample(data1,50000);
colors = repmat([0.8 0.8 0.8],size(data4,1),1);
scatter(data4.Xt,data4.Yt,6,colors,'fill');
%xlims = xlim;
%ylimx = ylim;

hold on;
%----Plot ROI & labels----
data2 = data1(data1.ROI>0,:);
data2 = datasample(data2,10000,'replace',false);
colors = repmat([0.65 0.65 0.65],size(data2,1),1);
scatter(data2.Xt,data2.Yt,8,colors,'fill');

set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');

%---Plot budding & labels---
data2 = data1(data1.budding>0,:);
colors = repmat([0.5 0.5 0.5],size(data2,1),1);
scatter(data2.Xt,data2.Yt,8,colors,'fill');
%text(mean(data2.Xt),mean(data2.Yt),'TB','FontSize',25,'Color','k');

%---Plot marker 1-----
data3 = data1(data1.Celltype==29,:);
%data3 = datasample(data3,20000);
scatter(data3.Xt,data3.Yt,3,'c','fill');

%---Plot marker 1-----
data3 = data1(data1.Celltype==21,:);
%data3 = datasample(data3,20000,'replace',false);
scatter(data3.Xt,data3.Yt,3,'m','fill');
dscatter(data3.Xt,data3.Yt,'PLOTTYPE','CONTOUR');

daspect([1 1 1]);

for i = 1:6
    x1 = mean(data1{data1.ROI==i,'Xt'});
    y1 = mean(data1{data1.ROI==i,'Yt'});
    text(x1,y1,num2str(i),'FontSize',20,'Color','k');
end
xlim([50 16000]);
ylim([0 18000]);
text(mean(data2.Xt),mean(data2.Yt),'TB','FontSize',25,'Color','k');

legend('All','ROIs','Budding','CD8+','CD4+FOXP3+','Density');
set(gca,'xticklabel',[]);
set(gca,'yticklabel',[]);

set(gcf,'color','w');

%% display cell type (PD-L1+) & ROI (New 2022) ==> Fig7C

name1 = 'TNP097';
data1 = eval(strcat('data',name1));

figure('units','normalized','outerposition',[0.5 0 0.5 1]);

%-----plot all cells--------
data4 = datasample(data1,50000);
colors = repmat([0.8 0.8 0.8],size(data4,1),1);
scatter(data4.Xt,data4.Yt,6,colors,'fill');
%xlims = xlim;
%ylimx = ylim;

hold on;
%----Plot ROI & labels----
data2 = data1(data1.ROI>0,:);
data2 = datasample(data2,10000,'replace',false);
colors = repmat([0.65 0.65 0.65],size(data2,1),1);
scatter(data2.Xt,data2.Yt,8,colors,'fill');

set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');

%---Plot budding & labels---
data2 = data1(data1.budding>0,:);
colors = repmat([0.5 0.5 0.5],size(data2,1),1);
scatter(data2.Xt,data2.Yt,8,colors,'fill');
%text(mean(data2.Xt),mean(data2.Yt),'TB','FontSize',25,'Color','k');

%---Plot marker -----
data3 = data1(data1.PDL1p,:);
data3 = datasample(data3,20000,'replace',false);
scatter(data3.Xt,data3.Yt,3,'m','fill');
dscatter(data3.Xt,data3.Yt,'PLOTTYPE','CONTOUR');
legend off;

daspect([1 1 1]);

for i = 1:6
    x1 = mean(data1{data1.ROI==i,'Xt'});
    y1 = mean(data1{data1.ROI==i,'Yt'});
    text(x1,y1,num2str(i),'FontSize',20,'Color','k');
end
xlim([50 16000]);
ylim([0 18000]);
text(mean(data2.Xt),mean(data2.Yt),'TB','FontSize',25,'Color','k');

legend('All','ROIs','Budding','PD-L1+','Density');
set(gca,'xticklabel',[]);
set(gca,'yticklabel',[]);

%% display PD-1::PD-L1 interaction & ROI (New 2022) ==> Fig7D

name1 = 'TNP097';
data1 = eval(strcat('data',name1));

figure('units','normalized','outerposition',[0.5 0 0.5 1]);

%-----plot all cells--------
data4 = datasample(data1,50000);
colors = repmat([0.8 0.8 0.8],size(data4,1),1);
scatter(data4.Xt,data4.Yt,6,colors,'fill');
%xlims = xlim;
%ylimx = ylim;

hold on;
%----Plot ROI & labels----
data2 = data1(data1.ROI>0,:);
data2 = datasample(data2,10000,'replace',false);
colors = repmat([0.65 0.65 0.65],size(data2,1),1);
scatter(data2.Xt,data2.Yt,8,colors,'fill');

set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');

%---Plot budding & labels---
data2 = data1(data1.budding>0,:);
colors = repmat([0.5 0.5 0.5],size(data2,1),1);
scatter(data2.Xt,data2.Yt,8,colors,'fill');
%text(mean(data2.Xt),mean(data2.Yt),'TB','FontSize',25,'Color','k');

%---Plot marker 2(PD-L1+)-----
data3 = data1(data1.PDL1p,:);
%data3 = datasample(data3,20000,'replace',false);
scatter(data3.Xt,data3.Yt,3,'m','fill');


%---Plot marker 1(PD-1+)-----
data3 = data1(data1.PD1p,:);
data3 = datasample(data3,20000);
%data3 = datasample(data3,20000);
scatter(data3.Xt,data3.Yt,3,'c','fill');


%---Plot interaction-----
data3 = data1(data1.PD1intPDL1,:);
dscatter(data3.Xt,data3.Yt,'PLOTTYPE','CONTOUR');

daspect([1 1 1]);

for i = 1:6
    x1 = mean(data1{data1.ROI==i,'Xt'});
    y1 = mean(data1{data1.ROI==i,'Yt'});
    text(x1,y1,num2str(i),'FontSize',20,'Color','k');
end
xlim([50 16000]);
ylim([0 18000]);
text(mean(data2.Xt),mean(data2.Yt),'TB','FontSize',25,'Color','k');

legend('All','ROIs','Budding','PD-L1+','PD-1+','Interaction');
set(gca,'xticklabel',[]);
set(gca,'yticklabel',[]);

set(gcf,'color','w');


%% display PD-1::PD-L1 interaction & ROI (New 2022) ==> Fig7K

name1 = 'TNP097';
data1 = eval(strcat('data',name1));

figure('units','normalized','outerposition',[0.5 0 0.5 1]);

%-----plot all cells--------
data4 = datasample(data1,50000);
colors = repmat([0.8 0.8 0.8],size(data4,1),1);
scatter(data4.Xt,data4.Yt,6,colors,'fill');
%xlims = xlim;
%ylimx = ylim;

hold on;
%----Plot ROI & labels----
data2 = data1(data1.ROI>0,:);
data2 = datasample(data2,10000,'replace',false);
colors = repmat([0.65 0.65 0.65],size(data2,1),1);
scatter(data2.Xt,data2.Yt,8,colors,'fill');

set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');

%---Plot budding & labels---
data2 = data1(data1.budding>0,:);
colors = repmat([0.5 0.5 0.5],size(data2,1),1);
scatter(data2.Xt,data2.Yt,8,colors,'fill');

%---Plot marker 2(PD-L1+)-----
data3 = data1(data1.Celltype==4,:);
scatter(data3.Xt,data3.Yt,5,'m','fill');

%---Plot marker 1(PD-1+)-----
data3 = data1(data1.Celltype==30,:);
scatter(data3.Xt,data3.Yt,5,'c','fill');

%---Plot interaction-----
data3 = data1(data1.Link_4_30,:);
dscatter(data3.Xt,data3.Yt,'PLOTTYPE','CONTOUR');
daspect([1 1 1]);

for i = 1:6
    x1 = mean(data1{data1.ROI==i,'Xt'});
    y1 = mean(data1{data1.ROI==i,'Yt'});
    text(x1,y1,num2str(i),'FontSize',20,'Color','k');
end
xlim([50 16000]);
ylim([0 18000]);
text(mean(data2.Xt),mean(data2.Yt),'TB','FontSize',25,'Color','k');

legend('All','ROIs','Budding','panCK+PD-L1+','CD8+PD-1+','Interaction');
set(gca,'xticklabel',[]);
set(gca,'yticklabel',[]);

set(gcf,'color','w');


%% Single marker comparison (only PD-L1+ pair)==> Fig7I

figure('units','normalized','outerposition',[0.5 0.5 0.25 0.5]);

name1 = 'CD68';

marker1  = strcat('mean_',name1,'p');

list1 = sumPDL1i{:,marker1};
list2 = sumPDL1ni{:,marker1};
myviolin2(list1*100,list2*100,'Int.','non-int.',true);
ytickformat('percentage');
hold on;
%line([1,2],[list1(5)*100,list2(5)*100],'Color','r','LineWidth',2);
title(strcat(name1,'+'),'Interpreter','none');
