%load matlab-TNP_P2reg-20200802.mat

manual_prior = 1/6*ones(1,6); %[1/4, 1/12, 1/12, 1/12, 1/4, 1/4]; %equal priors on the 4 Keratin+ categories
logdnacut = 8; %manual gate on Hoechst
tum_mark_44 = 'Keratin'; tum_mark_45 = 'Cy3_3'; tum_mark_46 = 'FITC_4'; tum_mark_47 = 'FITC_9';

totalcycle = [10,14,14,14];
lastcycle = [10,11,12,14]; %last cycle to consider; additional cycles lose too many cells
tum_marks = {tum_mark_44,tum_mark_45,tum_mark_46,tum_mark_47}; %best tumor marker in panel
pathology_KNNclassifiers = cell(4,1); %the KNN-classifiers for each section
tumorids = cell(4,1);
nullids = cell(4,1);
labelscores = cell(4,1);
suffices = {'TNP044','MAL_45reg','MAL_46reg','MAL_47reg'};

man_mark_44 = [11 14 18:21 23 24 28 29 31 37 38]; %[11 13:20 21 23:30 31 33:40];
man_mark_45 = [16,18:25,30:39,44:53];
man_mark_46 = [18:20 23 30:31 33:34 36 46:48 54]; %[16:26,30:31,33:40,44:54];
man_mark_47 = [16:24,27:29,32:55];

man_markers = {man_mark_44,man_mark_45,man_mark_46,man_mark_47};


for i = 1:4
    data = eval(['data' suffices{i}]);
    nullids{i} = any(log(data{:,1:lastcycle(i)})<logdnacut,2);
    tempgmm = fitgmdist(log(data{:,tum_marks{i}}),2);
    [~,tumcomp] = max(tempgmm.mu);
    tumorids{i} = cluster(tempgmm,log(data{:,tum_marks{i}}))==tumcomp;
    markers = [totalcycle(i)+(1:lastcycle(i)),2*totalcycle(i)+(1:lastcycle(i)),3*totalcycle(i)+(1:lastcycle(i))];
    
    selectid = tumorids{i}&~nullids{i};
    
    tumordata = data(selectid,man_markers{i});
    tumorROI = data.ROI(selectid);
    
    splitid = rand(numel(tumorROI),1)<0.5; %splits labeled cells into training and valid
    labeled_id = tumorROI~=0;
    
    traindata = log(tumordata{labeled_id&splitid,:});
    trainlabels = tumorROI(labeled_id&splitid,:);
    
    validdata = log(tumordata{labeled_id&~splitid,:});
    validlabels{i} = tumorROI(labeled_id&~splitid,:);
    
    tic
    pathology_KNNclassifiers{i} = fitcknn(traindata,trainlabels,'NumNeighbors',40,'Prior',manual_prior);
    [~,validscores{i},~] = predict(pathology_KNNclassifiers{i},validdata); 
    [~,labelscores{i},~] = predict(pathology_KNNclassifiers{i},log(tumordata{:,:})); 
    toc
    
    classvec = labelscores{i}*[1 0 0 0 0 0 ;0 1 1 1 0 0 ; 0 0 0 0 1 0 ; 0 0 0 0 0 1]';
end


%%
i = 4; %choose which section's results to show
selectid = tumorids{i}&~nullids{i};
class_prob_id = 2; %choose which kNN-class' probability to display

entropy_vals = shannon_entropy(colorvec);

figure()
    scatter(data.Xt(~tumorids{i}),-data.Yt(~tumorids{i}),1,0.5*[1,1,1],'filled')
    hold on
    scatter(data.Xt(selectid),-data.Yt(selectid),1,colorvec(:,class_prob_id)','filled')
    colormap(parula)
    title(['kNN-postprob for class ' num2str(class_prob_id) ' of ' suffices{i}])

figure()
    scatter(data.Xt(selectid),-data.Yt(selectid),1,entropy_vals,'filled')
    colormap(bluewhitered)
    set(gca,'Color',[0.5 0.5 0.5])
    title(['kNN-classification entropy of ' suffices{i}])

function shan_entropy = shannon_entropy(probs)
    individual_terms = probs.*(log2(probs));
    nanterms = isnan(individual_terms);
    individual_terms(nanterms) = 0;
    shan_entropy = -sum(individual_terms,2);
end
