(leaf *コンパイル・実行
  :bind*
  ("C-c c" . compile)
  :config
  (leaf quickrun
    :ensure t
    :bind*
    ("C-x x" . quickrun)))

(leaf yasnippet
  :ensure t
  :diminish yas-minor-mode
  :custom
  (yas-alias-to-yas/prefix-p . nil)
  :bind
  (:yas-minor-mode-map
   ("C-x i n" . yas-new-snippet)
   ("C-x i v" . yas-visit-snippet-file)
   ("C-x y" . yas-insert-snippet))
  (:yas-keymap
   ("<tab>" . nil))
  :config
  (yas-global-mode t))

(leaf lsp-mode
  :ensure t
  :commands lsp
  :custom
  (lsp-enable-snippet . t)
  (lsp-enable-indentation . nil)
  (lsp-docmuent-sync-method . 'incremental)
  (lsp-inhibit-message . t)
  (lsp-message-project-root-warning . t)
  (create-lockfiles . nil)
  :init
  (unbind-key "C-l")
  :bind
  ("C-l C-l" . lsp)
  ("C-l h" . lsp-describe-definition)
  ("C-l t" . lsp-goto-type-definition)
  ("C-l r" . lsp-rename)
  ("C-l <f5>" . lsp-restart-workspace)
  ("C-l l" . lsp-lens-mode)
  :config
  (leaf lsp-ui
    :ensure t
    :custom
    (lsp-ui-doc-enable . t)
    (lsp-ui-doc-header . t)
    (lsp-ui-doc-include-signature . t)
    (lsp-ui-doc-position . 'doc)
    (lsp-ui-doc-use-childframe . t)
    (lsp-ui-doc-max-width . 60)
    (lsp-ui-doc-max-height . 20)
    (lsp-ui-doc-use-webkit . t)

    (lsp-ui-flycheck-enable . t)

    (lsp-ui-sideline-enable . t)
    (lsp-ui-sideline-ignore-duplicate . t)
    (lsp-ui-sideline-show-symbol . t)
    (lsp-ui-sideline-show-hover . t)
    (lsp-ui-sideline-show-diagnostics . t)
    (lsp-ui-sideline-show-code-actions . t)

    (lsp-ui-imenu-enable . nil)
    (lsp-ui-imenu-kind-position . 'top)

    (lsp-ui-peek-enable . t)
    (lsp-ui-peek-always-show . t)
    (lsp-ui-peek-peek-height . 30)
    (lsp-ui-peek-list-width . 30)
    (lsp-ui-peek-fontify . 'always)
    
    :bind
    ("C-l s" . lsp-ui-sideline-mode)
    ("C-l C-d" . lsp-ui-find-definition)
    ("C-l C-r" . lsp-ui-find-references))
    
  (leaf company
    :ensure t
    :after yasnippet
    :custom
    (company-transformers . '(company-sort-by-backend-importance))
    (company-idle-delay . 0)
    (company-echo-delay . 0)
    (company-minimum-prefix-length . 1)
    (company-selection-wrap-around . t)
    (completion-ignore-case . t)
    (company-mode/enable-yas . t)
    :bind
    ("C-M-c" . company-complete)
    (:company-active-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)
          ("C-s" . company-filter-candidates)
          ("C-i" . company-complete-selection)
          ("C-f" . company-complete-selection)
          ("[tab]" . company-complete-selection))
    (:company-search-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous))
    :init
    (global-company-mode t)
    :config
    (defun company-mode/backend-with-yas (backend)
      (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
          backend
        (append (if (consp backend)
                    backend
                  (list backend))
                '(:with comapny-yasnippet))))
    (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends)))
    (leaf company-lsp
      :ensure t
      :after lsp-ui yasnippet
      :commands company-lsp
      :custom
      (company-lsp-cache-candidates . nil)
      (company-lsp-async . t)
      (company-lsp-enable-recompletion . t)
      (company-lsp-enable-snippet . t)
      :init
      (push 'company-lsp company-backends)))
  
  (leaf lsp-ui
    :ensure t
    :hook
    (lsp-mode-hook . lsp-ui-mode)
    :commands lsp-ui-mode)
  (leaf helm-lsp
    :ensure t
    :commands helm-lsp-workspace-symbol)
  :hook
  (prog-major-mode . lsp-prog-major-mode-enable))

(leaf cc-mode
  :mode
  ("\\.c\\'" "\\.h\\'" . c-mode)
  ("\\.cpp\\'" "\\.cxx\\'" "\\.hpp\\'" "\\.hxx\\'" . c++-mode)
  :setq
  (c-default-style . "stroustrup")
  (c-basic-offset 4)
  (c-auto-newline t)
  :hook
  (cc-mode . (lsp company-mode flycheck-mode))
  :config
  (leaf clang-format
    :ensure t)
  (leaf ccls
    :after lsp-mode
    :if
    (file-directory-p "/usr/local/bin/ccls")
    :custom
    (ccls-executable "/usr/local/bin/ccls")
    (ccls-sem-highlight-method 'font-lock)
    (ccls-use-default-rainbow-sem-highlight)
    :hook
    (cc-mode . (lambda () (require 'ccls) (lsp)))))

