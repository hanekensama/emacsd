(leaf *日本語
  :config
  (set-language-environment "Japanese")
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-keyboard-coding-system 'utf-8)
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
  :config
  (setq-default tab-width 4)
  (setq-default indent-tabs-mode nil))

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
  :diminish t
  :init
  (leaf helm-smex
    :ensure t
    :diminish t
    :bind*
    ("M-x" . helm-smex)
    ("M-X" . helm-smex-major-mode-commands))
  (leaf helm-swoop
    :ensure t
    :diminish t
    :bind*
    ("C-;" . helm-swoop)
    ("M-C-;" . helm-multi-swoop))
  :config
  (helm-mode t)
  :bind*
  ("C-x C-f" . helm-find-files))

(leaf smartrep
  :ensure t
  :config
  (smartrep-define-key global-map "C-x"
    '(("o" . other-window))))

(leaf expand-region
  :ensure t
  :bind*
  ("C-." . er/expand-region)
  ("C-," . ex/contract-region))


(leaf multiple-cursors
  :ensure t
  :after smartrep
  :config
  (declare-function smartrep-define-key "smartrep")
  (global-unset-key (kbd "C-t"))
  (smartrep-define-key global-map "C-t"
    '(("C-t" . 'mc/mark-next-like-this)
      ("n" . 'mc/mark-next-like-this)
      ("p" . 'mc/mark-previous-like-this)
      ("*" . 'mc/mark-all-like-this))))

