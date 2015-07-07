function [list, fname] = list()
%ML.Project.get Get projects list
%   P = ML.PROJECT.GET() returns a structure containing information on all
%   the projects. P isa struct whose field names are the projects' names
%   and whose values are the projects' directories.
%
%   See also ML.projects.
%
%   Reference page in Help browser: <a href="matlab:doc ML.Project.get">doc ML.Project.get</a>
%   <a href="matlab:doc ML">MLab documentation</a>

% --- Projects file name
fname = [prefdir filesep 'MLab_Projects.mat'];

% --- Get config
if ~exist(fname, 'file')
    Projects = {};
    Toolkits = {};
    save(fname, 'Projects', 'Toolkits');
end

list = load(fname);

