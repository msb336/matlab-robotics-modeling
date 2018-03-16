function [fonts] = parsefonts(directory)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
files = dir(['data/' directory '/*.PNG']);
fonts = containers.Map;
for f = 1:numel(files)
    [~, name, ~] = fileparts(files(f).name);
    fonts(name) = img2xy([files(f).folder '/' files(f).name]);
end
end

