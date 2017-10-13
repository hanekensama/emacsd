(use-package flycheck
  :defer t
  :diminish flycheck-mode
  :init
  (global-flycheck-mode t)
  (use-package flycheck-pos-tip
    :defer t)
  :config
  (flycheck-pos-tip-mode)
  (define-key flycheck-mode-map (kbd "C-M-n") 'flycheck-next-error)
  (define-key flycheck-mode-map (kbd "C-M-p") 'flycheck-previous-error)
  (add-hook 'c-mode-common-hook 'flycheck-mode)
  (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++14"))))
