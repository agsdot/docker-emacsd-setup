### Example of build from jare/emacs Docker image

![emacs with spacemacs-theme](https://github.com/JAremko/docker-emacs-example/raw/master/img/emacs.png)

#### It adds:
 - firefox
 - [spacemacs-theme](https://github.com/nashamri/spacemacs-theme) (downloaded and installed with Dockerfile)
 - user

*See https://github.com/JAremko/docker-emacs for more details*

+++

To run:

1a) Have docker service running
1b) Git clone your .emacs.d directory in this directory (I'll setup git modules or put a make file in soon for this - make setup and make clean)
2) In the directory of this repo, docker build -t agsdotmacs .
3) docker run -it --rm  -v /:/rootfs -e LANG=en_US.utf8 -e TERM=xterm-256color "agsdotmacs:latest" emacs "/rootfs/$(pwd)"

Todo:
- Attribution to the JAremko projects I got some scripts and commands from also https://github.com/Silex/docker-emacs. Both github and docker hub locations.

- Cleanup the git commits

- Install some nice tools like prettierjs, ag, pt, ripgrep.

- shave it down to alpine linux

- try it with remacs

- learn how to reconnect to existing docker processes.
  - how else can I save recent files and other items in the .cache directory.

- put in a make file or gitmodules to automate gitting a git .emacs.d repo

- make the docker emacs an alias (or put it in a script)

- with said script, account for when there is no argument, or an argument for a file, two files, three files, a directory, a .
  - make sure that docker emacs binds to an existing instance
    - if not, create a new instance
  - do accordingly with arguments passed to emacs
    - none, open up emacs, load dashboard? if I still want that package loaded


Good pages:

- https://github.com/Silex/docker-emacs
  - https://hub.docker.com/r/silex/emacs/
  - https://github.com/Silex/docker-emacs/blob/master/Dockerfile
- https://stackoverflow.com/questions/30494050/how-do-i-pass-environment-variables-to-docker-containers
- https://github.com/moby/moby/issues/22801

- https://stackoverflow.com/questions/42349105/customize-docker-container-bash
- https://github.com/moby/moby/issues/8631 - dumb terminal when using docker exec #8631
- https://stackoverflow.com/questions/33493456/docker-bash-prompt-not-display-color

- https://github.com/fxdgear/alpine-neovim