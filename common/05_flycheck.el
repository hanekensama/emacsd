(use-package flycheck
  :defer t
  :diminish flycheck-mode
  :init
  (global-flycheck-mode t)
  (use-package flycheck-pos-tip
    :defer t)
  
  :bind
  ("C-c n" . flycheck-next-error)
  ("C-c p" . flycheck-previous-error)
  ("C-c d" . flycheck-list-errors)
  
  :config
  (flycheck-pos-tip-mode)
  (add-hook 'c-mode-common-hook 'flycheck-mode)
  (add-hook 'c++-mode-hook
            '(lambda()
               (setq flycheck-gcc-language-standard "c++14")
             ))  
  )

