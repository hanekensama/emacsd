;; テーマ
(custom-set-variables
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (manoj-dark)))
 '(inhibit-startup-screen t))
(custom-set-faces)

(set-language-environment 'Japanese)            ; 日本語
(prefer-coding-system 'utf-8)                   ; 文字コードはUTF-8
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq make-backup-files nil)                    ; バックアップファイルを作らない
(setq delete-auto-save-files t)
(setq use-dialog-box nil)

(setq-default tab-width 2 indent-tabs-mode nil) ; タブ幅は2, インデントはスペース
(show-paren-mode t)                             ; 対応するカッコを表示
(setq show-paren-style 'mixed) 
(global-linum-mode t)                           ; 行数を表示(遅くなる。)
(setq linum-format "%4d ")

(bind-key* "C-c c" 'compile)

(defun show-help()
  (interactive)
  (switch-to-buffer (find-file-read-only "~/.emacs.d/readme.org")))
