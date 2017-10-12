;; Helm
(auto-install 'helm)
(auto-install 'helm-smex)
(auto-install 'helm-swoop)

(use-package helm
  :defer t
  :diminish helm-mode
  :init
  (require 'helm-config)
  (bind-key "C-x C-f" 'helm-find-files)
  (bind-key "M-x" 'helm-smex)
  (bind-key "M-X" 'helm-smex-major-mode-commands)
  (helm-mode t))

(use-package helm-swoop
  :init
  (bind-key "C-;" 'helm-swoop)
  (bind-key "M-C-;" 'helm-multi-swoop))

