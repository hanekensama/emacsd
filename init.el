;;; init.el --- hub's .emacs -*- coding: utf-8 ; lexical-binding: t -*-

;; Filename: init.el
;; Description: hub's init.el
;; Package-Requires: ((emacs "24.5"))
;; Author: hub <hub@ngc.is.ritsumei.ac.jp>
;; Created: 2017-08-18
;; Version: 1.0

;;; Commentary:

;;; Code:
(prog1 "proxy設定の読み込み"
  (load "~/.emacs.d/proxy-conf" t))

(prog1 "パッケージ周りの設定"
  (prog1 "パッケージ利用の準備"
    (custom-set-variables
     '(package-archives
       '(("org"   . "https://orgmode.org/elpa/")
	 ("melpa" . "https://melpa.org/packages/")
	 ("gnu"   . "https://elpa.gnu.org/packages/"))))
    (package-initialize))

  (prog1 "leaf.elの設定"
    (unless (package-installed-p 'leaf)
      (unless (assoc 'leaf package-archive-contents)
        (package-refresh-contents))
      (condition-case err
          (package-install 'leaf)
        (error
         (package-refresh-contents)
         (package-install 'leaf))))

    (leaf leaf-keywords
      :ensure t
      :config (leaf-keywords-init)))

  (prog1 "leaf-keywordsの追加設定"
    (leaf hydra
      :ensure t)
    (leaf el-get
      :ensure t
      :custom ((el-get-git-shallow-clone . t)))))
          
(leaf *他の設定ファイル読み込み
  :config
  (leaf init-loader
    :ensure t
    :setq
      (init-loader-show-log-after-init . t))
  (init-loader-load "./common")
  (init-loader-load "./conf"))
