% choose a datatable representing a tissue section
data = dataTNP097;
xypoints = data{:,{'Xt','Yt'}};
tic
adjmat = delaunaygraph(xypoints,50);
toc

% define the subset of cells (e.g. tumor) that you want to compute adjacency for 
boxoutid = data.Yt<10^4 & data.Xt<10^4;
tumor_id = data.Keratinp & data.ROI~=1 & ~boxoutid; %remove normal epithelial (ROI=1) and abnormal corner of tissue

% compute the connected components (i.e. Delaunay clusters) of the cell-type
[bins,binsizes] = conncomp(graph(adjmat(tumor_id,tumor_id)));


figure('units','normalized','outerposition',[0 0 1 1])
scatter(xypoints(~tumor_id,1),-xypoints(~tumor_id,2),0.5,[0.3 0.3 0.3],'filled')
hold on
scatter(xypoints(tumor_id,1),-xypoints(tumor_id,2),3,-log2(binsizes(bins)),'filled')
colormap(hsv)
caxis([-18 0])
set(gca,'Color','k')
colorbar(); title('Keratin+ cells colored by Log2-Cluster-size')
daspect([1 1 1])   

%%
function adjmat = delaunaygraph(xypoints,cutoff)
%compute adjacency matrix of points based on Delaunay triangulation

tri = delaunay(xypoints(:,1),xypoints(:,2));
trilist = tri(:);
trinext = reshape(tri(:,[2 3 1]),size(trilist));
tridist = sqrt(sum((xypoints(trilist,:) - xypoints(trinext,:)).^2,2));
g = digraph(trilist,trinext,tridist);
A = adjacency(g,'weighted');
A = (A + A')/2;
A(A>cutoff)=0;

adjmat = A;
end