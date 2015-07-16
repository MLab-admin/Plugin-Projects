function out = projects(varargin)
%ML.projects MLab projects command line interface
%   ML.projects Starts the MLab projects command-line interface.
%
%   See also

% === Input variables =====================================================

in = ML.Input;
in.clc(true) = @islogical;
in.mode('default') = @ischar;
in = +in;

% =========================================================================

switch in.mode
    
    case 'default'
        
        if in.clc, clc; end
        
        C = {'<strong>Projects</strong> (<a href="matlab:ML.Projects.new(''project''); ML.projects;">new</a>)', ...
             '<strong>Toolkits</strong> (<a href="matlab:ML.Projects.new(''toolkit''); ML.projects;">new</a>)'};
        
        % --- List projects and toolkits
        P = ML.Projects.list;
        
        % --- Get current project and toolkits (if defined)
        [cP, cT] = ML.Projects.current;
        if isempty(cP), cP(1).name = ''; end
        if isempty(cT), cT(1).name = ''; end
                
        % --- Display project list
        if ~isempty(P.Projects)
            fp = fieldnames(P.Projects);
            for i = 1:numel(fp)
                if strcmp(cP.name, fp{i})
                    C{i+1,1} = sprintf(' %s %s [<a href="matlab:ML.Projects.select(''Project'', ''%s'', ''select'', false); ML.projects;">Unselect</a> | <a href="matlab:ML.Projects.remove(''Project'', ''%s''); ML.projects;">Remove</a>]', char(8594), fp{i}, fp{i}, fp{i});
                else
                    C{i+1,1} = sprintf('<a href="matlab:ML.Projects.select(''Project'', ''%s''); ML.projects;">%s</a>', fp{i}, fp{i});
                end
            end
        end
        
        % --- Display toolkits list
        if ~isempty(P.Toolkits)
            ft = fieldnames(P.Toolkits);
            for i = 1:numel(ft)
                if ismember(ft{i}, {cT.name})
                    C{i+1,2} = sprintf(' %s %s [<a href="matlab:ML.Projects.select(''Toolkit'', ''%s'', ''select'', false); ML.projects;">Unselect</a> | <a href="matlab:ML.Projects.remove(''Toolkit'', ''%s''); ML.projects;">Remove</a>]', char(8594), ft{i}, ft{i}, ft{i});
                else
                    C{i+1,2} = sprintf('<a href="matlab:ML.Projects.select(''Toolkit'', ''%s''); ML.projects;">%s</a>', ft{i}, ft{i});
                end
            end
        end
        
        % --- Display output
        ML.Text.table(C, 'style', 'compact');

    case 'force'
        
        if in.clc, clc; end
        
        while true
            
            % --- List projects
            P = ML.Project.get;
            fl = fieldnames(P);
            
            fprintf(' <strong>Projects</strong>\n\n');
            if isempty(fl)
                fprintf('No project is defined.\n');
            else
                for i = 1:numel(fl)
                    fprintf('  [%i] - %s\n', i, fl{i});
                end
            end
            fprintf('  [n] - New project\n');
            
            fprintf('\nPlease choose an option:\n');
            c = input('?> ', 's');
            
            switch c
                case 'n'
                    ML.Project.new;
                    
                otherwise
                    c = str2double(c);
                    if ~isnan(c) && isreal(c) && ismember(c, 1:numel(fl))
                        P = ML.Project.select(fl{c});
                        break;
                    end
            end
            
        end
end

% --- Output
if nargout
    out = P;
end