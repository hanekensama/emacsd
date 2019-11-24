(leaf *コンパイル・実行
  :config
  (bind-key* "C-c c" 'compile)
  (leaf quickrun
    :ensure t
    :bind*
    ("C-x x" . quickrun)))

(leaf *ソースコード折りたたみ
  :config
  (bind-key* "C-\\" 'hs-toggle-hiding)
  (delight 'hs-minor-mode nil))

(leaf yasnippet
  :ensure t
  :delight yas-minor-mode
  :setq
  (yas-snippet-dirs . '("~/.emacs.d/mysnippets"
                        "~/.emacs.d/yasnippets"))
  :custom
  (yas-alias-to-yas/prefix-p . nil)
  :bind
  (:yas-minor-mode-map
   ("C-x i i" . yas-insert-snippet)
   ("C-x i n" . yas-new-snippet)
   ("C-x i v" . yas-visit-snippet-file)
   ("C-x i l" . yas-describe-tables)
   ("C-x y" . yas-insert-snippet))
  (:yas-keymap
   ("<tab>" . nil))
  :config
  (yas-global-mode t))

(leaf flycheck
  :ensure t
  :config
  (global-flycheck-mode t))

(leaf company
  :ensure t
  :delight t
  :after yasnippet
  :defvar
  company-mode/enable-yas
  :custom
  (company-transformers . '(company-sort-by-backend-importance))
  (company-idle-delay . 0.1)
  (company-echo-delay . 0.1)
  (company-minimum-prefix-length . 2)
  (company-selection-wrap-around . t)
  (completion-ignore-case . t)
  (company-mode/enable-yas . t)
  :bind*
  ("C-j" . company-complete)
  :bind
  (:company-active-map
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous)
   ("C-s" . company-filter-candidates)
   ("C-f" . company-complete-selection)
   ("<tab>" . company-complete-selection))
  (:company-search-map
   ("C-n" . company-select-next)
   ("C-p" . company-select-previous))
  :init
  (defun company/backend-yasnippet (backend)
    (if (or (not company-mode/enable-yas)
            (and (listp backend)
                 (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend)
                  backend
                (list backend))
              '(:with company-yasnippet))))
  (add-to-list 'company-backends 'company-files)
  (global-company-mode t)
  :setq
  (company-backends . (mapcar #'company/backend-yasnippet company-backends))
  :config
  (leaf company-quickhelp
    :ensure t
    :config
    (company-quickhelp-mode t))
  (leaf company-box
    :ensure t
    :hook
    (company-mode . company-box-mode)))

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
  :bind
  ("C-l" . nil)
  ("C-l C-l" . lsp)
  ("C-l h" . lsp-describe-definition)
  ("C-l t" . lsp-goto-definition)
  ("C-l r" . lsp-rename)
  ("C-l <f5>" . lsp-restart-workspace)
  ("C-l l" . lsp-lens-mode)
  :hook
  (prog-major-mode . lsp-prog-major-mode-enable)
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
    (lsp-ui-sideline-show-symbol . t)ppp
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
    ("C-l C-r" . lsp-ui-find-references)
    :hook
    (lsp-mode-hook . lsp-ui-mode))
    (leaf company-lsp
      :ensure t
      :after lsp-ui company
      :commands company-lsp
      :custom
      (company-lsp-cache-candidates . nil)
      (company-lsp-async . t)
      (company-lsp-enable-recompletion . t)
      (company-lsp-enable-snippet . t)
      :init
      (push 'company-lsp company-backends))
    (leaf helm-lsp
      :ensure t
      :commands helm-lsp-workspace-symbol)
    :hook
    (prog-mode))

(leaf cc-mode
  :mode
  ("\\.c\\'" "\\.h\\'" . c-mode)
  ("\\.cpp\\'" "\\.cxx\\'" "\\.hpp\\'" "\\.hxx\\'" . c++-mode)
  :setq
  (c-default-style . "stroustrup")
  (c-basic-offset 4)
  (c-auto-newline t)
  :hook
  (cc-mode . (lsp company-mode flycheck-mode hs-minor-mode))
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

(leaf *rust
  :config
  (leaf rustic
    :ensure t
    :hook
    (rustic-mode . (lsp))
    :mode
    ("\\.rs'" . rustic-mode)
    :config
    (leaf racer
      :ensure t)))

(leaf *emacs-lisp
  :config
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  (add-hook 'emacs-lisp-mode-hook 'hs-minor-mode))

