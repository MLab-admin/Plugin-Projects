function remove(varargin)
%ML.Project.remove Remove project
%   P = ML.PROJECT.REMOVE(PNAME) Removes the project PNAME from the project.
%   list.
%
%   See also ML.projects, ML.Project.new.
%s
%   Reference page in Help browser: <a href="matlab:doc ML.Project.rm">doc ML.Project.rm</a>
%   <a href="matlab:doc ML">MLab documentation</a>

% === Inputs ==============================================================

in = ML.Input;
in.type = @(x) ischar(x) && ismember(lower(x), {'project', 'toolkit'});
in.name = @ischar;
in = +in;

% -------------------------------------------------------------------------

switch lower(in.type)
    case 'project', ftype = 'Projects';
    case 'toolkit', ftype = 'Toolkits';
end

% =========================================================================

% --- Get projects / toolkits
[list, fname] = ML.Projects.list;

% --- Check
if ~isfield(list.(ftype), in.name)
    warning(['MLAB:' ftype], ['''' in.name ''' is not an existing ' lower(in.type) '. Aborting.']);
    return
end

% --- Confirmation
fprintf('Are you sure you want to remove the %s ''%s''? [y/N]\n', lower(in.type), in.name);
if ~strcmpi(input('?> ', 's'), 'y')
    return
end

% --- Unselect project
ML.Projects.select(in.type, in.name, 'select', false);

% --- Remove project
list.(ftype) = rmfield(list.(ftype), in.name);

% --- Save projects
save(fname, '-struct', 'list');

fprintf('The %s ''%s'' has been removed.\n', lower(in.type), in.name);

