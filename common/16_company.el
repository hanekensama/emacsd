(use-package company
  :ensure t
  :init
  (global-company-mode t)
  (global-set-key (kbd "C-M-i") 'company-complete)
  (setq company-idle-delay 0)
  (setq company-echo-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)

  :config
  (bind-keys :map company-active-map
             ("C-n" . company-select-next)
             ("C-p" . company-select-previous)
             ("<tab>" . company-complete-selection))
  (bind-keys :map company-search-map
             ("C-n" . company-select-next)
             ("C-p" . company-select-previous)
       ))
