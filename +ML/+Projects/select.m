function [cP, cT] = select(varargin)
%ML.Project.select Select a project
%   ML.PROJECT.SELECT(PNAME) Selects the project PNAME.
%
%   See also ML.projects.
%
%   Reference page in Help browser: <a href="matlab:doc ML.Project.select">doc ML.Project.select</a>
%   <a href="matlab:doc ML">MLab documentation</a>

% === Persistent variables ================================================

mlock
persistent MLab_current_project MLab_current_toolkits

if ~isstruct(MLab_current_project)
    MLab_current_project = struct('name', {}, 'path', {});
end

if ~isstruct(MLab_current_toolkits)
    MLab_current_toolkits = struct('name', {}, 'path', {});
end

% === Get behavior ========================================================

if isempty(varargin)
    cP = MLab_current_project;
    cT = MLab_current_toolkits;
    return
end

% === Inputs ==============================================================

in = ML.Input;
in.type = @(x) ischar(x) && ismember(lower(x), {'project', 'toolkit'});
in.name = @ischar;
in.select(true) = @islogical;
in = +in;

% -------------------------------------------------------------------------

switch lower(in.type)
    case 'project', ftype = 'Projects';
    case 'toolkit', ftype = 'Toolkits';
end

% =========================================================================

% --- Get projects structure
list = ML.Projects.list;

% --- Checks

if ~isfield(list.(ftype), in.name)
    warning([in.name ' is not a recognized ' lower(in.type) ' name. Aborting selection.']);
    return
end

switch lower(in.type)
    
    case 'project'
        
        % --- Unassign previous project
        if strcmp(ftype, 'Projects') && ~isempty(MLab_current_project) && ~isempty(MLab_current_project.name)
            rmpath(genpath(prog_path(MLab_current_project.name)));
        end
        
        % --- Assign current project
        if in.select
            
            % Go to the project folder and update path
            cd(list.(ftype).(in.name));
            addpath(genpath(prog_path(in.name)), '-end');
            
            % Define new current project
            MLab_current_project(1)= struct('name', in.name, 'path', list.(ftype).(in.name));
            
        else
            
            MLab_current_project = struct('name', '', 'path', '');
            
        end
        
    case 'toolkit'
        
        if in.select
            
            % Update path
            addpath(genpath(prog_path(in.name)), '-end');
            
            % Update current toolkits
            MLab_current_toolkits(end+1) = struct('name', in.name, 'path', list.(ftype).(in.name));
            
        else
                    
            % --- Get toolkit index
            for i = 1:numel(MLab_current_toolkits)
                if strcmp(MLab_current_toolkits(i).name, in.name)
                    break;
                end
            end
                        
            rmpath(genpath(prog_path(MLab_current_toolkits(i).name)));
            
            MLab_current_toolkits(i) = [];
            
        end
end

% --- Output
if nargout
    cP = MLab_current_project;
    cT = MLab_current_toolkits;
end

% ---------------------------------------------------------------------
    function p = prog_path(p_name)
        
        if exist([list.(ftype).(p_name) 'Programs/Matlab'], 'dir')
            p = [list.(ftype).(p_name) 'Programs/Matlab'];
        else
            p = [list.(ftype).(p_name) 'Programs'];
        end
        
    end
end