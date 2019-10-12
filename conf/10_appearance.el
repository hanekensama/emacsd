(leaf *初期画面を表示しない
  :setq
  (inhibit-startup-screen . t))

(leaf doom-themes
  :ensure t
  :custom
  (doom-themes-enable-italic . t)
  (doom-themes-enable-bold . t)
  :config
  (load-theme 'doom-acario-dark t)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

(leaf doom-modeline
  :ensure t
  :custom
  (doom-modeline-buffer-file-name-style . 'truncate-with-project)
  (doom-modeline-icon . t)
  (doom-modeline-majormode-icon . nil)
  (doom-modeline-minor-modes . nil)
  :hook
  (after-init . doom-modeline-mode)
  :config
  (line-number-mode . t)
  (column-number-mode . t))
  
(leaf *フォント
  :config
  (leaf *Ricty)
  :if
  (member "Ricty" (font-family-list))
  :config
  (set-face-attribute 'default nil :font "Ricty-12"))

(leaf *メニューバー、ツールバー非表示
  :config
  (menu-bar-mode 0)
  (tool-bar-mode 0))

(leaf *対応する括弧の強調表示
  :setq
  (show-paren-style . 'mixed)
  :config
  (show-paren-mode t))

(leaf *行番号表示
  :setq
  (linum-format . "%4d ")
  :config
  (global-linum-mode t))

(leaf *Yes/No確認の際、ダイアログボックスを表示しない
  :setq
  (use-dialog-box . nil))

(leaf *ビープ音
  :doc
  "ビープ音を無効化"
  :setq
  (ring-bell-function . 'ignore))


(leaf e2wm
  :ensure t
  :config
  (leaf maxframe
    :ensure t
    :config
    (defun start-e2wm()
      (interactive)
      (maximize-frame)
      (sleep-for 0.1)
      (e2wm:start-management))
    (defun stop-e2wm()
      (interactive)
      (e2wm:stop-management)
      (restore-frame)))
  :bind*
  ("M-+" . start-e2wm)
  ("M-_" . stop-e2wm))
 
