REPO_URL = https://github.com/herschel21/dotfiles/archive/refs/heads/main.zip
DOWNLOAD_DIR = temp_files/
DEST_DIR = $(HOME)/.config/
ZIP_FILE = $(DOWNLOAD_DIR).zip
FONT_DIR = $(HOME)/.local/share/fonts/
FONT_ZIP = MartianMono.zip

all: install-fonts download unzip copy clean

install-fonts:
	@echo "Installing MartianMono fonts..."
	mkdir -p $(FONT_DIR)
	curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/$(FONT_ZIP) -o $(FONT_ZIP)
	unzip $(FONT_ZIP) -d $(FONT_DIR)
	fc-cache -f -v $(FONT_DIR)

download:
	@echo "Downloading dotfile..."
	mkdir -p $(DOWNLOAD_DIR)
	curl -L $(REPO_URL) -o $(ZIP_FILE)

unzip:
	@echo "Unzipping the dotfile..."
	unzip $(ZIP_FILE) -d $(DOWNLOAD_DIR)

copy:
	@echo "Copying..."
	cp -r $(DOWNLOAD_DIR)/*/* $(DEST_DIR)

clean:
	@echo "Cleaning up..."
	rm -rf $(DOWNLOAD_DIR) $(ZIP_FILE) $(FONT_ZIP)

.PHONY: all install-fonts download copy clean

