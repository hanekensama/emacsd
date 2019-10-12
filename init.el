;; Description: hub's init.el
;; Author: hub <hub@ngc.is.ritsumei.ac.jp>
;; Created: 2017-08-18

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
      :init
      (leaf diminish
        :ensure t
        :require t)
      (leaf hydra
        :ensure t)
      (leaf el-get
        :ensure t
        :custom
        ((el-get-git-shallow-clone t)))
      :config
      (leaf-keywords-init))))

          
(leaf *各設定ファイルの読み込み
  :config
  (leaf init-loader
    :ensure t
    :setq
      (init-loader-show-log-after-init . nil))
  (init-loader-load "./conf"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-buffer-file-name-style (quote truncate-with-project))
 '(doom-modeline-icon t)
 '(doom-modeline-majormode-icon nil t)
 '(doom-modeline-minor-modes nil)
 '(doom-themes-enable-bold t)
 '(doom-themes-enable-italic t)
 '(el-get-git-shallow-clone nil)
 '(package-archives
   (quote
    (("org" . "https://orgmode.org/elpa/")
     ("melpa" . "https://melpa.org/packages/")
     ("gnu" . "https://elpa.gnu.org/packages/"))))
 '(package-selected-packages
   (quote
    (helm-lsp lsp-ui lsp-mode yasnippet maxframe e2wm doom-modeline doom-themes multiple-cursors expand-region smartrep helm-swoop helm-smex helm mozc init-loader el-get hydra diminish leaf-keywords leaf)))
 '(t nil t)
 '(yas-alias-to-yas/prefix-p nil t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
