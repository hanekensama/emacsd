(auto-install 'expand-region)

(use-package expand-region
  :defer t
  :init
  (bind-key "C-." 'er/expand-region)
  (bind-key "C-," 'er/contract-region))
