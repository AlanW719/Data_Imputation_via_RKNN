clc; clear; close all;
NRMS = zeros(44,14);
tEnd = zeros(44,14);

% Read Table_NRMS_Write.xlsx
filename = 'Table_NRMS_Write.xlsx';

% where the complete datasets are located
CpDatas = dir('Complete datasets\*.csv');

% sort file names in natural order
[CpDataName, Cp_oder]= sort_nat({CpDatas.name});

% find the incomplete datasets
IcpDataFolders = dir('Incomplete datasets');

% remove folder names only has dot char ('.', or '..')
IcpDataFolders = IcpDataFolders(~ismember({IcpDataFolders.name},...
    {'.', '..'}));

% sort incomplete datasets' folder names in natural order
[IcpDatafolderName, Icpfolder_oder]= sort_nat({IcpDataFolders.name});

% Load data_1, impute incomplete dataset_1, write runtime and NRMS for the 
% imputation of dataset. then load data_2, impute incomplete dataset_2,...
% unitl the last imcoplete dataset is done. 
CpData_length = length(CpDatas);
for i = 1:CpData_length
    % change files name from cell array to string
    CpName = string(CpDataName(i)); 
    
    % Concatenate the file name to the path
    CpData_path = strcat('Complete datasets\', CpName); 
    origiData = readmatrix(CpData_path);
    
    % change folder name from cell array to string
    IcpDatafolder_name = string(IcpDatafolderName(i));
    
    % Concatenate the file name and the path/direcotry name
    IcpDatasPath = strcat('Incomplete datasets\',IcpDatafolder_name,'\*.csv');
    IcpDatas = dir(IcpDatasPath);

    % sort file names in natural order
    [Icp_Data,Icp_DataOrder] = sort_nat({IcpDatas.name});
    
    % change files name from cell array to string
    IcpDataNames = string(Icp_Data);
    
    % number of incompete data files in the selected folder
    IcpDataFileNum = length(IcpDataNames); 
    
    % load imcomplete dataset from 1 to 44 one by one
    for j = 1:IcpDataFileNum     
        IcpData_Name = IcpDataNames(j);
        IcpData_Path = strcat('Incomplete datasets\',IcpDatafolder_name,...
            '\',IcpData_Name); 
        csvdata = readmatrix(IcpData_Path);
        
        % start timing
        tStart = tic;
        
        % start imputing
        ipt = RandomKNNImputeV5(csvdata);
        
        % Record runtime and store the data in jth row and ith column of tEnd
        tEnd(j,i) = toc(tStart);
        
        % Compute NRMS and store the data in jth row and ith column
        NRMS(j,i) = sum((ipt - origiData).^2)/(sum(origiData.^2));
    end    
end
%% write NRMS and Run Time values to the file 'Table_NRMS_Write.xlsx'
info_to_write = [NRMS(:) tEnd(:)];
writematrix(info_to_write, filename, 'Sheet', 1, 'Range', 'B2:C617'); 