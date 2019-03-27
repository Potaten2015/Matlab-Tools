%% Music Time
% Determine total duration of music in a folder and combine all songs in a
% folder into one song file.

% Clear all variables
clear all
% Close all Matlab figures
close all
% Clear command window
clc

% Enter folder containing music
cd music

% Set iteration variable containing total music time to zero
musicTime = 0;

% Create variable containing the directory where music files are stored
musicFiles = dir;

% Create empty cell array that will contain the names of each music file
musicFilesEdit = {};

% Loop through directory variable and add all mp3 file names to edit
% variable
for i = 1:length(musicFiles)
    if contains(musicFiles(i).name,'.mp3')
        musicFilesEdit(end+1) = cellstr(musicFiles(i).name);
    end
end

% Determine total duration of music in music folder
for j = 1:length(musicFilesEdit)
    songInfo = audioinfo(musicFilesEdit{j});
    musicTime = musicTime + songInfo.Duration;
end

% Display duration
musicTime = musicTime/60

% Create empty array that will contain all of the data for the combined
% song
allMusic = [];

% Combine individual song data into one array
for j = 1:length(musicFilesEdit)
    music = audioread(musicFilesEdit{j});
    allMusic = cat(1,allMusic,music);
end

% Write combined song data into a single MP4 audio file in music folder
audiowrite('AllSongs.MP4',allMusic,48000)

% Return to directory containing music folder
cd ..
    