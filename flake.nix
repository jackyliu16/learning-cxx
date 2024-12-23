# Ref on https://github.com/nixvital/nix-based-cpp-starterkit/blob/main/flake.nix
{
  description = "A template for Nix based C++ project setup.";

  inputs = {
    # Pointing to the current stable release of nixpkgs. You can
    # customize this to point to an older version or unstable if you
    # like everything shining.
    #
    # E.g.
    #
    # nixpkgs.url = "github:NixOS/nixpkgs/unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, ... }@inputs: inputs.utils.lib.eachSystem [
    # Add the system/architecture you would like to support here. Note that not
    # all packages in the official nixpkgs support all platforms.
    "x86_64-linux" "i686-linux" "aarch64-linux" "x86_64-darwin"
  ] (system: let
    pkgs = import nixpkgs {
      inherit system;

      # Add overlays here if you need to override the nixpkgs
      # official packages.
      overlays = [];
      
      # Uncomment this if you need unfree software (e.g. cuda) for
      # your project.
      #
      # config.allowUnfree = true;
    };
  in {
    devShells.default = pkgs.mkShellNoCC rec {
      # Update the name to something that suites your project.
      name = "learning-cpp";

      packages = with pkgs; [
        # Development Tools
        nh
				zellij
				ripgrep

        # Development time dependencies
        # gtest

        # Build time and Run time dependencies
				gcc13
				gdb
				cmake
        xmake
				gnumake
				libclang
      ];

      # Setting up the environment variables you need during
      # development.
      shellHook = let
        icon = "f121";
      in ''
				alias ga="git add"
				alias gc="git commit"
				alias gca="git commit --amend"
				alias gcm="git commit -m"
				alias gp="git push"
				alias gst="git status"
				alias grhh="git reset --hard"
				alias zj="zellij"

        			export PS1="$(echo -e '\u${icon}') {\[$(tput sgr0)\]\[\033[38;5;228m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]} (${name}) \\$ \[$(tput sgr0)\]"
				export XMAKE_ROOT=y
				
				# Unset environment variables, required for xmake to find
				# the linker/compiler that we provide here
				unset CC
				unset CXX
				unset LD
				unset AR
				unset AS
				unset RANLIB
				unset STRIP
				unset CFLAGS
				unset CXXFLAGS
				unset LDFLAGS
				echo "C++ development environment loaded"
      '';
    };
  });
}
