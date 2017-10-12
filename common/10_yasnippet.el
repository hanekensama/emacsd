(auto-install 'yasnippet)

(use-package yasnippet
  :diminish yas-minor-mode
  :init
  (custom-set-variables
   '(yas-alias-to-yas/prefix-p nil))
  (yas-global-mode t))
