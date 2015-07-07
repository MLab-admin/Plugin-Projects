function new(varargin)
%ML.Project.new New project
%   P = ML.PROJECTS.NEW('Project') Creates a new project.
%
%   T = ML.PROJECTS.NEW('Toolkit') Creates a new toolkit.
%
%   See also ML.Projects.
%
%   Reference page in Help browser: <a href="matlab:doc ML.Project.new">doc ML.Project.new</a>
%   <a href="matlab:doc ML">MLab documentation</a>

% --- Inputs --------------------------------------------------------------

in = ML.Input;
in.type = @(x) ischar(x) && ismember(lower(x), {'project', 'toolkit'});
in = +in;

% -------------------------------------------------------------------------

% --- Get projects structure
[list, fname] = ML.Projects.list;

% --- Get project/toolkit name
while true
    fprintf('\nPlease enter the name of the new %s: [Enter to skip]\n', lower(in.type));
    pname = input('?> ', 's');
    
    if isempty(pname), return; end
        
    if ~isvarname(pname)
        fprintf('''%s'' cannot be taken as a %s name.\n', pname, lower(in.type));
        continue; 
    end
    
    if (strcmpi(in.type, 'project') && isfield(list.Projects, pname)) || ...
       (strcmpi(in.type, 'toolkit') && isfield(list.Toolkits, pname))
        fprintf('This %s name is already defined.\n', lower(in.type));
        continue
    end
    
    break;
end

% --- Get project folder
while true
    fprintf('\nPlease enter the path of the ''%s'' %s:\n', pname, lower(in.type));
    ppath = input('?> ', 's');
    
    if isempty(ppath) || ~exist(ppath, 'dir')
        fprintf('''%s'' is not a valid path.\n', ppath);
        continue; 
    end

    % Add filesep at the end
    if ~strcmp(ppath(end),filesep)
        ppath = [ppath filesep];
    end
    
    break;
end

% --- Save project/toolkit
switch lower(in.type)
    case 'project'
        list.Projects.(pname) = ppath;
    case 'toolkit'
        list.Toolkits.(pname) = ppath;
end

save(fname, '-struct', 'list');