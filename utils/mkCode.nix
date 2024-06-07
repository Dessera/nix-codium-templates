{
  pkgs,
  vscode ? pkgs.vscodium,
  settingsPath ? ./assets/blank.json,
  vscodeExtensions ? [],
}:
let
  codeInstance = pkgs.vscode-with-extensions.override {
    inherit vscode vscodeExtensions;
  };
in
pkgs.writeShellScriptBin "code-run"
''
  if [ ! -d $PWD/.vscode/.user-data/User ]; then
    mkdir -p $PWD/.vscode/.user-data/User
  fi
  if [ ! -f $PWD/.vscode/.user-data/User/settings.json ]; then
    ln -s ${settingsPath} $PWD/.vscode/.user-data/User/settings.json
  fi
  # run code with the user data directory set to $PWD/.vscode/.user-data
  ${codeInstance}/bin/codium --user-data-dir=$PWD/.vscode/.user-data $PWD $@
''