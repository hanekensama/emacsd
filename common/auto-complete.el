(use-package auto-complete
  :ensure t
  :init
  (ac-config-default)
  (global-auto-complete-mode t)
  :config
  (ac-set-trigger-key "TAB")
  (setq ac-use-menu-map t)
  
  (use-package fuzzy
    :ensure t)
  (setq ac-use-fuzzy t)
  
  )

