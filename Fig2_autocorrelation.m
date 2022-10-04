%give the xy-positions of cells as "xydata", and the variable of interest
%(e.g. marker intensity, or binary state of cell-type calls) as
%"marker_val"

function [corrfunc, radius, c_0, L] = Fig2_autocorrelation(xydata, marker_val)
    kmax = 300;
    [corrfunc,radius] = corr_knn(xydata,zscore(marker_val),zscore(marker_val),kmax);

    fit_start_rad = 5;
    fit_end_rad = 200;
    
    expfit = fit(radius(fit_start_rad:fit_end_rad)',corrfunc(fit_start_rad:fit_end_rad)'/corrfunc(1),'exp1');
    parms = coeffvalues(expfit);
    c_0 = parms(1);
    L = -1./parms(2);

    figure()
    plot(radius,corrfunc); hold on
    fplot(@(r) c_0*exp(-r/L), [radius(5),radius(200)],'--')
    legend('Empirical', 'Exponential Fit')
    xlabel('Distance')
    ylabel('Correlation')
    title('Autocorrelation function of chosen marker')
end


function [corrfunc,rad_approx] = corr_knn(xydata,magvalA,magvalB,k_val)    
  
    [idx,dist] = knnsearch(xydata,xydata,'k',k_val,'NSMethod','kdtree');
    rad_approx = mean(dist); %i.e. the k'th neighbor is on average this distance
    
    magdots = magvalA(idx).*magvalB;
    corrfunc = mean(magdots);
end

