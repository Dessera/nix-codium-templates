{
  pkgs,
  vscode ? pkgs.vscodium,
  settingsPath ? ./assets/blank.json,
  isSettingMutable ? false,
  vscodeExtensions ? [],
}:
let
  codeInstance = pkgs.vscode-with-extensions.override {
    inherit vscode vscodeExtensions;
  };
  settingsCommand = if isSettingMutable then 
    "cp ${settingsPath} $PWD/.vscode/.user-data/User/settings.json"
  else
    "ln -s ${settingsPath} $PWD/.vscode/.user-data/User/settings.json";
  executableName = if vscode == pkgs.vscodium then "codium" else "code";
in
pkgs.writeShellScriptBin "code-run"
''
  if [ ! -d $PWD/.vscode/.user-data/User ]; then
    mkdir -p $PWD/.vscode/.user-data/User
  fi
  if [ ! -f $PWD/.vscode/.user-data/User/settings.json ]; then
    ${settingsCommand}
  fi
  # run code with the user data directory set to $PWD/.vscode/.user-data
  ${codeInstance}/bin/${executableName} --user-data-dir=$PWD/.vscode/.user-data $PWD $@
''