{ dotfiles, ... }: {
  imports = with dotfiles.modules; [ common rpi4 personal gnome virt ];
}
