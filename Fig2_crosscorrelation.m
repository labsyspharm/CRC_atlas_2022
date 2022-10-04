%give the xy-positions of cells as "xydata", and the variable of interest
%(e.g. marker intensity, or binary state of cell-type calls) as
%"marker_val"

function [cross_corrfunc, radius] = Fig2_crosscorrelation(xydata, marker_val_A, marker_val_B)
    kmax = 200;
    [cross_corrfunc,radius] = corr_knn(xydata,zscore(marker_val_A),zscore(marker_val_B),kmax); 

    figure()
    plot(sqrt(1:kmax),cross_corrfunc); hold on
    xlabel('Nearest Neighbor index');
    set(gca,'xtick',1:floor(sqrt(kmax))); set(gca,'xticklabel', [1:floor(sqrt(kmax))].^2);
    ylabel('Correlation')
    title('Cross-correlation function of two markers')
end


function [corrfunc,rad_approx] = corr_knn(xydata,magvalA,magvalB,k_val)    
  
    [idx,dist] = knnsearch(xydata,xydata,'k',k_val,'NSMethod','kdtree');
    rad_approx = mean(dist); %i.e. the k'th neighbor is on average this distance
    
    magdots = magvalA(idx).*magvalB;
    corrfunc = mean(magdots);
end

