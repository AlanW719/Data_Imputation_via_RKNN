function imputedData = RandomKNNImputeV4(csvdata)
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
    
    % find trainset
    NoNaNsInCols_Idx = ~any(nan_val);
    if sum(NoNaNsInCols_Idx)==0
        t_set = ones(size(data,1),1);
    else
        t_set = data(:,NoNaNsInCols_Idx);
    end
    
% Find the k nearest neighbor by calculating Euclidean distance.
    for L = 1:length(row)
        % find NaN in column L
        nanInCol_i = nan_val(:,col(L));
        
        % select rows for which have no NaN in column(L)
        train_set=t_set(~nanInCol_i,:);

        % set the k value (rounded upward)
        num_ecdists = size(train_set,1);
        k = ceil(sqrt(num_ecdists));
    
        % select the data in the same row of missing value for distance computation. 
        Impute_rowData = t_set(row(L),:);
      
        % Compute Euclidian Distance
        [~, euIdx]=pdist2(train_set,Impute_rowData,'euclidean','Smallest',k);
  
        % the column of missing data point has other missing values will be removed
        IptColData=data(~nanInCol_i,col(L));
        knndata = IptColData(euIdx);
        imputedData(row(L),col(L)) = knndata(randi(k));
    end
end