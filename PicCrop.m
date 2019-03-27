%% Picture Cropper
% Allows one picture to be cropped multiple times, and each individual crop
% to be saved as separate image files in a specified folder. Useful for
% cropping a scan containing multiple photos. 

% Clear command window
clc

% Variable used for numbering cropped photos
picture = 0;

% For multiple folders of images. Creates a variable containing the folders
% in the current directory
mainFolder = dir;

% Creates folder containing only the names of the folders in the current
% directory, and removes other fields
mainFolder = extractfield(mainFolder,'name');

% Create empty cell array that will contain only the names of the intended
% image folders
mainFolderEdit = {};

% Loop through the directory variable and add all folder names that have a 
% specific character pattern to the edit variable. In this case:'3-24-2019'
for i = 1:length(mainFolder)
    if contains(mainFolder{i},'3-24-2019')
        mainFolderEdit(end+1) = mainFolder(i);
    end
end

% Loop for cropping and saving new image files
for j = 1:length(mainFolderEdit)
    
    % Change directory to first folder of images
    cd(mainFolderEdit{j})
    
    % Create variable with all files in image folder
    subFolder = dir;
    
    % Creates folder containing only the names of the files in the 
    % current directory, and removes other fields
    subFolder = extractfield(subFolder,'name');
    
    % Create empty cell array that will contain only the names of the 
    % intended image folders
    subFolderEdit = {};
    
    % Loop through the subdirectory variable and add all file names that 
    % have a specific character pattern to the edit variable. 
    % In this case: '.jpg'
    % If the file type of the images is different, change it in line 54
    for k = 1:length(subFolder)
        if contains(subFolder{k},'.jpg')
            subFolderEdit(end+1) = subFolder(k);
        end
    end

    % Loop for cropping images
    for m = 1:length(subFolderEdit)
        
        % Read the image into an image variable
        cropIm = imread(subFolderEdit{m});
        
        % View the image for 5 seconds to determine number of new files
        imshow(cropIm)
        pause(5)
        
        % Close image
        close
        
        % Ask user for number of cropped images to save
        images = input('# of images?: ');
        
        % Create variable that will contain new images
        newImages = {};
        
        % Crop image and save data to newImages variable
        for n = 1:images
            newImages{end+1} = imcrop(cropIm);
        end
        
        % Change directory to the original folder
        cd ..
        
        % Change directory to pre-existing folder where the new images will
        % be stored. Change to desired folder
        cd Cropped2
        
        % Write each cropped image to a new folder with desired prefix and
        % the number of the picture
        for n = 1:images
            picture = picture + 1;
            
            % Alter picture prefix and filetype here 
            imwrite(newImages{n},['gma' num2str(picture) '.jpg'])
        end
        
        % Return to original folder
        cd ..
        
        % Enter current picture folder
        cd(mainFolderEdit{j})
        
    end
    
    % Return to orignal folder
    cd ..
    
end

close all
clc