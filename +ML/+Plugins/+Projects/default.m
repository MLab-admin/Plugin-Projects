function out = default(varargin)
%ML.Plugins.Projects.default Default configuration for the 'Projects' plugin.
%   out = ML.Plugins.Projects.default sets the Projects configuration file
%   in its default state.
%
%   Note: This function is designed for internal MLab use, a regular user
%   should not have to call it. If you have questions about this program,
%   please ask a MLab developper.
%
%   See also ML.projects, ML.config.

% === Inputs ==============================================================

in = ML.Input;
in.cfile('MLab.Projects') = @ischar;
in.quiet(true) = @islogical;
in = +in;

% -------------------------------------------------------------------------

fname = [prefdir filesep in.cfile '.mat'];

% =========================================================================

% --- Create default configuration structure
config = struct();

config.version = 1;

config.shortcut = struct();
config.shortcut.projects = struct('value', false, ...
    'desc', 'Projects', ...
    'code', ML.Config.failsafe_shortcut('ML.projects;'), ...
    'icon', 'Plugins/Projects/Images/Shortcuts/Projects.png');

% --- Save configuration structure
save(fname, 'config');

% --- Message display
if ~in.quiet
    printf('The configuration file ''%s'' has been reset to default.', in.cfile);
end

% --- Output
if nargout
    out = config;
end

end
