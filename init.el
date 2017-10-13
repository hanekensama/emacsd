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
      '(("melpa" . "http://melpa.org/packages/")))
(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-pakcage-always-ensure t)
(use-package diminish)

(use-package init-loader
  :config
  (setq init-loader-show-log-after-init nil))

(init-loader-load "~/.emacs.d/common")
(if (not window-system)
    (init-loader-load "~/.emacs.d/cui")
  (init-loader-load "~/.emacs.d/gui"))

(defun show-help()
  (interactive)
  (switch-to-buffer (find-file-read-only "~/.emacs.d/usage.org")))
