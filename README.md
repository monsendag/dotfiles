# Dotfiles

MY OSX / UBUNTU / CYGWIN dotfiles.

A fork of Ben Almans dotfiles repo [cowboy/dotfiles](https://github.com/cowboy/dotfiles).


## What does the dotfiles command do?


1. Git is installed if necessary, via APT or Homebrew (which is installed if necessary).
2. This repo is cloned into the `~/.dotfiles` directory (or updated if it already exists).
2. Files in `init` are executed (in alphanumeric order).
3. Files in `copy` are copied into `~/`.
4. Files in `link` are linked into `~/`.

Note:

* The `backups` folder only gets created when necessary. Any files in `~/` that would have been overwritten by `copy` or `link` get backed up there.
* Files in `bin` are executable shell scripts. The folder is prepended to PATH).
* Files in `zshrc` gets sourced when starting a new zsh shell.
* Files in `bash` get sourced when starting a new bash shell.
* Files in `conf` just sit there. If a config file doesn't _need_ to go in `~/`, put it in there.
* Files in `caches` are cached files, only used by some scripts. This folder will only be created if necessary.

## Installation

Run this command in a UNIX shell.

```
bash -c "$(curl -fsSL https://raw.github.com/monsendag/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
```

### OS X
Notes:

* You may need to be an administrator.
* You may need to install XCode first.

### Ubuntu
Notes:

* If APT hasn't been updated/upgraded recently, it might be a minute before you see anything.
* You'll have to enter your password for sudo.

## The "init" step
These things will be installed, but _only_ if they aren't already.

### OS X
* Homebrew
  * git
  * tree
  * sl
  * lesspipe

### Ubuntu
* APT
  * git-core
  * build-essential
  * libssl-dev
  * tree
  * sl

## The ~/ "copy" step
Any file in the `copy` subdirectory will be copied into `~/`. Any file that _needs_ to be modified with personal information (like [.gitconfig](https://github.com/monsendag/dotfiles/blob/master/copy/.gitconfig) which contains an email address and private key) should be _copied_ into `~/`. Because the file you'll be editing is no longer in `~/.dotfiles`, it's less likely to be accidentally committed into your public dotfiles repo.

## The ~/ "link" step
Any file in the `link` subdirectory gets symbolically linked with `ln -s` into `~/`. Edit these, and you change the file in the repo. Don't link files containing sensitive data, or you might accidentally commit that data!

## Aliases and Functions
To keep things easy, the `~/.bashrc` and `~/.bash_profile` files are extremely simple, and should never need to be modified. Instead, add your aliases, functions, settings, etc into one of the files in the `source` subdirectory, or add a new file. They're all automatically sourced when a new shell is opened. Take a look, I have [a lot of aliases and functions](https://github.com/monsendag/dotfiles/tree/master/source). I even have a [fancy prompt](https://github.com/monsendag/dotfiles/blob/master/source/50_prompt.sh) that shows the current directory, time and current git/svn repo status.

## Scripts
In addition to the aforementioned [dotfiles][dotfiles] script, there are a few other [bash scripts][bin].

* [dotfiles][dotfiles] - (re)initialize dotfiles. On Ubuntu, it might ask for your password (sudo).
* [src](https://github.com/monsendag/dotfiles/blob/master/link/.bashrc#L6-15) - (re)source all files in `source` directory
* Look through the [bin][bin] subdirectory for a few more.

Git repos display as **[branch:flags]** where flags are:

**?** untracked files  
**!** changed (but unstaged) files  
**+** staged files

SVN repos display as **[rev1:rev2]** where rev1 and rev2 are:

**rev1** last changed revision  
**rev2** revision

## Inspiration
<https://github.com/gf3/dotfiles>  
<https://github.com/mathiasbynens/dotfiles>

## License
Copyright (c) 2011 "Cowboy" Ben Alman  
Licensed under the MIT license.  
<http://benalman.com/about/license/>
