(auto-install 'e2wm)
(use-package e2wm
  :defer t
  :init
  (bind-key "M-+" 'e2wm:start-management)
  )
