FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/root
ENV LANG=en_US.UTF-8

# Install dependencies and Emacs
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    curl \
    emacs \
    emacs-source \
    git \
    gnutls-bin \
    gnupg \
    libgif-dev \
    libjpeg-dev \
    libm17n-dev \
    libotf-dev \
    libpng-dev \
    librsvg2-dev \
    libtiff-dev \
    libx11-dev \
    libxext-dev \
    libxfont-dev \
    libxpm-dev \
    libxrandr-dev \
    locales \
    wget \
    xdg-utils \
    && locale-gen en_US.UTF-8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Clone Spacemacs
RUN git clone https://github.com/syl20bnr/spacemacs ${HOME}/.emacs.d

# Create default Spacemacs configuration
RUN mkdir -p ${HOME}/.spacemacs.d && \
    cat > ${HOME}/.spacemacs.d/init.el << 'EOF'
(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-layer-packages nil))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-gc-cons '(100000000 0.1)
   dotspacemacs-read-process-output nil
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-enable-transient-state t
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers t
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-activate-smartparens-mode t
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-env ()
  )

(defun dotspacemacs/user-init ()
  )

(defun dotspacemacs/user-load ()
  )

(defun dotspacemacs/user-config ()
  )

(custom-set-variables)
(custom-set-faces)
EOF

# Set permissions
RUN chmod -R 755 ${HOME}/.emacs.d && \
    chmod -R 755 ${HOME}/.spacemacs.d

# Set working directory
WORKDIR ${HOME}

# Set the entry point to start Emacs
ENTRYPOINT ["emacs"]
CMD ["--no-window-system"]
