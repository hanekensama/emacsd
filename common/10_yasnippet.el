(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :init
  (custom-set-variables
   '(yas-alias-to-yas/prefix-p nil))
  (yas-global-mode t))
