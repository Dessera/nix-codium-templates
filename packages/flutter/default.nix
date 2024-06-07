{ pkgs, codium-extensions }:
let
  cfg = ./settings.json;
  codium = pkgs.vscode-with-extensions.override {
    vscode = pkgs.vscodium;
    vscodeExtensions = (with codium-extensions.vscode-marketplace; [
      igorsbitnev.error-gutters
      # github.copilot-labs
      github.copilot
      eamodio.gitlens
      mhutchie.git-graph
    ]) ++ (with codium-extensions.open-vsx; [
      # common
      ms-ceintl.vscode-language-pack-zh-hans
      usernamehw.errorlens
      oderwat.indent-rainbow
      zhuangtongfa.material-theme
      vscode-icons-team.vscode-icons
      # flutter
      dart-code.flutter
      dart-code.dart-code
    ]);
  };
in
pkgs.writeShellScriptBin "codium-run"
  ''
    mkdir -p $PWD/.code-user/User/
    cp ${cfg} $PWD/.code-user/User/settings.json
    ${codium}/bin/codium --user-data-dir=$PWD/.code-user $PWD $@
  ''
