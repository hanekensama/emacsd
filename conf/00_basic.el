; 日本語
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)

; バックアップファイル
(setq make-backup-files nil)
(setq delete-auto-save-files t)

;; タブ
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; README 表示
(defun show-help()
  (interactive)
  (switch-to-buffer (find-file-read-only "~/.emacs.d/readme.org")))

(bind-key "<f5>" 'revert-buffer-no-confirm)

