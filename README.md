
## Installation

Run this command in a UNIX shell (works in OS X, Linux and Cygwin).

```
curl -fsSL df.dag.im | bash
```

## What does the dotfiles command do?

1. Git is installed if necessary, via APT, Homebrew or Cygwin.exe (APT or Homebrew is installed if necessary).
2. This repo is cloned into the `~/.dotfiles` directory (or updated if it already exists).
2. Files in `init` are executed (in alphanumeric order).
3. Files in `copy` are copied into `~/`.
4. Files in `link` are linked into `~/`.

Note:

* The `backups` folder only gets created when necessary. Any files in `~/` that would have been overwritten by `copy` or `link` get backed up there.
* Files in `bin` are executable shell scripts. The folder is prepended to PATH).
* Files in `zshrc` gets sourced when starting a new zsh shell.
* Files in `conf` just sit there. If a config file doesn't _need_ to go in `~/`, put it in there.
* Files in `caches` are cached files, only used by some scripts. This folder will only be created if necessary.

## The "init" step
These things will be installed, but _only_ if they aren't already.

### OS X
* Homebrew
  * git
  * git-extras
  * zsh
  * tree

### Ubuntu
* APT
  * git-core
  * zsh
  * tree
  
### Cygwin
* openssh
* subversion
* vim
* curl
* zsh

## The ~/ "copy" step
Any file in the `copy` subdirectory will be copied into `~/`. Any file that _needs_ to be modified with personal information (like [.gitconfig](https://github.com/monsendag/dotfiles/blob/master/copy/.gitconfig) which contains an email address and private key) should be _copied_ into `~/`. Because the file you'll be editing is no longer in `~/.dotfiles`, it's less likely to be accidentally committed into your public dotfiles repo.

## The ~/ "link" step
Any file in the `link` subdirectory gets symbolically linked with `ln -s` into `~/`. Edit these, and you change the file in the repo. Don't link files containing sensitive data, or you might accidentally commit that data!

## Inspiration
<https://github.com/gf3/dotfiles>  
<https://github.com/mathiasbynens/dotfiles>

## License
Copyright (c) 2011 "Cowboy" Ben Alman  
Licensed under the MIT license.  
<http://benalman.com/about/license/>
