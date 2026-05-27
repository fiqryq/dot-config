{ config, pkgs, lib, ... }:

# userName and userEmail are intentionally NOT set here.
# Each profile sets them in its own file so they can differ (personal vs work).

{
  programs.git = {
    enable = true;

    extraConfig = {
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      commit.gpgsign  = true;
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFKHEUhLQnNgl+5SohSk1dYZ/vsZO7XPW4RhfawGINr4";

      core = {
        editor   = "nvim";
        autocrlf = "input";
      };

      pull.rebase         = false;
      push.autoSetupRemote = true;
      init.defaultBranch  = "main";
    };

    aliases = {
      glog = "log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit";
    };
  };
}
