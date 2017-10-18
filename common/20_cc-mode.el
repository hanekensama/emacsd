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
    )
