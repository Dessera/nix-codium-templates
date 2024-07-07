{ pkgs, codium-extensions }:

let
  utils = import ../../utils;
in
utils.mkCode {
  inherit pkgs;
  settingsPath = ./settings.json;
  isSettingMutable = true;
  vscodeExtensions = (with codium-extensions.vscode-marketplace; [
      igorsbitnev.error-gutters
      github.copilot
      eamodio.gitlens
      mhutchie.git-graph
      # python
      njpwerner.autodocstring
      ms-python.black-formatter
      tamasfe.even-better-toml
      ms-toolsai.vscode-jupyter-cell-tags
      ms-toolsai.jupyter-keymap
      ms-toolsai.jupyter-renderers
      ms-toolsai.vscode-jupyter-slideshow
      ms-python.vscode-pylance
      ms-python.python
      ms-python.debugpy
      donjayamanne.python-environment-manager
      kevinrose.vsc-python-indent
      zeshuaro.vscode-python-poetry
  ]) ++ (with codium-extensions.open-vsx; [
      # common
      ms-ceintl.vscode-language-pack-zh-hans
      usernamehw.errorlens
      oderwat.indent-rainbow
      zhuangtongfa.material-theme
      vscode-icons-team.vscode-icons
  ]);
}
