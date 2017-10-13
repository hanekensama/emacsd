(use-package magit
  :defer t
  :config
  (setq-default magit-auto-revert-mode nil)
  (setq vc-handled-backends '())
  :bind
  (("C-x g" . magit-status)))

(use-package git-gutter-fringe+
  :defer t)

