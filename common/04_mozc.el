(use-package mozc
  :ensure t
  :defer t
  :config
  (set-language-environment "Japanese")
  (setq default-input-method "japanese-mozc")
  (prefer-coding-system 'utf-8)
  )
