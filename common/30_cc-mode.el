(use-package cc-mode
  :mode
  ("\\.c\\'" . c-mode)
  ("\\.cpp\\'" . c++-mode)
  ("\\.cxx\\'" . c++-mode)
  ("\\.h\\'" . c-mode)
  ("\\.hpp\\'" . c++-mode)
  ("\\.hxx\\'" . c++-mode)
  :config
  (setq c-default-style "stroustrup")
  (setq c-basic-offset 2)
  (setq c-auto-newline t) ; {や;などを入力すると自動で改行
  (electric-pair-mode t)
  (use-package irony
    :ensure t
    :defer t
    :init
    (setq irony-additional-clang-options '("-std=c++14"))
    (use-package company-irony
      :ensure t
      :defer t
      :init
      (add-to-list 'company-backends 'company-irony))
    (use-package company-irony-c-headers
      :ensure t
      :defer t
      )
    (use-package c-eldoc
      :ensure t
      :defer t
      :config
      (setq c-eldoc-buffer-regenerate-time 60)
      :hook
      ((c-mode c++-mode) . c-turn-on-eldoc-mode)
      )
    :hook
    ((irony-mode . irony-cdb-autosetup-compile-options)
     ((c-mode c++-mode) . irony-mode))
    )
  )