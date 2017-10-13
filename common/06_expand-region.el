(use-package expand-region
  :ensure t
  :defer t
  :init
  (bind-key "C-." 'er/expand-region)
  (bind-key "C-," 'er/contract-region))
