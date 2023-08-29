function imputedData = RandomKNNImputeV5(csvdata)
    % backup of data to be imputed
    imputedData = csvdata;

    %remove the last column (labels).
    data = csvdata(:, 1:end-1);

    % identify missing values
    nan_val = isnan(data);

    % Check if there are rows with all the elements are NaNs, and delete them.
    idx_allNaN = all(nan_val,2);
    data(idx_allNaN,:) = [];
    imputedData(idx_allNaN,:) = [];
    nan_val(idx_allNaN,:) = [];

    % find rows and columns of missing vlaues
    [row, col] = find(nan_val);

% Find the k nearest neighbor by calculating Euclidean distance.
    for L = 1:length(row)
        % find NaN in column L
        nanInCol_i = nan_val(:,col(L));
        
        % select rows for which have no NaN in column(L)
        train_set = data(~nanInCol_i,:);
        
        % set the k value (rounded upward)
        num_ecdists = size(train_set,1);
        k = ceil(sqrt(num_ecdists));
    
        % select the data in the same row of missing value. 
        Impute_rowData = data(row(L),:);
        idx_nansInRow_m = nan_val(row(L),:);
        idx_nansInTrainSet = isnan(train_set);

        % find the index of present coordinates for computing distance
        idx_coord_NaNs = idx_nansInRow_m | idx_nansInTrainSet;
        idx_present_Coord = ~idx_coord_NaNs;

        % number of present coordinates
        num_coord = sum(idx_present_Coord,2);
        % weight will be used for computing Euclidian Distance
        w = (length(Impute_rowData)-1)./num_coord;

        % Compute Euclidian Distance
        dist_set = (Impute_rowData - train_set);
        idxNaNs = isnan(dist_set);
        dist_set(idxNaNs) = 0;
        euclDist_NoWeight = sum(dist_set.^2, 2);
        euclDist_Weighted = sqrt(w.*euclDist_NoWeight);

        % find the index of k nearest neighbors
        [~, indx] = sort(euclDist_Weighted);
        idx = indx(1:k);
        
%         idx = zeros(k,1);
%         for num = 1:k
%             [~,idx(num)] = min(euclDist_Weighted);
%             euclDist_Weighted(idx(num)) = inf;
%         end

        % Impute the missing value in row(L), col(L)
        colData = train_set(:, col(L));
        knndata = colData(idx);
        imputedData(row(L),col(L)) = knndata(randi(k));
    end
end