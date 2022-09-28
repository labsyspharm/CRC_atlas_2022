%% Generate PD-1 profiling 

tablePD1_1 = zeros(length(slideName),4);  %%  table for PD_L1 positivity in total, panCK+, CD68+ and CD11+ cells
tablePD1_2 = zeros(length(slideName),3);  %%  table counts for PDL1+ & panCK+, CD68+, CD11c+ in each samples

for s = 1:length(slideName)
    data1 = eval(strcat('data',slideName{s}));
    data2 = data1(data1.PD_1p,:);
    
    tablePD1_1(s,1) = sum(data1.PD_1p) / size(data1,1);
    tablePD1_1(s,2) = sum(data1.PD_1p & data1.CD4p) / sum(data1.CD4p);
    tablePD1_1(s,3) = sum(data1.PD_1p & data1.CD8ap) / sum(data1.CD8ap);
    tablePD1_1(s,4) = sum(data1.PD_1p & data1.CD45p & ~data1.CD4p & ~data1.CD8ap) / sum(data1.CD45p & ~data1.CD4p & ~data1.CD8ap);
    
    tablePD1_2(s,1) = sum(data1.PD_1p & data1.CD4p);
    tablePD1_2(s,2) = sum(data1.PD_1p & data1.CD8ap);
    tablePD1_2(s,3) = sum(data1.PD_1p & data1.CD45p & ~data1.CD4p & ~data1.CD8ap);
end


%---- plot 1 ------
figure('units','normalized','outerposition',[0 0.5 1 0.5]);

bar(tablePD1_1*100);
ytickformat('percentage');
legend('Total','CD4+','CD8+','CD45+*');
set(gca,'xtick',1:17);
set(gca,'xticklabels',tableSlideName.newName);
title('Fraction of PD-1+ cells');
grid on;
legend box off

%----Plot 2-----
figure,boxplot(tablePD1_1*100);
set(gca,'xticklabels',{'Total','CD4+','CD8+','CD45+*'});
title('PD-1 positivity in different cells');
ytickformat('percentage');
    
%----Plot 3----
figure,barh(tablePD1_2./sum(tablePD1_2,2),'stacked');


%% PFSdays correlation (PDL1+ in different cells)
table1 = sumAllsampleNew;
table1 = table1(~isnan(table1.PFSDays),:);

y = table1.PFSDays;
x = table1.mean_PD1intPDL1 
mdl = fitlm(x,y,'RobustOpts','on');
figure,plot(mdl);
xlabel('PD-1 int. PD-L1');
ylim([0 1800]);
ylim([-100 1800]);
ylabel('PFS days');

[r,p] = corr(x,y);
title(strcat('r = ',num2str(r,'%0.2f'),' p = ',num2str(p,'%0.3f')));


%% Generate PD-L1 profiling (part 2)

tablePDL1_3 = zeros(length(slideName),4);  %%  table counts for PDL1+ & panCK+, CD68+, CD11c+ in each samples

for s = 1:length(slideName)
    data1 = eval(strcat('data',slideName{s}));
    %data2 = data1(data1.PD_L1p,:);
    
    tablePDL1_3(s,1) = sum(data1.PD_L1p & data1.CD68p & ~data1.CD11cp) / sum(data1.CD68p & ~data1.CD11cp);
    tablePDL1_3(s,2) = sum(data1.PD_L1p & ~data1.CD68p & data1.CD11cp) / sum(~data1.CD68p & data1.CD11cp);
    tablePDL1_3(s,3) = sum(data1.PD_L1p & data1.CD68p & data1.CD11cp) / sum(data1.CD68p & data1.CD11cp);
    tablePDL1_3(s,4) = sum(data1.PD_L1p & ~data1.CD68p & ~data1.CD11cp) / sum(~data1.CD68p & ~data1.CD11cp);
    
end

figure,boxplot(tablePDL1_3*100);
ytickformat('percentage');
set(gca,'xticklabels',{'CD68+CD11c-','CD68-CD11c+','CD68+CD11c+','CD68-CD11c-'});
title('PD-L1 positivity in Myeloid subset');


%% Generate PD-L1 profiling (part 3)

tablePDL1_4 = zeros(length(slideName),4);  %%  table counts for PDL1+ & panCK+, CD68+, CD11c+ in each samples

for s = 1:length(slideName)
    data1 = eval(strcat('data',slideName{s}));
    %data2 = data1(data1.PD_L1p,:);
    
    tablePDL1_4(s,1) = sum(data1.PD_L1p & data1.CD68p & ~data1.CD163p) / sum(data1.CD68p & ~data1.CD163p);
    tablePDL1_4(s,2) = sum(data1.PD_L1p & ~data1.CD68p & data1.CD163p) / sum(~data1.CD68p & data1.CD163p);
    tablePDL1_4(s,3) = sum(data1.PD_L1p & data1.CD68p & data1.CD163p) / sum(data1.CD68p & data1.CD163p);
    tablePDL1_4(s,4) = sum(data1.PD_L1p & ~data1.CD68p & ~data1.CD163p) / sum(~data1.CD68p & ~data1.CD163p);
    
