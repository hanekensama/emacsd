(use-package auto-complete
  :diminish auto-complete-mode
  :config
  (add-to-list 'ac-dictionary-directories (locate-user-emacs-file "./ac-dict"))
  (use-package auto-complete-config)
  (ac-config-default)
  (global-auto-complete-mode t)
  )
