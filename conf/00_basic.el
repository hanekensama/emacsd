(leaf *日本語
  :config
  (set-language-environment 'Japanese)
  (prefer-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (leaf mozc
    :disabledああ
    :bind*
    ("C-1" . toggle-input-method)
    :setq
    (default-input-method . "japanese-mozc")))

(leaf *バックアップファイル
  :setq
  (make-backup-files . nil)
  (delete-auto-save-files . t))

(leaf *タブ
  :config
  (setq-default tab-width 4)
  (setq-default indent-tabs-mode nil))

(leaf *README表示
  :config
  (defun show-help()
    (interactive)
    (switch-to-buffer
     (find-file-read-only "~/.emacs.d/readme.org"))))

(leaf *開いているふぁいる
  :bind
  ("<f5>" . revert-buffer-no-confirm))
