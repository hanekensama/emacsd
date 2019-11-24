(leaf *日本語
  :config
  (set-language-environment "Japanese")
  (leaf mozc
    :ensure t
    :bind*
    ("C-1" . toggle-input-method)
    :setq
    (default-input-method . "japanese-mozc")))

(leaf *バックアップファイル
  :setq
  (make-backup-files . nil)
  (delete-auto-save-files . t))

(leaf *デフォルトタブ幅
  :setq-default
  (tab-width . 4)
  (indent-tabs-mode . nil))

(leaf *README表示
  :config
  (defun show-help()
    (interactive)
    (switch-to-buffer (find-file-read-only "~/.emacs.d/readme.org"))))

(leaf *開いているファイルを再読込する
  :config
  (defun revert-buffer-no-confirm (&optional force-reverting)
    (interactive "P")
    (if (or force-reverting (not (buffer-modified-p)))
        (revert-buffer :ignore-auto :noconfirm)
      (error "The buffer has been modified")))
  :bind
  ("<f5>" . revert-buffer-no-confirm))

(leaf helm
  :ensure t
  :delight Helm
  :init
  (leaf helm-smex
    :ensure t
    :bind*
    ("M-x" . helm-smex)
    ("M-X" . helm-smex-major-mode-commands))
  (leaf helm-swoop
    :ensure t
    :bind*
    ("C-;" . helm-swoop)
    ("M-C-;" . helm-multi-swoop))
  (leaf swiper-helm
    :ensure t
    :bind*
    ("C-s" . swiper-helm))
  :config
  (helm-mode t)
  :bind*
  ("C-x C-f" . helm-find-files))

(leaf *Window間移動
  :smartrep*
  ("C-x"
   (("o" . other-window))))

(leaf bind-key
  :ensure t)
