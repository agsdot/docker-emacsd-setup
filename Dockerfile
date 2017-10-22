ARG VERSION=edge
FROM alpine:$VERSION

MAINTAINER JAremko <w3techplaygound@gmail.com>

# Fix "Couldn't register with accessibility bus" error message
ENV NO_AT_BRIDGE=1

COPY asEnvUser /usr/local/sbin/

RUN echo "http://nl.alpinelinux.org/alpine/edge/main" \
    >> /etc/apk/repositories \
    && echo "http://nl.alpinelinux.org/alpine/edge/testing" \
    >> /etc/apk/repositories \
    && echo "http://nl.alpinelinux.org/alpine/edge/community" \
    >> /etc/apk/repositories \
# basic stuff
    && apk --update add bash \
    build-base \
    dbus-x11 \
    fontconfig \
    git \
    gzip \
    mesa-gl \
    sudo \
    tar \
    neovim \
    #the_silver_searcher \
    go \
    unzip \
# su-exec
    && git clone https://github.com/ncopa/su-exec.git /tmp/su-exec \
    && cd /tmp/su-exec \
    && make \
    && chmod 770 su-exec \
    && mv ./su-exec /usr/local/sbin/ \

# Only for sudoers
    && chown root /usr/local/sbin/asEnvUser \
    && chmod 700  /usr/local/sbin/asEnvUser \
# Install fzf
    && mkdir -p /home/emacs \
    #&& mkdir -p /home/emacs/src \
    #&& mkdir -p /home/emacs/bin \
    #&& mkdir -p /home/emacs/pkg \
    #&& git clone https://github.com/ncopa/su-exec.git /tmp/su-exec \
    && git clone --depth 1 https://github.com/junegunn/fzf.git /tmp/.fzf \
    && /tmp/.fzf/install --all \
    && cp /root/.bashrc /home/emacs/.bashrc \
    && cp /root/.fzf.bash /home/emacs/.fzf.bash \
    && cp -r /tmp/.fzf /home/emacs/.fzf \
# Emacs
    && apk --update add emacs-nox \
# Cleanup
    && apk del build-base \
    && rm -rf /var/cache/* /tmp/* /var/log/* ~/.cache \
    && mkdir -p /var/cache/apk

ENV UNAME="emacser" \
    GNAME="emacs" \
    UHOME="/home/emacs" \
    UID="1000" \
    GID="1000" \
    WORKSPACE="/mnt/workspace" \
    SHELL="/bin/bash"

WORKDIR "${WORKSPACE}"

ENTRYPOINT ["asEnvUser"]
CMD ["bash", "-c", "emacs; /bin/bash", "nvim; /bin/bash"]
