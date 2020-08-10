function a = openreadme(varargin)
if ispc
    winopen('Readme.txt')
end
if ismac
    macopen('Readme.txt')
end
