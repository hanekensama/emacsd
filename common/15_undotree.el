(use-package undo-tree
  :ensure t
  :defer t
  :init
  (global-undo-tree-mode t)
  :bind
  ("C-?" . undo-tree-redo)
  )
