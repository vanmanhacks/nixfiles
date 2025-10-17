{ config, pkgs, ... }:

{
  programs.zed-editor = {
    package = pkgs.zed-editor-fhs;
    enable = true;
    extensions = [
      "nix"
      "HTML"
      "xy-zed"
      "Dockerfile"
      "PHP"
      "nu"
      "Assembly Language Server"
      "termux"
      "markdownlint"
      "autocorrect"
      "ty"
      "rust snippets"
      "typescript snippets"
      "HTML snippets"
      "colored zed icons theme"
    ];
  };
}
