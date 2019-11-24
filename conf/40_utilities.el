(leaf expand-region
  :ensure t
  :bind*
  ("C-." . er/expand-region)
  ("C-," . er/contract-region))

(leaf multiple-cursors
  :ensure t
  :smartrep*
  ("C-t"
   (("C-t" . mc/mark-next-like-this)
    ("n" . mc/mark-next-like-this)
    ("p" . mc/mark-next-like-this)
    ("*" . mc/mark-all-like-this))))

(leaf undo-tree
  :ensure t
  :bind
  ("C-x u" . undo-tree-visualize)
  :config
  (global-undo-tree-mode t))

(leaf *テンプレート
  :config
  (setq auto-insert-directory "~/.emacs.d/templates")
  (auto-insert-mode t))

(leaf *org-mode
  :config
  (leaf org
    :ensure t
    :mode
    ("\\.org$")
    :bind
    ("C-o" . nil)
    ("C-o c" . org-capture)
    ("C-o a" . org-agenda)
    ("C-o b" . org-iswitchb)
    :setq
    (my-org-directory . "~/Documents/org")
    (my-org-agenda-directory . "~/Documents/org/todo")
    (org-agenda-files . (list my-org-agenda-directory))
    (org-todo-keywords . '((sequence "TODO(t)" "Doing(i)" "Waiting(w)" "|" "DONE(d)" "CANCEL(c)")))
    (org-clock-clocktable-default-properties . '(:maxlevel 4 :scope tree))
    (org-log-done . 'time)
    (org-hide-leading-stars . t)
    (org-startup-indented . t)
    (org-return-follows-link . t)
    (org-directory . my-org-directory)
    (org-default-notes-file . "note.org")
    (org-capture-templates
     . '(("m"
          "memo"
          entry
          (file+headline (concat my-org-directory "note.org") "MEMO")
          "* %U%?\n\n%a\n%F\n"
          :empty-lines-after 1)
         ("t"
          "TODO"
          entry
          (file+headline (concat my-org-agenda-directory "todo.org") "InBox")
          "** TODO %T %? \n Entered on %U    %i\n"
          :empty-lines-after 1)))
    :config
    (define-auto-insert "\\.org$" "org-template.org")

    (leaf org-table-sticky-header
      :ensure t
      :hook
      (org-mode-hook . org-table-sticky-header-mode))

    (leaf open-junk-file
      :ensure t
      :setq
      (open-junk-file-format . "~/Documents/org/junk/%Y/%m/%d.org")
      :bind
      ("C-o j" . open-junk-file))))

(leaf *モード
  :config
  (leaf csv-mode
    :ensure t
    :mode
    ("\\.csv$"))
  
  (leaf markdown-mode
    :ensure t
    :mode
    ("\\.markdown$"  "\\.md$"))
  
  (leaf logview
    :ensure t
    :mode
    ("\\.log$")))

(leaf *git
  :config
  (leaf magit
    :ensure t
    :setq
    (vc-handled-backends . '())
    :setq-default
    (magit-auto-rever-mode . nil)
    :bind
    ("C-x g" . magit-status))
  (leaf git-gutter
    :ensure t
    :delight GitGutter
    :config
    (global-git-gutter-mode t)))

(leaf projectile
  :ensure t
  :delight Projectile
  :setq
  (projectile-completion-system . 'helm)
  (projectile-mode-line . '(:eval (format "PJ[%s]" (projectile-project-name))))
  :config
  (projectile-mode t)
  (leaf helm-projectile
    :ensure t
    :config
    (helm-projectile-on)))

(leaf *Webブラウザ
  :config
  (leaf eww
    :ensure t
    :bind
    ("C-c w" . eww-search)
    ("C-c u" . browse-url-with-eww)
    (:eww-mode-map
     ("r" . eww-reload)
     ("w" . eww-copy-page-url)
     ("p" . scroll-down)
     ("n" . scroll-up))
    :defvar
    eww-disable-colorize
    :setq
    (eww-search-prefix . "http://www.google.co.jp/search?q=")
    (eww-disable-colorize . t)
    :preface
    (defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
      (unless eww-disable-colorize
        (funcall orig start end fg)))
    (leaf *文字色反映の切り替え
      :config
      (defun eww-disable-color ()
        (interactive)
        (setq-local eww-disable-colorize t)
        (eww-reload))
      (defun eww-enable-color ()
        (interactive)
        (setq-local eww-disable-colorize nil)
        (eww-reload)))
    (leaf *複数バッファで起動するときにバッファ名を変更する
      :config
      (defun eww-mode-hook--rename-buffer ()
        (rename-buffer "eww" t)))
    (leaf *検索結果をハイライトする
      :config
      (defun eww-search (term)
        (interactive "sSearch Terms: ")
        (setq eww-hl-search-word term)
        (eww-browse-url (concat (eww-search-prefix term)))))
    (leaf *カーソルがある位置のURL文字列をewwで開く
      :config
      (defun browse-url-with-eww ()
        (interactive)
        (let ((url-region (bounds-of-thing-at-point 'url)))
          (if url-region
              (eww-browse-url (buffer-substring-no-properties (car url-region)
                                                              (cdr url-region)))
            (setq browse-url-browser0function 'eww-browse-url)
            (org-open-at-point)))))
    (leaf *画像の表示/非表示切り替え
      :config
      (defun shr-put-image-alt (spec alt &optional flags)
        (insert alt))
      (defun eww-disable-images ()
        (interactive)
        (setq-local shr-put-image-function 'shr-put-image-alt)
        (eww-reload))
      (defun eww-enable-images ()
        (interactive)
        (setq-local shr-put-image-function 'shr-put-image)
        (eww-reload))
      (defun eww-mode-hook--disable-image ()
        (setq-local shr-put-image-function 'shr-put-image-alt)))

    :hook
    (eww-mode-hook . (eww-mode-hook--disable-image
                      eww-mode-hook--rename-buffer))
    :advice
    (:around shr-colorize-region shr-colorize-region--disable)
    (:around eww-colorize-region shr-colorize-region--disable)
    :config
    (leaf ace-link
      :ensure t
      :bind
      (:eww-mode-map
       ("f" . ace-link-eww))
      :config
      (ace-link-setup-default))))
