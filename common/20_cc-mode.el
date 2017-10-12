(use-package cc-mode
  :mode
    ("\\.c\\'" . c-mode)
    ("\\.cpp\\'" . c++-mode)
    ("\\.cxx\\'" . c++-mode)
    ("\\.h\\'" . c-mode)
    ("\\.hpp\\'" . c++-mode)
    ("\\.hxx\\'" . c++-mode)
  :config
    (setq c-default-style "k&r")
    (setq c-basic-offset 2)
    )
