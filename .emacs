
(setq custom-file "~/work/emacs-config/.emacs.custom.el")
(when (file-exists-p custom-file)
  (load custom-file))


(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package dracula-theme
  :ensure t
  :config
  (load-theme 'dracula t))

(use-package company
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq company-idle-delay 0.1)
  (setq company-minimum-prefix-length 2)
  :bind ("M-/" . company-complete))

;; (use-package ido
;;   :init
;;   (ido-mode 1)
;;   (ido-everywhere 1)
;;   :config
;;   (setq ido-enable-flex-matching t)) ; this add "fuzzy" searching

;; 2. Ivy: The generic completion mechanism
(use-package ivy
  :diminish
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) "))

;; 3. Swiper: The search interface (replaces C-s)
(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)))

;; 4. Counsel: The "upgraded" Emacs commands
(use-package counsel
  :after ivy
  :config (counsel-mode 1)
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-h f" . counsel-describe-function)
         ("C-h v" . counsel-describe-variable)))

;; LSP
(use-package eglot
  :ensure t
  :hook ((typescript-ts-mode . eglot-ensure)
         (tsx-ts-mode . eglot-ensure)
         (js-ts-mode . eglot-ensure)))

;; Treesit
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; Magit
(use-package magit)

;; Projectile
(use-package projectile
  :diminish
  :init
  (projectile-mode +1)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :config
  ;; Use Ivy for Projectile's completion
  (setq projectile-completion-system 'ivy)
  ;; Automatically find projects in your dev folder
  (setq projectile-project-search-path '("~/projects" "~/work"))
  ;; Speed up indexing by using "fd" or "git" instead of native lisp
  (setq projectile-indexing-method 'alien))

;; Multiple colors for nested parentesis
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package add-node-modules-path
  :hook ((js-ts-mode typescript-ts-mode) . add-node-modules-path))

;; Run prettier  on save
(use-package apheleia
  :config
  (apheleia-global-mode +1))

;; Multiple cursors
(use-package multiple-cursors
  :ensure t
  :bind (("C-g" . mc/mark-next-like-this)
	 ("C-S-g" . mc/mark-all-like-this)
	 ("C-S-c" . mc/edit-lines)))

;; Install custom font
(add-to-list 'default-frame-alist `(font . "Iosevka-18"))

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(global-tab-line-mode)
(global-hl-line-mode 1)

(global-display-line-numbers-mode 1)
;; (global-hl-line-mode 1)


(setq inhibit-startup-screen t)
(setq initial-scratch-message ";; Follow the white rabbit...\n")
(setq inhibit-startup-echo-area-message "Max")
