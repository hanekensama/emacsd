;;; init.el --- hub's .emacs -*- coding: utf-8 ; lexical-binding: t -*-

;; Filename: init.el
;; Description: hub's init.el
;; Package-Requires: ((emacs "24.5"))
;; Author: hub <hub@ngc.is.ritsumei.ac.jp>
;; Created: 2017-08-18
;; Version: 1.0

;;; Commentary:

;;; Code:
;; Install packages automatically
(require 'package)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(setq package-refreshed 0)
(defun auto-install (pkg) 
  (unless (package-installed-p pkg)
    (unless (package-refreshed 1)
      (package-refresh-contents)
      (setq package-refreshed 1))
    (package-install pkg)))

(auto-install 'use-package)
(auto-install 'diminish)
(require 'use-package)

(auto-install 'init-loader)
(use-package init-loader
  :config
  (setq init-loader-show-log-after-init nil))

(init-loader-load "~/.emacs.d/common")
(if (not window-system)
    (init-loader-load "~/.emacs.d/cui")
  (init-loader-load "~/.emacs.d/gui"))
