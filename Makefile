DOTFILE_DIR:=$(shell pwd)

CACHE_DIR:=~/.cache
FZF_DIR:=$(CACHE_DIR)/.fzf

NODENV_DIR:=~/.nodenv
RBENV_DIR:=~/.rbenv

BASH_CONF_DIR:=./.bash_conf
BASH_ENV_PROFILE:=$(BASH_CONF_DIR)/env_profile.bash

CONF_DIR:=~/.config
NVIM_DIR:=$(CONF_DIR)/nvim

msg:
	@echo あ

nvim-init:
	mkdir -p $(CONF_DIR)
	ln -s $(DOTFILE_DIR)/nvim $(NVIM_DIR)
	ls -l $(NVIM_DIR)

fzf-init: 
	git clone --depth 1 https://github.com/junegunn/fzf.git $(FZF_DIR)
	$(FZF_DIR)/install --no-zsh --no-fish --key-bindings --completion --no-update-rc

nodenv-init: $(BASH_ENV_PROFILE)
	git clone https://github.com/nodenv/nodenv.git $(NODENV_DIR)
	cd $(NODENV_DIR) && src/configure && make -C src
	echo 'export PATH="$$HOME/.nodenv/bin:$$PATH"' >> $<
	echo 'eval "$$(nodenv init -)"' >> $<
	git clone https://github.com/nodenv/node-build.git "$$($(NODENV_DIR)/bin/nodenv root)"/plugins/node-build
	git clone https://github.com/nodenv/nodenv-aliases.git "$$($(NODENV_DIR)/bin/nodenv root)"/plugins/nodenv-aliases
	@echo "\n\n手でreloginする\n"

rbenv-init: $(BASH_ENV_PROFILE)
	git clone https://github.com/rbenv/rbenv.git $(RBENV_DIR)
	cd $(RBENV_DIR) && src/configure && make -C src
	echo 'export PATH="$$HOME/.rbenv/bin:$$PATH"' >> $<
	echo 'eval "$$(rbenv init -)"' >> $<
	git clone https://github.com/rbenv/ruby-build.git "$$($(RBENV_DIR)/bin/rbenv root)"/plugins/ruby-build
	@echo "\n\n手でreloginする\n"

$(BASH_ENV_PROFILE):
	touch $@

