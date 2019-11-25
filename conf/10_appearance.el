(leaf *初期画面を表示しない
  :config
  (setq inhibit-startup-screen t))

(leaf *テーマ
  :config
  (leaf doom-themes
    :ensure t
    :custom
    (doom-themes-enable-italic . t)
    (doom-themes-enable-bold . t)
    :config
    (load-theme 'doom-acario-dark t)
    (doom-themes-neotree-config)
    (doom-themes-org-config)))

(leaf *フォント
  :config
  (leaf *Ricty
    :config
    (if (member "Ricty Diminished" (font-family-list))
        (set-face-attribute 'default nil :font "Ricty Diminished-14")
      (if (member "Ricty" (font-family-list))
          (set-face-attribute 'default nil :fonr "Ricty-14")))))

(leaf *メニューバー、ツールバー非表示
  :config
  (menu-bar-mode 0)
  (tool-bar-mode 0))

(leaf *対応する括弧の強調表示
  :defvar
  show-paren-style
  :setq
  (show-paren-style . 'mixed)
  :config
  (show-paren-mode t))

(leaf *行番号表示
  :config
  (if (version<= "26.0.50" emacs-version)
      (global-display-line-numbers-mode t)
    (global-linum-mode t)))

(leaf *Yes/No確認の際、ダイアログボックスを表示しない
  :config
  (setq use-dialog-box nil))

(leaf *ビープ音
  :config
  (setq ring-bell-function 'ignore))

(leaf e2wm
  :ensure t
  :defun
  start-e2wm stop-e2wm e2wm:stop-management
  :init
  (leaf maxframe
    :ensure t)
  :bind*
  ("M-+" . start-e2wm)
  ("M-_" . stop-e2wm)
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

(leaf *モードライン
  :config
  (leaf spaceline
    :ensure t
    :setq-default
    (mode-line-format '("%e" (:eval (spaceline-ml-main)))))
  (leaf spaceline-config
    :ensure spaceline
    :defvar
    powerline-default-separator
    ns-use-srgb-colorspace
    mode-icons-grayscale-transform
    :setq
    (powerline-default-separator . 'slant)
    (ns-use-srgb-colorspace . nil)
    (mode-icons-grayscale-transform . nil)
    :config
    (spaceline-helm-mode t)
    (spaceline-emacs-theme t)))

