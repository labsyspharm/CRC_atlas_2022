%% transformation

for i = 1:length(slideName)
    disp(strcat('Processing:',slideName{i}));
    %no = '029';
    idx = i;
    aff90 = [0,1,0;-1,0,0;31000,0,1];

    %test1=readmatrix(strcat('TNPCRC_',no,'.ome.tif-to-TNPCRC_',no,'.ome.tif.csv'));
    data1 = eval(strcat('data',slideName{i}));
    %data3 = dataTNP002;
    tform = affine2d(affine1{idx}');

    [data1.Xtt,data1.Ytt]=transformPointsForward(tform,data1.Xt./0.65,data1.Yt./0.65);
    tform = affine2d(aff90);
    [data1.Xtt,data1.Ytt]=transformPointsForward(tform,data1.Xtt,data1.Ytt);
    data1.Xtt = data1.Xtt * 0.65;
    data1.Ytt = data1.Ytt * 0.65;
    eval(strcat('data',slideName{i},'=data1;'));
end

%% assign unified coordinates 

dd =200;

tic;
for i = 1:length(slideName)
    disp(strcat('Processing:',slideName{i}));
    data1 = eval(strcat('data',slideName{i}));
    slice = slideName{i};
    slice = uint16(str2double(slice(end-2:end)));
    data1.slice = repmat(slice,size(data1,1),1);

    for col = 1:100
        for row = 1:100
            xl = (col-1)*dd;
            xh = col*dd;
            yl = (row-1)*dd;
            yh = row*dd;
            flag1 = data1.Xtt>xl & data1.Xtt<=xh & data1.Ytt>yl & data1.Ytt<=yh;
            data1.col(flag1) = col;
            data1.row(flag1) = row;
            data1.frame(flag1) = col + (row-1)*100;
        end
    end
    toc;
    eval(strcat('data',slideName{i},'=data1;'));
end

%% Make movie (single marker 2D)

h = figure;
set(gcf,'color','w');

xlims = [0 20000];
ylims = [0 20000];
marker1 = 'CD20KNN';
cax = [4 10];
filename = 'CD20KNN.gif';

for i = 1:length(slideName)
    data1 = eval(strcat('data',slideName{i}));
    CycIF_tumorviewTT(data1,marker1,1);
    xlim(xlims);
    ylim(ylims);
    caxis(cax);
    daspect([1 1 1]);
    title(slideName{i});
    drawnow;
    frame = getframe(h);
    im = frame2im(frame);
    [imind,cm]=rgb2ind(im,256);
    if i ==1
        imwrite(imind,cm,filename,'gif','Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
    
    pause(0.2);
    
end


%% Make movie (3D cell types)

h = figure('units','normalized','outerposition',[0.5 0 0.5 1]);
set(gcf,'color','w');

marker1 = 'topics';
filename = '3D_1.gif';

h1=scatter3(subdata2.Xtt,subdata2.Ytt,subdata2.Ztt,5,'k','fill');
set(h1, 'MarkerEdgeAlpha', 0.5, 'MarkerFaceAlpha', 0.5);

xlims = xlim;
ylims = ylim;
zlims = zlim;

for i = 1:21
    h1=scatter3(subdata2.Xtt,subdata2.Ytt,subdata2.Ztt,5,'k','fill');
    set(h1, 'MarkerEdgeAlpha', 0.1, 'MarkerFaceAlpha', 0.1);
    hold on;
    subdata3 = subdata2(subdata2.NewType==i,:);
    scatter3(subdata3.Xtt,subdata3.Ytt,subdata3.Ztt,12,'m','fill');
    hold off;
    xlim(xlims);
    ylim(ylims);
    zlim(zlims);
    %daspect([1 1 1]);
    title(tableNewTypeName.Markers(i),'FontSize',14);
    
    drawnow;
    frame = getframe(h);
    im = frame2im(frame);
    [imind,cm]=rgb2ind(im,256);
    if i ==1
        imwrite(imind,cm,filename,'gif','Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
    
    pause(1);
    
end

%% PD1-PDL1 in 3D
% dataPD1 = subdata2(subdata2.PD1p,:);
% dataPDL1 = subdata2(subdata2.PDL1p,:);
dataPD1 = alldata(alldata.NewType==20,:);
dataPDL1 = alldata(alldata.NewType==17,:);

figure('units','normalized','outerposition',[0.5 0 0.5 1]);
set(gcf,'color','w');

data2 = datasample(alldata,200000);
h1=scatter3(data2.Xtt,data2.Ytt,data2.Ztt,5,'k','fill');
set(h1, 'MarkerEdgeAlpha', 0.5, 'MarkerFaceAlpha', 0.5);
hold on;
scatter3(dataPD1.Xtt,dataPD1.Ytt,dataPD1.Ztt,5,'r','fill');
scatter3(dataPDL1.Xtt,dataPDL1.Ytt,dataPDL1.Ztt,5,'g','fill');
legend('all cells','PD-1+','PD-L1+');

[idx,d]=knnsearch(dataPDL1{:,{'Xtt','Ytt','Ztt'}},dataPD1{:,{'Xtt','Ytt','Ztt'}},'k',1);
intPDL1= dataPDL1(idx,:);
intPD1 = dataPD1;
flag1 = d>0 & d<=30;
intPD1 = intPD1(flag1,:);
intPDL1 = intPDL1(flag1,:);

figure('units','normalized','outerposition',[0.3 0 0.7 1]);
set(gcf,'color','w');
h1=scatter3(data2.Xtt,data2.Ytt,data2.Ztt,5,'k','fill');
set(h1, 'MarkerEdgeAlpha', 0.1, 'MarkerFaceAlpha', 0.1);
hold on;
%scatter3(dataPD1.Xtt,dataPD1.Ytt,dataPD1.Ztt,10,'m','fill');
%scatter3(dataPDL1.Xtt,dataPDL1.Ytt,dataPDL1.Ztt,10,'c','fill');


for i = 1:size(intPD1,1)
    if intPD1.slice(i)==intPDL1.slice(i)
        c1 = 'm';
    else
        c1 = 'c';
    end
    plot3([intPD1.Xtt(i),intPDL1.Xtt(i)],[intPD1.Ytt(i),intPDL1.Ytt(i)],[intPD1.Ztt(i),intPDL1.Ztt(i)],'-','Color',c1,'LineWidth',3);
end

%legend('all cells','PD-1+','PD-L1+');


%% final plot

figure('units','normalized','outerposition',[0.3 0 0.7 1]);
set(gcf,'color','w');
c1 = repmat([0.5,0.5,0.5],size(data2,1),1);
h1=scatter(data2.Xtt,data2.Ytt,5,c1,'fill');
hold on;

flag1 = (intPD1.slice == intPDL1.slice);
scatter(intPD1{flag1,'Xtt'},intPD1{flag1,'Ytt'},5,'r','fill');
flag1 = (intPD1.slice ~= intPDL1.slice);
scatter(intPD1{flag1,'Xtt'},intPD1{flag1,'Ytt'},5,'g','fill');

set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');
legend('All cells','Intra-slice','Inter-slice');
title('PD1-PDL1 interaction map');
daspect([1 1 1]);
%% Calculate variability across z-axis

cv_sumAll = varfun(@(X) std(X)./mean(X),sumAlldata(:,2:end),'GroupingVariables',{'mean_col','mean_row'});
mean_sumAll = varfun(@mean,sumAlldata(:,2:end),'GroupingVariables',{'mean_col','mean_row'});

cv_sumAll = cv_sumAll(cv_sumAll.GroupCount>9,:);
mean_sumAll = mean_sumAll(mean_sumAll.GroupCount>9,:);

%% plots variability across z-axis

name1 = 'CD45';

figure,
subplot(1,2,1);
test1 = mean_sumAll;
scatter(test1.mean_col,test1.mean_row,20,test1{:,strcat('mean_mean_',name1,'p')},'fill');
set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');
colormap(jet);colorbar;
title(strcat('mean(',name1,'+)'));
daspect([1 1 1]);
xlim([5 95]);
ylim([5 95]);


subplot(1,2,2);
test1 = cv_sumAll;
scatter(test1.mean_col,test1.mean_row,20,test1{:,strcat('Fun_mean_',name1,'p')},'fill');
set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');
colormap(jet);colorbar;
title(strcat('CV(',name1,'+)'));
daspect([1 1 1]);
xlim([5 95]);
ylim([5 95]);
caxis([0.4 4.4]);

%% Calculate variations in 3D (xy versus z)

sum1 = sumAlldata(sumAlldata.mean_slice ==2,:);

sum2 = sumAlldata(ismember(sumAlldata.frame,sum1.frame),:);
sumSum2 = varfun(@(x) std(x)./mean(x),sum2(:,2:end),'GroupingVariables','frame');

sumSum2 = sumSum2(sumSum2.GroupCount > 3,:);
sum1d = sum1(ismember(sum1.frame, sumSum2.frame),:);

sumSum3 = varfun(@mean,sum2(:,2:end),'GroupingVariables','frame');

figure,scatter(sum1d.mean_Xtt,sum1d.mean_Ytt,10,sum1d.mean_CD45p,'fill');
colormap(jet);colorbar;
set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');

figure,scatter(sum1d.mean_Xtt,sum1d.mean_Ytt,10,sum1d.Fun_mean_PDL1p,'fill');
colormap(jet);colorbar;
set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');

sum1d = removevars(sum1d, 'slideName');
sum1d = join(sum1d,sumSum2,'keys','frame','KeepOneCopy','frame');
sum1d = join(sum1d,sumSum3,'keys','frame','KeepOneCopy','frame');

list1 = knnsearch([sum1d.mean_Xtt,sum1d.mean_Ytt],[sum1d.mean_Xtt,sum1d.mean_Ytt],'k',10);


%% Plot variations between xy & z
name1 = 'CD20';

array1 = sum1d{:,strcat('mean_',name1,'p')}(list1);
cv1 = std(array1,0,2)./mean(array1,2);

figure;

subplot(2,2,1);
scatter(sum1d.mean_Xtt,sum1d.mean_Ytt,15,cv1,'fill');
colormap(jet);colorbar;
set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');
title('CV in XY-axes');

subplot(2,2,2);
cv2 = sum1d{:,strcat('Fun_mean_',name1,'p')};
scatter(sum1d.mean_Xtt,sum1d.mean_Ytt,15,cv2,'fill');
colormap(jet);colorbar;
set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');
title('CV in Z-axis');

ax4=subplot(2,2,4);
mean1 = sum1d{:,strcat('mean_mean_',name1,'p')};
scatter(sum1d.mean_Xtt,sum1d.mean_Ytt,15,mean1,'fill');
colormap(ax4,cool);colorbar;
title('mean in Z-axis');
set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');

subplot(2,2,3);
scatter(cv1,cv2,10,sum1d.frame,'fill');
r1 = corr(cv1,cv2,'rows','complete','Type','Spearman');
h1=lsline;
set(h1,'LineWidth',2,'Color','k');
xlabel('CV in XY');
ylabel('CV in Z');
title(strcat(name1,'(r=',num2str(r1,'%0.2f'),')'));
colorbar;

%% Make movie (single marker 2D for CD20KNN)

h = figure;
set(gcf,'color','w');

xlims = [0 20000];
ylims = [0 20000];
marker1 = 'CD20KNN';
%cax = [4 10];
filename = 'CD20KNN.gif';
color1 = [0,0,1;0,1,0;1,0,0];

for i = 1:length(slideName)
    data1 = eval(strcat('data',slideName{i}));
    CycIF_tumorviewTT(data1,marker1,4);
    colormap(color1);
    colorbar off;
    xlim(xlims);
    ylim(ylims);

    daspect([1 1 1]);
    title(slideName{i});
    drawnow;
    frame = getframe(h);
    im = frame2im(frame);
    [imind,cm]=rgb2ind(im,256);
    if i ==1
        imwrite(imind,cm,filename,'gif','Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
    
    pause(0.2);
    
end

%% PD1-PDL1 in 3D

dataCD20 = alldata(alldata.CD20p,:);

figure('units','normalized','outerposition',[0.5 0 0.5 1]);
set(gcf,'color','w');

data2 = datasample(alldata,200000);
h1=scatter3(data2.Xtt,data2.Ytt,data2.Ztt,5,'k','fill');
set(h1, 'MarkerEdgeAlpha', 0.5, 'MarkerFaceAlpha', 0.5);
hold on;
scatter3(dataCD20.Xtt,dataCD20.Ytt,dataCD20.Ztt,5,'g','fill');
legend('all cells','CD20+');


%% Segmentation of TLSs
data0 = dataTNP002;
data0.cellID = (1:size(data0,1))';

data1 = data0(data0.CD20KNN>0,:);
data2 = datasample(data0,50000);

pc1 = pointCloud(double([data1.Xtt,data1.Ytt,data1.slice]));
label1=pcsegdist(pc1,200);
data1.label1 = label1;

table1 = tabulate(data1.label1);
table1 = tabulate(data1.label1);
table1 = table1(table1(:,2)>150,:);
data1 = data1(ismember(data1.label1,table1(:,1)),:);

%figure,CycIF_tumorview(data2,'CD20p',2);
%hold on;
%CycIF_tumorview(data1,'label1',9,0);
%set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');
data0.TLS = zeros(size(data0,1),1);
data0.TLS(data1.cellID) = data1.label1;
figure,CycIF_tumorviewTT(data0,'TLS',9,0);

%% Segmentation allCD20K

data1 = allCD20K;
pc1 = pointCloud(double([data1.Xtt,data1.Ytt,data1.Ztt]));
label1=pcsegdist(pc1,100);
data1.label1 = label1;
figure,pcshow(pc1.Location,label1,'MarkerSize',12);

table1 = tabulate(data1.label1);
table1 = table1(table1(:,2)>300,:);
data1 = data1(ismember(data1.label1,table1(:,1)),:);
data1 = data1(~ismember(data1.label1,70),:);
pc2 = pointCloud(double([data1.Xtt,data1.Ytt,data1.Ztt]));
figure,pcshow(pc2.Location,data1.label1,'MarkerSize',12);

%figure,CycIF_tumorview(data2,'CD20p',2);
%hold on;
%CycIF_tumorview(data1,'label1',9,0);
%set(gca,'XAxisLocation','bottom','YAxisLocation','left','ydir','reverse');
data2 = datasample(alldata,200000);
figure;
h1=scatter(data2.Xtt,data2.Ytt,5,'k','fill');
set(h1, 'MarkerEdgeAlpha', 0.1, 'MarkerFaceAlpha', 0.1);
hold on;
CycIF_tumorviewTT(data1,'label1',9,0);
allCD20Net = data1;
clear data1 data2 allCD20K;

%% plot just one cluster

data1 = allCD20Net;
TLS80 = data1(data1.label1 ==80,:);
pc80 = pointCloud(double([TLS80.Xtt,TLS80.Ytt,TLS80.Ztt]));
figure,pcshow(pc80);

OptionZ.FrameRate=15;OptionZ.Duration=5.5;OptionZ.Periodic=true;
CaptureFigVid([-20,10;-110,10;-190,80;-290,10;-380,10], 'TLS80',OptionZ)

%% Generate allCD20Net and sumCD20Net

allCD20Net = join(allCD20Net,tableNewType,'keys','KNNtype');

for i=1:21
    marker1 = strcat('Type',num2str(i));
    allCD20Net{:,marker1}=false(size(allCD20Net,1),1);
    allCD20Net{allCD20Net.NewType==i,marker1}=true;
end

sumAllCD20Net = varfun(@mean,allCD20Net,'GroupingVariable','label1');
sumCD20Net = sumAllCD20Net;
sumCD20Net = removevars(sumCD20Net, {'mean_Hoechst0','mean_Hoechst1','mean_Hoechst2','mean_Hoechst3','mean_Hoechst4','mean_Hoechst5','mean_Hoechst6','mean_Hoechst7','mean_Hoechst8','mean_Hoechst9','mean_AF488','mean_A488','mean_CD3','mean_Ki67','mean_CD4','mean_CD20','mean_CD163','mean_Ecadherin','mean_LaminABC','mean_PCNA','mean_AF555','mean_A555','mean_NaKATPase','mean_Keratin','mean_CD45','mean_CD68','mean_FOXP3','mean_Vimentin','mean_Desmin','mean_Ki67_570','mean_AF647','mean_A647','mean_CD45RO','mean_aSMA','mean_PD1','mean_CD8a','mean_PDL1','mean_CDX2','mean_CD31','mean_Collagen','mean_AREA','mean_CIRC','mean_X','mean_Y','mean_frame','mean_COL','mean_ROW','mean_Xt','mean_Yt','mean_GMM12','mean_ROI','mean_ROIp'});
sumCD20Net = removevars(sumCD20Net, {'mean_Region','mean_cell_idx','mean_Celltype','mean_KNNtype','mean_budding','mean_budtumor','mean_bud5','mean_budNeighbor','mean_budsize','mean_budsize2','mean_ShuBud','mean_ShuNeighbor','mean_NB_4','mean_NB_27','mean_NB_22','mean_NB_30','mean_Link_4_22','mean_Link_4_30','mean_Link_27_22','mean_Link_27_30','mean_topics'});
sumCD20Net = removevars(sumCD20Net, {'mean_slice','mean_col','mean_row','mean_TDist','mean_CD20KNN'});
allCD20Net = join(allCD20Net,sumCD20Net,'Keys','label1');
