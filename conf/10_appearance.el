;; テーマ
(custom-set-variables
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (manoj-dark)))
 '(inhibit-startup-screen t))
(custom-set-faces)

;; Yes/No確認のダイアログボックスを表示しない
(setq use-dialog-box nil)

;; 対応するカッコの表示
(show-paren-mode t)
(setq show-paren-style 'mixed)

;; 行数表示
(global-linum-mode t)
(setq linum-format "%4d ")

