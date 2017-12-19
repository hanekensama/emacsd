(use-package irony
  :ensure t
  :defer t
  :init
  (custom-set-variables '(irony-additional-clang-options '("-std=c++14")))
  (use-package company-irony
    :ensure t
    :init
    (add-to-list 'company-backends 'company-irony)
    )
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  (add-hook 'c-mode-common-hook 'irony-mode))
