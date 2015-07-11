function shortcuts(mode)
%ML.Project.rm Remove project
%   P = ML.PROJECT.RM(PNAME) Removes the project PNAME from the project.
%   list.
%
%   See also ML.projects, ML.Project.new.
%
%   Reference page in Help browser: <a href="matlab:doc ML.Project.rm">doc ML.Project.rm</a>
%   <a href="matlab:doc ML">MLab documentation</a>

% --- Parameters ----------------------------------------------------------

tag = 'Projects';
scc = 'ML.Projects;';

% -------------------------------------------------------------------------

switch mode
    
    case 'disp'
        
        S = com.mathworks.mlwidgets.shortcuts.ShortcutUtils;
        
        % Add new category (of not existing)
        if ~ismember('MLab', cell(S.getShortcutCategories))
            S.addNewCategory('MLab');
        end
        
        % List installed shortcuts
        sl = arrayfun(@char, S.getShortcutsByCategory('MLab').toArray, ...
            'UniformOutput', false);
        
        if ismember(tag, sl), s = 'Yes';
        else s = 'No'; end
        
        fprintf('    <a href="matlab: ML.config(''%s'', ''%s'', ''toggle'');">%s</a>\t%s\n', ...
            'shortcuts', tag, s, tag);
        
    case 'toggle'
                
        S = com.mathworks.mlwidgets.shortcuts.ShortcutUtils;
            
        if ismember(tag, arrayfun(@char, S.getShortcutsByCategory('MLab').toArray, ...
                'UniformOutput', false))
            S.removeShortcut('MLab', tag);
        else
            
            % --- Get config
            config = ML.Config.get;
            
            S.addShortcutToBottom(tag, ...
                scc, [config.path 'Images' filesep 'Shortcuts/' tag '.png'], ...
                'MLab', 'true');
        end
        
end
