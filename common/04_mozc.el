(auto-install 'mozc)
(use-package mozc
  :defer t
  :config
  (set-language-environment "Japanese")
  (setq default-input-method "japanese-mozc")
  (prefer-coding-system 'utf-8)
  )
