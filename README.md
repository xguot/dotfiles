# dotfiles

> "I tried multiple times finding an editor that is more modern and does fancy
> things like colorize my source code..."
> — _Linus Torvalds_

Currently a work in progress, but the goal is subtraction, not addition. Time spent memorizing new keymaps is time better spent deep learning.

[![Target: uemacs](https://img.shields.io/badge/target-uemacs-blue?style=flat-square&logo=gnuemacs&logoColor=white)](https://github.com/torvalds/uemacs)

![Setup](assets/torvalds_setup.webp)

## Management

Managed entirely with [GNU Stow](https://www.gnu.org/software/stow/).

```bash
git clone [https://github.com/yourusername/dotfiles.git](https://github.com/yourusername/dotfiles.git) ~/dotfiles
cd ~/dotfiles
stow <package_name>
```
