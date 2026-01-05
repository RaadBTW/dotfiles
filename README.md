# First install the stow

`sudo dnf install stow`

## Nvim

Install npm for some Mason Packages :

```bash
sudo pacman -Syu npm
```

```bash
sudo npm install -g markdownlint-cli2
sudo npm install -g htmlhint
```

```html
https://github.com/fatih/gomodifytags
```

## tmux

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

## ghostty

## mpv

Just some basic configuration to not show me blackscreen

## Docker

```bash
sudo usermod -aG docker $USER
```

## HDDs

```bash
UUID= /mnt/4TB ntfs-3g defaults,nofail,uid=1000,gid=1000 0 0
UUID= /mnt/2TB ntfs-3g defaults,nofail,uid=1000,gid=1000 0 0
UUID= /mnt/1TB ntfs-3g defaults,nofail,uid=1000,gid=1000 0 0
```
