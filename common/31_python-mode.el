(use-package python
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python3" . python-mode)
  :init
  (use-package jedi
    :ensure t
    :defer t
    ;; You need to run command 'jedi:install-server'
    )
  (jedi:setup)
  (setq jedi:complete-on-dot t)
  )
