%choose a marker and datatable to compute N/N_eff, as well as predict
%N/N_eff using the exponential correlation function 

marker = 'Keratinp';
data = dataTNP097;

xydata = data{:,{'Xt','Yt'}};
marker_val = data{:,marker}; %if marker is continuous, use apply log(x+1)

%%
tic
    [corrfunc,radius,c_0,L] = Fig2_autocorrelation(xydata,marker_val);
    parms = [c_0,-1/L];
    [rand_means,tma_means,N,N_eff] = tma_compare(data,marker,parms);
    Nred_obs = (std(tma_means)/std(rand_means))^2;
    Nred_pred = N/N_eff;
toc
text(mean(xlim),mean(ylim),{[marker ' N_{eff}/N = ' num2str(Nred_obs)]; ['Predicted N_{eff}/N = ' num2str(Nred_pred)]})


function [rand_means,tma_means,N,N_eff] = tma_compare(data,marker,expparms)
    trials = 10^3; %number of TMA cores to estimate N_eff empirically
    tma_means = zeros(trials,1);
    rand_means = zeros(trials,1);
    n_size = zeros(trials,1);
    eff_sample_size = zeros(trials,1);

    for i = 1:trials
        subset_id = tma_select(data);
        n_size(i) = sum(subset_id);
        rand_id = subset_id(randperm(size(subset_id,1)));
        tma_means(i) = mean(data{(subset_id),marker});
        rand_means(i) = mean(data{(rand_id),marker});

        distmat = squareform(pdist(data{subset_id,{'Xt','Yt'}}));
        corrmat = expparms(1)*exp(expparms(2)*distmat);
        corrmat(logical(eye(n_size(i)))) = 1;
        eff_sample_size(i) = n_size(i)^2/sum(corrmat(:));
    end
    N = mean(n_size);
    N_eff = mean(eff_sample_size);
end

function subset_id = tma_select(data)
    radius = 500; %vTMA radius
    center_id = randi(size(data,1));
    center_xy = data{center_id,{'Xt','Yt'}};
    subset_id = pdist2(data{:,{'Xt','Yt'}},center_xy)<radius;
end
   
