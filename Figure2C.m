%% display cell type (++ cells) & ROI (New 2022) ==> Fig2C

name1 = 'TNP097';
data1 = eval(strcat('data',name1));
marker1 = 'CD20p';
markname1 = 'CD20+ cells';

figure('units','normalized','outerposition',[0.5 0 0.5 1]);

%-----dot plot--------

data4 = datasample(data1,50000);
colors = repmat([0.8 0.8 0.8],size(data4,1),1);
scatter(data4.Xt,data4.Yt,6,colors,'fill');

hold on;
data2 = data1(data1.ROI>0,:);
data2 = datasample(data2,10000,'replace',false);
colors = repmat([0.5 0.5 0.5],size(data2,1),1);
scatter(data2.Xt,data2.Yt,8,colors,'fill');

for i = 1:6
    x1 = mean(data1{data1.ROI==i,'Xt'});
    y1 = mean(data1{data1.ROI==i,'Yt'});
    text(x1,y1,num2str(i),'FontSize',40,'Color','k');
end


data3 = data1(data1{:,marker1},:);
if size(data3,1)>30000
    data3 = datasample(data3,30000,'replace',false);
end
%scatter(data3.Xt,data3.Yt,4,'m','fill','MarkerFaceAlpha',.6,'MarkerEdgeAlpha',.6);
scatter(data3.Xt,data3.Yt,4,'m','fill');
dscatter(data3.Xt,data3.Yt,'PLOTTYPE','contour');colormap(gray);

data2 = data4(data4.CD31p,:);
%if size(data2,1) > 20000
%    data2 = datasample(data2,20000);
%end
scatter(data2.Xt,data2.Yt,3,'c','fill');

set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');
legend({'All','ROIs','CD20+','CD20+ Density','CD31+'},'FontSize',12,'location','northwest');
%legend boxoff;
daspect([1 1 1]);
xlabel('X position');
ylabel('Y position');
set(gca,'xtick',[]);
set(gca,'ytick',[]);
title(name1,'FontSize',20);
