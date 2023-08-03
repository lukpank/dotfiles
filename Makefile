all: 
	@echo "run: make clone build install"

clone: ~/.local/share/zap dwm st

build: build-dwm build-st build-lupan-clock

install: install-dwm install-st install-lupan-clock install-other

~/.local/share/zap:
	mkdir -p ~/.local/share
	cd ~/.local/share && \
		git clone https://github.com/zap-zsh/zap.git --branch=release-v1

dwm:
	git clone https://git.suckless.org/dwm 
	cp -i patches/dwm/config.h dwm/

build-dwm:
	make -C dwm

install-dwm:
	make -C dwm install PREFIX="${HOME}/.local"

st:
	git clone https://git.suckless.org/st
	cd st && \
		git remote add lupan.pl https://gitea.lupan.pl/lupan/st.git && \
		git fetch lupan.pl && \
		git checkout -b patched --track lupan.pl/patched

build-st:
	make -C st

install-st:
	make -C st install PREFIX="${HOME}/.local"

build-lupan-clock:
	make -C lupan-clock

install-lupan-clock:
	make -C lupan-clock install PREFIX="${HOME}/.local"

install-other:
	stow -Rv shell tmux xsession nvim
