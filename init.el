;;; init.el --- hub's .emacs -*- coding: utf-8 ; lexical-binding: t -*-

;; Filename: init.el
;; Description: hub's init.el
;; Package-Requires: ((emacs "24.5"))
;; Author: hub <hub@ngc.is.ritsumei.ac.jp>
;; Created: 2017-08-18
;; Version: 1.0

;;; Commentary:

;;; Code:
(setq load-path (append
                 `("~/.emacs.d/private-conf")
                 load-path))
(load "proxy-conf" t)

(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(use-package diminish
  :ensure t
  )
(use-package bind-key
  :ensure t
  )

(use-package init-loader
  :ensure t
  :config
  (setq init-loader-show-log-after-init nil))

(init-loader-load "~/.emacs.d/common")
(if (not window-system)
    (init-loader-load "~/.emacs.d/cui")
  (init-loader-load "~/.emacs.d/gui"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(create-lockfiles nil)
 '(custom-enabled-themes (quote (manoj-dark)))
 '(inhibit-startup-screen t)
 '(irony-additional-clang-options (quote ("-std=c++14")))
 '(lsp-inhibit-message t t)
 '(lsp-message-project-root-warning t t)
 '(package-selected-packages
   (quote
    (company-lsp lsp-ui lsp-mode c-eldoc company-irony-c-headers powerline rust-mode yatex yaml-mode company-irony company undo-tree quickrun yasnippet open-junk-file org-table-sticky-header git-gutter-fringe+ magit multiple-cursors expand-region flycheck-irony flycheck-pos-tip flycheck mozc e2wm maxframe smartrep helm-swoop helm-smex helm init-loader use-package)))
 '(yas-alias-to-yas/prefix-p nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
