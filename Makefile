#########################
# Repo Related Command  #
#########################
.PHONY: all

all:
	xmake --root

run:
	# xmake --root run learn $(wordlist 2,99,$(MAKECMDGOALS))
	xmake run learn $(wordlist 2,99,$(MAKECMDGOALS))
vim:
	nix run nixpkgs#lunarvim .
vim0:
	nix run github:jordanisaacs/neovim-flake --no-write-lock-file .
vim1:
	nix run "github:nix-community/kickstart-nix.nvim"
vim2:
	nix run github:gvolpe/neovim-flake .
vim3:
	nix run codeberg:samuelsung/neovim-flake#nvim .

dev: 
	nix develop .

###################
# Nix Instruction #
###################
.PHONY: install-nix uninstall-nix monitor

# Install Single-User Nix into your system
install-nix:
	@if ! command -v nix >/dev/null 2>&1; then \
		echo "Installing Nix...";\
		curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install;\
	else \
		echo "You have already installed Nix.";\
	fi
	@# ref:
	@# https://nixos.org/download.html
	@# https://www.reddit.com/r/NixOS/comments/wyw7pa/multi_user_vs_single_user_installation/
	@# sh <(curl -L https://nixos.org/nix/install) --no-daemon;\

# Uninstall Single-User Nix 
uninstall-nix:
	@echo "will removing nix single user installing in 5 seconds... <using Ctrl + C to stop it>";
	@sleep 1 && echo "will removing nix single user installing in 4 seconds... <using Ctrl + C to stop it>";
	@sleep 1 && echo "will removing nix single user installing in 3 seconds... <using Ctrl + C to stop it>";
	@sleep 1 && echo "will removing nix single user installing in 2 seconds... <using Ctrl + C to stop it>";
	@sleep 1 && echo "will removing nix single user installing in 1 seconds... <using Ctrl + C to stop it>";
	/nix/nix-installer uninstall
	@# ref:
	@# https://nixos.org/download.html#nix-install-linux
	@# https://github.com/NixOS/nix/pull/8334

monitor:
	inotifywait --event=create --event=modify --event=moved_to --exclude='/(dev|nix|proc|run|sys|tmp|var)/.*' --monitor --no-dereference --quiet --recursive /
	@# ref:
	@# https://github.com/NixOS/nix/pull/8334

#######################
# general instruction #
#######################
.PHONY: git-log

git-log:
	git log --graph --abbrev-commit --decorate --date=relative --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'