end

figure,boxplot(tablePDL1_4*100);
ytickformat('percentage');
set(gca,'xticklabels',{'CD68+CD163-','CD68-CD163+','CD68+CD163+','CD68-CD163-'});
title('PD-L1 positivity in Macrophage subset');


%% Generate PD-L1 profiling (part 4)

tablePDL1_5 = zeros(length(slideName),4);  %%  table counts for PDL1+ & panCK+, CD68+, CD11c+ in each samples

for s = 1:length(slideName)
    data1 = eval(strcat('data',slideName{s}));
    %data2 = data1(data1.PD_L1p,:);
    
    tablePDL1_5(s,1) = sum(data1.PD_L1p & data1.CD11bp & ~data1.CD11cp) / sum(data1.CD11bp & ~data1.CD11cp);
    tablePDL1_5(s,2) = sum(data1.PD_L1p & ~data1.CD11bp & data1.CD11cp) / sum(~data1.CD11bp & data1.CD11cp);
    tablePDL1_5(s,3) = sum(data1.PD_L1p & data1.CD11bp & data1.CD11cp) / sum(data1.CD11bp & data1.CD11cp);
    tablePDL1_5(s,4) = sum(data1.PD_L1p & ~data1.CD11bp & ~data1.CD11cp) / sum(~data1.CD11bp & ~data1.CD11cp);
    
end

figure,boxplot(tablePDL1_5*100);
ytickformat('percentage');
set(gca,'xticklabels',{'CD11b+CD11c-','CD11b-CD11c+','CD11b+CD11c+','CD11b-CD11c-'});
title('PD-L1 positivity in Myeloid subset');

%% Generate PD-L1 profiling (part 4)

tablePDL1_6 = zeros(length(slideName),4);  %%  table counts for PDL1+ & panCK+, CD68+, CD11c+ in each samples

for s = 1:length(slideName)
    data1 = eval(strcat('data',slideName{s}));
    %data2 = data1(data1.PD_L1p,:);
    
    tablePDL1_6(s,1) = sum(data1.PD_L1p & data1.CD14p & ~data1.CD16p) / sum(data1.CD14p & ~data1.CD16p);
    tablePDL1_6(s,2) = sum(data1.PD_L1p & ~data1.CD14p & data1.CD16p) / sum(~data1.CD14p & data1.CD16p);
    tablePDL1_6(s,3) = sum(data1.PD_L1p & data1.CD14p & data1.CD16p) / sum(data1.CD14p & data1.CD16p);
    tablePDL1_6(s,4) = sum(data1.PD_L1p & ~data1.CD14p & ~data1.CD16p) / sum(~data1.CD14p & ~data1.CD16p);
end

figure,boxplot(tablePDL1_6*100);
ytickformat('percentage');
set(gca,'xticklabels',{'CD14+CD16-','CD14-CD16+','CD14+CD16+','CD14-CD16-'});
title('PD-L1 positivity in Myeloid subset');

%% Generate PD-L1 profiling (part 4)


tablePDL1_7= zeros(length(slideName),3);  %%  table counts for PDL1+ & panCK+, CD68+, CD11c+ in each samples

for s = 1:length(slideName)
    data1 = eval(strcat('data',slideName{s}));
    data2 = data1(data1.PD_L1p,:);
    
    tablePDL1_7(s,1) = sum(data2.panCKp & ~data2.CD45p);
    tablePDL1_7(s,2) = sum(~data2.panCKp & data2.CD45p);
    tablePDL1_7(s,3) = sum(~data2.panCKp & ~data2.CD45p);
end


%---- plot 1 ------

figure,barh(tablePDL1_7*100./sum(tablePDL1_7,2),'stacked');
ytickformat('percentage');
legend('panCK+CD45-','panCK-CD45+','panCK-CD45-');
set(gca,'ytick',1:17);
set(gca,'yticklabels',tableSlideName.newName);
title('Relative abundancy in PD-L1+ cells');
grid on;
xlim([0 100]);
ylim([0.5 17.5]);


%% PD-L1 profling Relative fraction to total cells
tablePDL1_8 = zeros(length(slideName),4);  %%  table for PD_L1 positivity in total, panCK+, CD68+ and CD11+ cells

for s = 1:length(slideName)
    data1 = eval(strcat('data',slideName{s}));
    
    tablePDL1_8(s,1) = sum(data1.PD_L1p) / size(data1,1);
    tablePDL1_8(s,2) = sum(data1.PD_L1p & data1.panCKp) / size(data1,1);
    tablePDL1_8(s,3) = sum(data1.PD_L1p & data1.CD68p) / size(data1,1);
    tablePDL1_8(s,4) = sum(data1.PD_L1p & data1.CD11cp) / size(data1,1);
    
