{ pkgs, codium-extensions }:

let
  utils = import ../../utils;
in
utils.mkCode {
  inherit pkgs;
  settingsPath = ./settings.json;
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
}
