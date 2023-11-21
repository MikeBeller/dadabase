{ pkgs }: {
  deps = [
    pkgs.pstree
    pkgs.nodejs-16_x
    pkgs.elixir_1_14
    pkgs.elixir_ls
    pkgs.sqlite
    pkgs.inotify-tools
  ];
}