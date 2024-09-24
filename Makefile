REPO_URL = https://github.com/herschel21/dotfiles/archive/refs/heads/main.zip
DOWNLOAD_DIR = temp_files/
DEST_DIR = $(HOME)/.config/
ZIP_FILE = $(DOWNLOAD_DIR).zip

all: download unzip copy clean

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
	rm -rf $(DOWNLOAD_DIR) $(ZIP_FILE)

.PHONY: all download copy clean
