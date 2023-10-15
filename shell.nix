{ pkgs, ... }:
pkgs.mkShell { buildInputs = with pkgs; [ nixfmt deploy-rs.deploy-rs ]; }
