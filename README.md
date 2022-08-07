# dotfiles

----

- `./setup.sh`
- vimで`:PlugInstall`
- `brew bundle`

## font

- https://github.com/yuru7/udev-gothic
  - 35 JPDOC
  - 35 NF


## memo

**brewでnormal vimがインストールされる場合**

- `brew edit vim`でconfigureに`--with-features=huge`を追加して`brew install --build-from-source vim`して`relogin`

## terminal用background image

`svn export https://github.com/LazoCoder/Pokemon-Terminal/trunk/pokemonterminal/Images`

## bash

```
brew install bash
which -a bash
vim /etc/shells # brewで入れたbashのパスを追加
chsh -s /usr/local/bin/bash
echo $SHEL
echo $BASH_VERSIO
```

## todo

設定周りmakeで自動化


