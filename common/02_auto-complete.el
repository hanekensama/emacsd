(use-package auto-complete
  :ensure t
  :diminish auto-complete-mode
  :config
  (add-to-list 'ac-dictionary-directories (locate-user-emacs-file "./ac-dict"))
  (require 'auto-complete-config)
  (ac-config-default)
  ; (ac-ispell-setup)
  (global-auto-complete-mode t))
