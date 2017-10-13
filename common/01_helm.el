(use-package helm
  :ensure t
  :defer t
  :diminish helm-mode
  :init
  (use-package helm-config
  :ensure t)
  (use-package helm-smex
  :ensure t)
  (bind-key "C-x C-f" 'helm-find-files)
  (bind-key "M-x" 'helm-smex)
  (bind-key "M-X" 'helm-smex-major-mode-commands)
  (helm-mode t))

(use-package helm-swoop
  :ensure t
  :init
  (bind-key "C-;" 'helm-swoop)
  (bind-key "M-C-;" 'helm-multi-swoop))

