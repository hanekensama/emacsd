(use-package org
  :mode (("\\.org$" . org-mode))
  :bind
  (("C-c c" . org-capture)
   ("C-c a" . org-agenda)
   ("C-c b" . org-iswitchb)
   ("C-c l" . org-iswitchb))
  :init
  (setq my-org-directory "~/Documents/org/")
  (setq my-org-agenda-directory "~/Documents/org/todo/")
  (setq org-agenda-files (list my-org-directory my-org-agenda-directory))
  :config
  (use-package org-table-sticky-header
    :config
    (add-hook 'org-mode-hook 'org-table-sticky-header-mode))
  (setq org-hide-leading-stars t)
  (setq org-startup-indented t)
  (setq org-return-follows-link t)
  (setq org-directory my-org-directory)
  (setq org-default-notes-file "captured.org")
  (setq org-capture-templates
        '(("m"
           "memo"
           entry
           (file+headline nil "MEMO")
           "* %U%?\n\n%a\n%F\n"
           :empty-lines 1)
          ("t"
           "TODO"
           entry
           (file+headline nil "TODO")
           "** TODO %T %?\n   Entered on %U    %i\n"
           :empty-lines 1))))

(use-package open-junk-file
  :ensure t
  :config
  (setq open-junk-file-format "~/Documents/org/junk/%Y-%m%d-%H%M%S.org")
  :bind
  (("C-c j" . open-junk-file)))
