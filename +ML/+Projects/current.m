function [P, T] = current()
%ML.Projects.current Get current project
%   P = ML.PROJECTS.CURRENT() returns a structure containing information on
%   the current project. P is a struct whose field names are the projects' names
%   and whose values are the projects' directories.
%
%   [P, T] = ML.PROJECTS.CURRENT() also returns the toolkits, same struct
%   format.
%
%   See also ML.Projects, ML.Projects.select.
%
%   Reference page in Help browser: <a href="matlab:doc ML.Project.get">doc ML.Project.get</a>
%   <a href="matlab:doc ML">MLab documentation</a>

[P, T] = ML.Projects.select();