end

%----Plot 2-----
figure,boxplot(tablePDL1_8*100);
set(gca,'xticklabels',{'Total','panCK+','CD68+','CD11c+'});
title('Relative abundancy of PD-L1+ cells');
ytickformat('percentage');

%% PD-L1 profling Relative fraction to total cells
tablePDL1_9 = zeros(length(slideName),4);  %%  table for PD_L1 positivity in total, panCK+, CD68+ and CD11+ cells

for s = 1:length(slideName)
    data1 = eval(strcat('data',slideName{s}));
    
    tablePDL1_9(s,1) = sum(data1.PD_L1p) / size(data1,1);
    tablePDL1_9(s,2) = sum(data1.PD_L1p & data1.panCKp) / sum(data1.PD_L1p);
    tablePDL1_9(s,3) = sum(data1.PD_L1p & data1.CD68p) / sum(data1.PD_L1p);
    tablePDL1_9(s,4) = sum(data1.PD_L1p & data1.CD11cp) / sum(data1.PD_L1p);
    
end

%----Plot 2-----
figure,boxplot(tablePDL1_9*100);
set(gca,'xticklabels',{'Total','panCK+','CD68+','CD11c+'});
title('Relative abundancy of PD-L1+ cells');
ytickformat('percentage');

%% Single marker comparison (only PD-L1+ pair)==> Fig7J

figure('units','normalized','outerposition',[0.5 0.5 0.25 0.5]);

name1 = 'HLA_A';

marker1  = strcat('mean_',name1,'p');

list1 = sumPDL1i{:,marker1};
list2 = sumPDL1ni{:,marker1};
myviolin2(list1*100,list2*100,'Int.','non-int.',true);
ytickformat('percentage');
hold on;
line([1,2],[list1(6)*100,list2(6)*100],'Color','r','LineWidth',2);
title(strcat(name1,'+'),'Interpreter','none');

%% CD68 & CD11c portions

table1 = zeros(length(slideName),3); % in all cells
table2 = zeros(length(slideName),3); % in PDL1+ cells

for i = 1:length(slideName)
    data1 = eval(strcat('data',slideName{i}));
    data2 = data1(data1.PD_L1p,:);
    
    table1(i,1) = sum( data1.CD68p & ~data1.CD11cp );
    table1(i,2) = sum( ~data1.CD68p & data1.CD11cp );
    table1(i,3) = sum( data1.CD68p & data1.CD11cp );
    %table1(i,4) = sum( ~data1.CD68p & ~data1.CD11cp);
    
    table2(i,1) = sum( data2.CD68p & ~data2.CD11cp );
    table2(i,2) = sum( ~data2.CD68p & data2.CD11cp );
    table2(i,3) = sum( data2.CD68p & data2.CD11cp );
    %table2(i,4) = sum( ~data2.CD68p & ~data2.CD11cp);
end

figure('units','normalized','outerposition',[0 0.5 1 0.5]);
bar(table1./sum(table1,2),'stacked');
title('All cells');
    legend('CD68+CD11c-','CD11c+CD68-','CD68+CD11c+');
    xlim([0.5 17.5]);
    set(gca,'xtick',1:17);

figure('units','normalized','outerposition',[0 0.5 1 0.5]);
bar(table2./sum(table2,2),'stacked');
title('PDL1+ cells');
    legend('CD68+CD11c-','CD11c+CD68-','CD68+CD11c+');
    xlim([0.5 17.5]);
    set(gca,'xtick',1:17);

%% Generate PD-L1 profiling ==> FigS7F

tablePDL1_3 = zeros(length(slideName),3);  %%  table counts for PDL1+ & panCK+, CD68+, CD11c+ in each samples

for s = 1:length(slideName)
    data1 = eval(strcat('data',slideName{s}));
    %data2 = data1(data1.PD_L1p,:);
    
    tablePDL1_3(s,1) = sum(data1.PD_L1p & data1.CD68p & ~data1.CD11cp) / sum(data1.CD68p & ~data1.CD11cp);
    tablePDL1_3(s,2) = sum(data1.PD_L1p & ~data1.CD68p & data1.CD11cp) / sum(~data1.CD68p & data1.CD11cp);
    tablePDL1_3(s,3) = sum(data1.PD_L1p & data1.CD68p & data1.CD11cp) / sum(data1.CD68p & data1.CD11cp);
    %tablePDL1_3(s,4) = sum(data1.PD_L1p & ~data1.CD68p & ~data1.CD11cp) / sum(~data1.CD68p & ~data1.CD11cp);
    
end

temp1 = repmat([1,2,3],length(slideName),1);

figure,myboxplot3(tablePDL1_3(:)*100,temp1(:));
ytickformat('percentage');
set(gca,'xticklabels',{'CD68+CD11c-','CD68-CD11c+','CD68+CD11c+'});
title('PD-L1 positivity in Myeloid subset');
