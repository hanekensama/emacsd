;; Description: hub's init.el
;; Author: hub <hub@ngc.is.ritsumei.ac.jp>
;; Created: 2017-08-18

(prog1 "環境固有設定の読み込み(proxy設定などを含むため、必ず最初に実行する)"
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
      :config
      (leaf delight
        :ensure t
        :require t)
      (leaf smartrep
        :ensure t)
      (leaf el-get
        :ensure t
        :custom
        (el-get-git-shallow-clone . t))
      (leaf-keywords-init))))

(leaf *外部設定ファイルの読み込み
  :config
  (leaf init-loader
    :ensure t
    :defvar
    init-loader-show-log-after-init
    :setq
    (init-loader-show-log-after-init . 'error-only)
    :config
    (init-loader-load "~/.emacs.d/conf")))

(leaf *customizeの出力先設定
  :config
  (setq custom-file "~/.emacs.d/custom-config.el")
  (if (file-exists-p (expand-file-name "~/.emacs.d/custom-config.el"))
      (load (expand-file-name custom-file) t nil nil)))
