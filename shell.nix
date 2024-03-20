{ pkgs, ... }: pkgs.mkShell { buildInputs = with pkgs; [ nixfmt ripgrep ]; }
