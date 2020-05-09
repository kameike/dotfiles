.PHONY: list
list:
	@grep '^[^#^(PHONY:.*)[:space:]].*:' Makefile | sed 's/://g'

.PHONY: brew
brew: 
	@./scripts/brew.sh

.PHONY: install-basic-toolchain
install-basic-toolchain:
	@./scripts/install_basic_toolchain.sh


.PHONY: sync-dotfiles
sync-dotfiles:
	@./scripts/sync_dotfiles.sh
