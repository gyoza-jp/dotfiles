# dotfiles

macOS用のシェル設定ファイル管理リポジトリ

## 前提条件

- macOS
- Zsh（macOS Catalina以降はデフォルト）
- Homebrew（オプション）

## セットアップ

### 1. リポジトリのクローン

```bash
git clone <repository-url> ~/.dotfiles
cd ~/.dotfiles
```

### 2. シンボリックリンクの作成

```bash
./dotfilesLink.sh
```

既存の設定ファイルは自動的に `~/.dotfiles_backup` にバックアップされます。

### 3. sheldonのインストール（初回のみ）

```bash
brew install sheldon
```

### 4. シェルの再起動

```bash
exec zsh
```

プラグインは初回起動時に自動的にインストールされます。

## 含まれるファイル

- `.zshrc` - Zshのメイン設定（エイリアス、プロンプト、sheldonプラグイン、pyenv、Amazon Q）
- `.zprofile` - ログイン時に実行される設定（Homebrew、Amazon Q）
- `.zshenv` - 環境変数の設定（XDG_CONFIG_HOME）
- `.config/sheldon/plugins.toml` - sheldonプラグイン設定

## アンインストール

```bash
rm ~/.zshrc ~/.zprofile ~/.zshenv
# バックアップから復元する場合
cp ~/.dotfiles_backup/.zshrc ~/.zshrc
cp ~/.dotfiles_backup/.zprofile ~/.zprofile
cp ~/.dotfiles_backup/.zshenv ~/.zshenv
```
