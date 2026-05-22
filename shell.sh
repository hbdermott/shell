#!/bin/sh
set -euo pipefail

# ── OS / package manager detection ──────────────────────────
detect_pm() {
	if command -v apt-get >/dev/null 2>&1; then
		PM="apt"
		PM_INSTALL="sudo apt-get install -y"
		PM_UPDATE="sudo apt-get update"
		PKGS="zsh git curl wget fzf ripgrep bat micro pipx eza fd-find"
	elif command -v dnf >/dev/null 2>&1; then
		PM="dnf"
		PM_INSTALL="sudo dnf install -y"
		PM_UPDATE="sudo dnf check-update || true"
		PKGS="zsh git curl wget fzf ripgrep bat micro pipx eza fd-find"
	elif command -v pacman >/dev/null 2>&1; then
		PM="pacman"
		PM_INSTALL="sudo pacman -S --noconfirm"
		PM_UPDATE="sudo pacman -Sy"
		PKGS="zsh git curl wget fzf ripgrep bat micro python-pipx eza fd"
	elif command -v brew >/dev/null 2>&1; then
		PM="brew"
		PM_INSTALL="brew install"
		PM_UPDATE="brew update"
		PKGS="zsh git curl wget fzf ripgrep bat micro pipx eza fd"
	else
		printf "No supported package manager found.\n" >&2
		exit 1
	fi
	printf "Detected package manager: %s\n" "$PM"
}

detect_pm

# ── System packages ─────────────────────────────────────────
printf "Updating package lists...\n"
$PM_UPDATE
printf "Installing packages: %s\n" "$PKGS"
$PM_INSTALL $PKGS

# ── Lazygit ─────────────────────────────────────────────────
if ! command -v lazygit >/dev/null 2>&1; then
	printf "Installing lazygit...\n"
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" |
		grep '"tag_name":' | sed -E 's/.*"v*([^"]+)".*/\1/')
	ARCH=$(uname -m)
	case "$ARCH" in
		x86_64) ARCH_GO="x86_64" ;;
		aarch64 | arm64) ARCH_GO="arm64" ;;
		*) printf "Unsupported architecture: %s\n" "$ARCH" >&2; exit 1 ;;
	esac
	curl -fLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_${ARCH_GO}.tar.gz"
	sudo tar xf lazygit.tar.gz -C /usr/local/bin lazygit
	rm -f lazygit.tar.gz
	printf "Installed lazygit %s\n" "$LAZYGIT_VERSION"
else
	printf "lazygit already installed\n"
fi

# ── oh-my-zsh ───────────────────────────────────────────────
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	printf "Installing oh-my-zsh...\n"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
	printf "oh-my-zsh already installed\n"
fi

# ── nvm (Node Version Manager) ──────────────────────────────
if [ ! -d "$HOME/.nvm" ]; then
	printf "Installing nvm...\n"
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
else
	printf "nvm already installed\n"
fi

# ── pipx packages ───────────────────────────────────────────
if command -v pipx >/dev/null 2>&1; then
	if ! command -v tldr >/dev/null 2>&1; then
		printf "Installing tldr via pipx...\n"
		pipx install tldr
	else
		printf "tldr already installed via pipx\n"
	fi
else
	printf "pipx not found, skipping pipx package installations\n" >&2
fi

# ── Skip compinit for zsh 5.3+ (speeds up first shell) ─────
echo "skip_global_compinit=1" > "$HOME/.zshenv"

# ── oh-my-zsh plugins & theme ───────────────────────────────
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

install_plugin() {
	local name="$1"
	local url="$2"
	local dir="$3"
	if [ ! -d "$dir" ]; then
		git clone --depth 1 "$url" "$dir"
		printf "Installed %s\n" "$name"
	else
		printf "%s already installed\n" "$name"
	fi
}

install_plugin "zsh-autocomplete" "https://github.com/marlonrichert/zsh-autocomplete.git" "$ZSH_CUSTOM/plugins/zsh-autocomplete"
install_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions" "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
install_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
install_plugin "fzf-tab" "https://github.com/Aloxaf/fzf-tab" "$ZSH_CUSTOM/plugins/fzf-tab"

if [ ! -f "$HOME/.z" ]; then
	wget -q https://raw.githubusercontent.com/rupa/z/master/z.sh -O "$HOME/.z"
	printf "Installed z.sh\n"
fi

THEME_DIR="$ZSH_CUSTOM/themes"
mkdir -p "$THEME_DIR"
if [ ! -f "$THEME_DIR/elessar.zsh-theme" ]; then
	curl -fsSL https://raw.githubusercontent.com/fjpalacios/elessar-theme/master/elessar.zsh-theme -o "$THEME_DIR/elessar.zsh-theme"
	printf "Installed elessar theme\n"
fi

# ── Deploy .zshrc ──────────────────────────────────────────
script_dir="$(CDPATH='' cd -- "$(dirname "$0")" && pwd)"
cp "$script_dir/.zshrc" "$HOME/.zshrc"
printf "Deployed .zshrc\n"
