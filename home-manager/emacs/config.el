(require 'package)
			
(add-to-list 'package-archives
	'("MELPA" . "https://melpa.org/packages/"))

(package-initialize)

(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))

(use-package magit
	:ensure t)

(use-package doom-themes
	:if window-system
	:ensure t
	:config
	(doom-themes-org-config)
	(doom-themes-visual-bell-config))

(load-theme 'doom-nord t)

(when (member "JetBrains Mono" (font-family-list))
	(set-frame-font "JetBrains Mono-18" t t))

(setq font-lock-maximum-decoration t)

(setq use-dialog-box nil)
(setq use-file-dialog nil)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq ivy-use-selectable-prompt t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(fringe-mode -1)
(scroll-bar-mode -1)
(global-subword-mode 1)

(use-package all-the-icons
	:ensure t
	:if (display-graphic-p))

;; (when (version<= "26.0.50" emacs-version )
	;; (global-display-line-numbers-mode)
	;; (setq display-line-numbers-type 'relative))

(use-package doom-modeline
	:init
	:ensure t
	:config
	(doom-modeline-mode 1))

(setq doom-modeline-bar-height 5)
(setq doom-modeline-bar-width 1)
(setq doom-modeline-buffer-file-name-style 'truncate-upto-root)
(setq doom-modeline-icon nil)
;; (setq doom-modeline-major-mode-icon t)
;; (setq doom-modeline-major-mode-color-icon t)
;; (setq doom-modeline-minor-modes nil)
(setq display-time-mode t)
(setq doom-modeline-time-icon t)
(setq doom-modeline-time t)
(setq doom-doom-modeline-buffer-name t)
(setq doom-modeline-lsp t)
(setq doom-modeline-buffer-encoding t)
(display-time)

(use-package hl-line
	:ensure t
	:config
	(global-hl-line-mode))

(use-package hl-column
	:ensure t
	:config)

(add-hook 'org-mode-hook (lambda () (hl-column-mode 0)))
(add-hook 'dashboard-mode-hook (lambda () (hl-column-mode 0)))

(use-package page-break-lines
  :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-banner-logo-title "in vino veritas")
  ;; (setq dashboard-startup-banner "~/.config/emacs/images/emacs.png")
  (setq dashboard-page-separator "\n\f\n"))

(global-set-key (kbd "M-o") 'dashboard-open)

(set-face-attribute 'default nil :height 170)

;; (defun increase-emacs-size () 
;;	(set-face-attribte 'default nil :height (+ x 20)))

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(electric-pair-mode 1)

(use-package ivy
	:init
	(ivy-mode)
	:ensure t
	:config
	(setq ivy-use-virtual-buffers t)
	(setq enable-recursive-minibuffers t))

(use-package counsel
	:init
	:ensure t)

(setq warning-minimum-level :error)
(visual-line-mode t)
(global-visual-line-mode t)

(delete-selection-mode 1)
(setq tab-width 4)
(setq-default tab-width 4)

;; (defun my-insert-tab-char ()
;;  	(interactive)
;;  		(insert "\t"))

;; (global-set-key (kbd "C-q") 'my-insert-tab-char)

(setq evil-want-C-u-scroll t)

(use-package evil
	:init
	(evil-mode)
	:ensure t
	:config)

(evil-set-undo-system 'undo-redo)

(defun oh/insert-line-below ()
	(interactive)
	(save-excursion
	(end-of-line)
	(open-line 1)))
;
(defun oh/insert-line-above ()
	(interactive)
	(save-excursion
	(end-of-line 0)
	(open-line 1)))

(defun oh/insert-elisp-source-block ()
	(insert "#+begin_src emacs-lisp\n\n#+end_src"))

(global-set-key (kbd "C-;") 'comment-region)

(use-package general
	:ensure t
	:config
	(general-evil-setup)

	(general-create-definer oh/leader-keys
	:states '(normal insert visual emacs)
	:keymaps 'override
	:prefix "SPC" 
	:global-prefix "M-SPC")
	
  	(oh/leader-keys
    "." '(find-file :wk "Find File")
    "f c" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Config")
    "f r" '(counsel-recentf :wk "Find recent files")
	"f s" '(save-buffer :wk "Save file"))

  	(oh/leader-keys
    "b" '(:ignore t :wk "Buffer")
    "b b" '(switch-to-buffer :wk "Switch buffer")
    "b k" '(kill-this-buffer :wk "Kill this buffer")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer")
	"b o" '(evil-buffer-new :wk "New buffer"))
	
	(oh/leader-keys
	"b m" '(bookmark-set :wk "Set bookmark")
	"b M" '(bookmark-delete :wk "Delete bookmark")
	"RET" '(bookmark-jump :wk "Jump to bookmark"))

 	(oh/leader-keys
    "h" '(:ignore t :wk "Help")
    "h f" '(describe-function :wk "Describe function")
    "h v" '(describe-variable :wk "Describe variable")
    "h r r" '(reload-init-file :wk "Reload emacs config")
	"h t" '(load-theme :wk "Load doom theme"))

	(oh/leader-keys
    "t" '(:ignore t :wk "Line Manipulation")
    "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
    "t t" '(visual-line-mode :wk "Toggle truncated lines")
    "t r" '((lambda () (setq display-line-numbers 'relative)) :wk "Toggle line numbers"))

	(oh/leader-keys
	"l" '(:ignore t :wk "Elisp")
	"l e" '(pp-eval-last-sexp :wk "Eval last sexp"))

)

(use-package which-key
	:init
	:ensure t
	:config
	(which-key-mode))

(use-package org
    :init
    :ensure t
    :config
    (add-hook 'org-mode-hook 'org-indent-mode))

(use-package org-modern
    :after org
    :ensure t
    :config
    (add-hook 'org-mode-hook #'org-modern-mode))

(use-package org-roam
  :ensure t
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture))
  :custom
  (org-roam-capture-templates
	'(
	  ("g" "generic" plain
	  "#+TITLE:  %?"
	  :if-new (file "~/Git/notes/${slug}-%<%m-%d-%Y>.org")
	  :unnarowed t)
         ("j" "journal" plain 
	  (file "~/.dotfiles/home-manager/emacs/templates/journal.org")
	  :if-new (file "~/Git/notes/journal-%<%m-%d-%Y>.org")
	  :unnarowed t)
         )
  :config
  (setq org-roam-db-autosync-mode t)
  (require 'org-roam-protocol)))

(setq org-roam-directory "~/Git/notes") ;; errors when put inside use-package :custom module

;; (use-package org-roam-ui
    ;; :ensure t)

;; (add-hook 'org-mode-hook 
;; 	(lambda () (electric-indent-local-mode -1)))

;; (setq org-edit-src-content-indentation 0)

(use-package lsp-mode
 	:ensure t)

(use-package lsp-ui
 	:ensure t
 	:commands lsp-ui-mode
 	:hook
 	(lsp-mode . lsp-ui-mode))

(defun org-babel-edit-prep:c (babel-info)
  (setq-local buffer-file-name (->> babel-info caddr (alist-get :tangle)))
  (lsp))

(use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp))))

(use-package lsp-pyright
	:ensure t
	:hook (python-mode . (lambda () (require 'lsp-pyright) (lsp))))

(use-package company
 	:ensure t)

;; (use-package company-lsp
;; 	:ensure t
;; 	:commands company-lsp
;; 	:config
;; 	(push 'company-lsp company-backends))

(use-package flycheck
	:ensure t)

(use-package capf-autosuggest
	:ensure t)

;; Remove parenthesis when done
(use-package projectile
	:ensure t)
	;; :config
	;; (setq projectile-project-search-path '("~/Projects/" )))

;; (use-package sudo-edit
;; 	:config
;; 	(oh/leader-keys
;;   	"fu" '(sudo-edit-find-file :wk "Sudo find file")
;;   	"fU" '(sudo-edit :wk "Sudo edit file")))

(set-time-zone-rule "PHT-8")

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8-unix)

(setq bookmark-default-file "~/.emacs.d/bookmarks")

(use-package rainbow-mode
	:ensure t)

(rainbow-mode 1)

(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
