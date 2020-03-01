CACHE_DIR:=~/.cache
FZF_DIR:=$(CACHE_DIR)/.fzf


fzf-init: 
	git clone --depth 1 https://github.com/junegunn/fzf.git $(FZF_DIR)
	$(FZF_DIR)/install --no-zsh --no-fish --key-bindings --completion --no-update-rc
