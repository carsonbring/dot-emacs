;; -*- lexical-binding: t -*-

;; Add the melpa emacs repo, where most packages are
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; custom startup screen into sicp due to me doing my practice
(setq inhibit-startup-screen t)
(setq initial-buffer-choice "~/projects/sicp/chapter2")

;; Ensure package-list has been fetched
(when (not package-archive-contents)
  (package-refresh-contents))
  
;; We want to use use-package, not the default emacs behavior
(setq package-enable-at-startup nil)

;; Install use-package if it hasn't been installed
(when (not (package-installed-p 'use-package)) (package-install 'use-package))
(require 'use-package)

;; ido-mode provides a better file/buffer-selection interface
(use-package ido
             :ensure t
             :config (ido-mode t))
             
;; ido for M-x
(use-package smex
             :ensure t
             :config
             (progn
               (smex-initialize)
               (global-set-key (kbd "M-x") 'smex)
               (global-set-key (kbd "M-X") 'smex-major-mode-commands)
               ;; This is your old M-x.
               (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)))
               
;; Provides all the racket support
(use-package racket-mode
             :ensure t)

;; Syntax checking
(use-package flycheck
             :ensure t
             :config
             (global-flycheck-mode))

;; Autocomplete popups
(use-package company
             :ensure t
             :config
             (progn
               (setq company-idle-delay 0.2
                     ;; min prefix of 2 chars
                     company-minimum-prefix-length 2
                     company-selection-wrap-around t
                     company-show-numbers t
                     company-dabbrev-downcase nil
                     company-echo-delay 0
                     company-tooltip-limit 20
                     company-transformers '(company-sort-by-occurrence)
                     company-begin-commands '(self-insert-command)
                     )
               (global-company-mode))
             )
             
;; Lots of parenthesis and other delimiter niceties
(use-package paredit
             :ensure t
             :config
             (add-hook 'racket-mode-hook #'enable-paredit-mode))

;; Colorizes delimiters so they can be told apart
(use-package rainbow-delimiters
             :ensure t
             :config (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
;; Make buffer names unique
;; buffernames that are foo<1>, foo<2> are hard to read. This makes them foo|dir  foo|otherdir
(use-package uniquify
             :config (setq uniquify-buffer-name-style 'post-forward))

;; Highlight matching parenthesis
(show-paren-mode 1)
(setq show-paren-delay 0)

;; Allows moving through wrapped lines as they appear
(setq line-move-visual t) 
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(rainbow-delimiters paredit company flycheck racket-mode smex magit geiser-racket geiser-mit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
