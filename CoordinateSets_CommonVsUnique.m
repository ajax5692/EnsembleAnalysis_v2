function unique_only_in_array2 = CoordinateSets_CommonVsUnique(poolSVDcoords,allROIMatrix)

%%To find same set of coordinates present
array1 = poolSVDcoords';
array2 = allROIMatrix;

% Check for identical sets of coordinates
common_indices = ismember(array1', array2', 'rows');

% Extract common coordinates
common_coordinates = array1(:, common_indices);

%%
%To find unique set of coordinates

% Combine x and y coordinates into a single matrix for each array
combined_coordinates_array1 = array1';
combined_coordinates_array2 = array2';

% Find unique rows in the first array
unique_coordinates_array1 = unique(combined_coordinates_array1, 'rows');

% Find unique rows in the second array
unique_coordinates_array2 = unique(combined_coordinates_array2, 'rows');

% Find the unique coordinates present only in the first array
unique_only_in_array1 = setdiff(unique_coordinates_array1, unique_coordinates_array2, 'rows');
unique_only_in_array2 = setdiff(unique_coordinates_array2, unique_coordinates_array1, 'rows');

% Transpose back to original format
unique_only_in_array1 = unique_only_in_array1';
unique_only_in_array2 = unique_only_in_array2';