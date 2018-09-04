(use-package projectile
  :ensure t
  :diminish
  :init
  (projectile-mode)
  (setq projectile-completion-system 'helm)
  (use-package helm-projectile
    :ensure t
    :init
    (helm-projectile-on)
    )
  )
  
