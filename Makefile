BACKUP_DIR := $(HOME)/dotfile_backup2

.PHONY: all
all: install

.PHONY: setup_brew
setup_brew:
	@installer/setup_brew.sh

.PHONY: install
install: setup_brew
	@if [ -z "$(NO_BACKUP)" ]; then \
		if [ -d $(BACKUP_DIR) ]; then \
			echo "エラー: バックアップディレクトリ $(BACKUP_DIR) が既に存在します。"; \
			echo "安全のため、インストールを中止します。"; \
			echo "既存のバックアップを確認し、必要に応じて削除してください。"; \
			exit 1; \
		fi; \
		mkdir -p $(BACKUP_DIR); \
		if [ -f ~/.zshrc ]; then \
			mv ~/.zshrc $(BACKUP_DIR)/.zshrc.backup; \
			echo "~/.zshrcのバックアップを作成しました: $(BACKUP_DIR)/.zshrc.backup"; \
		fi; \
	else \
		echo "バックアップは無効化されています。"; \
	fi
	@ln -sf $(CURDIR)/.zshrc ~/.zshrc
	@echo "シンボリックリンクを作成しました: ~/.zshrc -> $(CURDIR)/.zshrc"
	@ln -sf $(CURDIR)/.zsh ~/.zsh
	@echo "シンボリックリンクを作成しました: ~/.zsh -> $(CURDIR)/.zsh"

.PHONY: clean
clean:
	@if [ -L ~/.zshrc ]; then \
		rm ~/.zshrc; \
		echo "シンボリックリンクを削除しました: ~/.zshrc"; \
	fi
	@if [ -L ~/.zsh ]; then \
		rm ~/.zsh; \
		echo "シンボリックリンクを削除しました: ~/.zsh"; \
	fi
	@if [ -f $(BACKUP_DIR)/.zshrc.backup ]; then \
		mv $(BACKUP_DIR)/.zshrc.backup ~/.zshrc; \
		echo "バックアップから~/.zshrcを復元しました"; \
		rm -rf $(BACKUP_DIR); \
		echo "バックアップディレクトリを削除しました: $(BACKUP_DIR)"; \
	fi
