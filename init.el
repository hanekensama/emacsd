;; Description: hub's init.el
;; Author: hub <hub@ngc.is.ritsumei.ac.jp>
;; Created: 2017-08-18

(prog1 "環境固有設定の読み込み(proxy設定などを含むため、必ず最初に実行する)"
  (load "~/.emacs.d/private-conf" t))

(prog1 "leaf"
  (prog1 "install leaf"
    (custom-set-variables
     '(package-archives
       '(("org"   . "https://orgmode.org/elpa/")
         ("melpa" . "https://melpa.org/packages/")
         ("gnu"   . "https://elpa.gnu.org/packages/"))))
    (package-initialize)

    (unless (package-installed-p 'leaf)
      (package-refresh-contents)
      (package-install 'leaf)))
  
    (leaf leaf-keywords
      :ensure t
      :require t
      :config
      (leaf delight
        :ensure t
        :require t)
      (leaf smartrep
        :ensure t
        :require t)
      (leaf el-get
        :ensure t
        :require t
        :custom
        (el-get-git-shallow-clone . t))
      (leaf bind-key
        :ensure t
        :require t)
      (leaf-keywords-init)))

(leaf *customizeの出力先設定
  :config
  (setq custom-file "~/.emacs.d/custom-config.el")
  (if (file-exists-p (expand-file-name "~/.emacs.d/custom-config.el"))
      (load (expand-file-name custom-file) t nil nil)))

(leaf *基本設定
  :config
  (leaf *日本語
    :config
    (set-language-environment "Japanese")
    (prefer-coding-system 'utf-8)
    (leaf mozc
      :ensure t
      :require t
      :setq
      (default-input-method . "japanese-mozc")))

  (leaf *バックアップファイル
    :config
    (setq make-backup-files nil)
    (setq delete-auto-save-files t))

  (leaf *タブ設定
    :config
    (setq-default tab-width 4)
    (setq-default indent-tabs-mode nil))
  )

(leaf *ユーティリティ
  :config
  (leaf *README表示
    :config
    (defun show-help()
      (interactive)
      (switch-to-buffer (find-file-read-only "~/.emacs.d/readm.org"))))

  (leaf *開いているファイルの再読込
    :config
    (defun revert-buffer-no-confirm (&optional force-reverting)
      (interactive "P")
      (if (or force-reverting (not (buffer-modified-p)))
          (revert-buffer :ignore-auto :noconfirm)
        (error "The buffer has been modified")))
    (bind-key "<f5>" 'revert-buffer-no-confirm))

  (leaf ivy
    :ensure t
    :require t
    :delight t
    :setq
    (ivy-use-virtual-buffers . t)
    (enable-recursive-minibuffers . t)
    (ivy-truncate-lines . nil)
    (ivy-wrap . t)
    :bind
    (:ivy-minibuffer-map
     ("<escape>" . minibuffer-keyboard-quit))
    :config
    (ivy-mode 1))

  (leaf counsel
    :ensure t
    :require t
    :delight t
    :after ivy
    :bind*
    ("M-x" . counsel-M-x)
    ("M-y" . counsel-yank-pop)
    ("C-M-z" . counsel-fzf)
    ("C-x b" . counsel-switch-buffer)
    ("C-x C-b" . counsel-ibuffer)
    ("C-M-f" . counsel-ag)
    :config
    (counsel-mode 1))

  (leaf swiper
    :ensure t
    :require t
    :setq
    (swiper-include-line-numer-in-search . t)
    :bind*
    ("C-s" . swiper))

  (leaf recentf
    :ensure t
    :require t
    :after counsel
    :setq
    (recentf-save-file . "~/.emacs.d/.recentf")
    (recentf-max-saved-items . 200)
    (recentf-exclude '(".recentf"))
    (recentf-auto-cleanup . 'never)
    :bind*
    ("C-x C-r" . counsel-recentf)
    :config
    (run-with-idle-timer 30 t '(lambda () (with-suppressed-message (recentf-save-list))))
    (leaf recentf-ext :ensure t :require t))

  (leaf *Window間移動
    :smartrep*
    ("C-x"
     (("o" . other-window))))

  (leaf e2wm
    :ensure t
    :require t
    :defun
    start-e2wm stop-e2wm e2wm:stop-management
    :bind*
    ("M-+" . start-e2wm)
    ("M-_" . stop-e2wm)
    :config
    (leaf maxframe
      :ensure t)
    (defun start-e2wm()
      (interactive)
      (maximize-frame)
      (sleep-for 0.1)
      (e2wm:start-management))
    (defun stop-e2wm()
      (interactive)
      (e2wm:stop-management)
      (restore-frame)))

  (leaf open-junk-file
    :ensure t
    :require t
    :setq
    (open-junk-file-format . "~/Documents/org/junk/%Y/%m/%d.org")
    :bind*
    ("C-o j" . open-junk-file))

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
  )

(leaf *appearance
  :config
  (leaf *初期画面を表示しない
    :config
    (setq inhibit-startup-screen t))

  (leaf *ベルを無効化
    :config
    (setq ring-bell-function 'ignore))

  (leaf *メニューバー、ツールバー非表示
    :config
    (menu-bar-mode 0)
    (tool-bar-mode 0))

  (leaf *Yes/No確認の際、ダイアログボックスを表示しない
    :config
    (setq use-dialog-box nil))

  (leaf *Ricty
    :config
    (if (member "Ricty Diminished" (font-family-list))
        (set-face-attribute 'default nil :font "Ricty Diminished-14")
      (if (member "Ricty" (font-family-list))
          (set-face-attribute 'default nil :font "Ricty-14"))))

  (leaf doom-themes
    :ensure t
    :setq
    (doom-themes-enable-italic . t)
    (doom-themes-enable-bold . t)
    :config
    (load-theme 'doom-acario-dark t)
    (doom-themes-neotree-config)
    (doom-themes-org-config))

  (leaf *モードライン
    :config
    (leaf spaceline
      :ensure t
      :require t
      :setq-default
      (mode-line-format '("%e" (:eval (spaceline-ml-main)))))
    (leaf spaceline-config
      :ensure spaceline
      :defvar
      powerline-default-separator
      ns-use-srgb-colorspace
      mode-icons-grayscale-transform
      :setq
      (powerline-default-separator . 'slant)
      (ns-use-srgb-colorspace . nil)
      (mode-icons-grayscale-transform . nil)
      :config
      (spaceline-emacs-theme t)))
  
  (leaf *対応する括弧の強調表示
      :config
      (setq show-paren-style 'mixed)
      (show-paren-mode t))
  
  (leaf *行番号表示
      :config
      (if (version<= "26.0.50" emacs-version)
          (global-display-line-numbers-mode t)
        (global-linum-mode t)))
  )

(leaf *プログラミング支援
  :config
  (leaf *コンパイル・実行
    :config
    (bind-key* "C-c c" 'compile)
    (leaf quickrun
      :ensure t
      :require t
      :bind*
      ("C-x x" . quickrun)))

  (leaf *ソースコード折りたたみ
    :config
    (bind-key* "C-\\" 'hs-toggle-hiding)
    (delight 'hs-minor-mode))

  (leaf *git
    :config
    (leaf magit
      :ensure t
      :require t
      :setq
      (vc-handled-backends . '())
      :setq-default
      (magit-auto-revert-mode . nil)
      :bind
      ("C-x g" . magit-status))

    (leaf git-gutter
      :ensure t
      :require t
      :delight t
      :config
      (global-git-gutter-mode t)))

  (leaf projectile
    :ensure t
    :delight
    :setq
    (projectile-mode-line . '(:eval (format "PJ[%s]" (projectile-project-name))))
    :config
    (projectile-mode t)
    )
  
  (leaf yasnippet
    :ensure t
    :require t
    :delight yas-minor-mode
    :setq
    (yas-snippet-dirs . '("~/.emacs.d/mysnippets"
                        "~/.emacs.d/yasnippets"))
    :custom
    (yas-alias-to-yas/prefix-p . nil)
    :bind
    (:yas-minor-mode-map
     ("C-x i e" . yas-expand)
     ("C-x i i" . yas-insert-snippet)
     ("C-x i n" . yas-new-snippet)
     ("C-x i v" . yas-visit-snippet-file)
     ("C-x i l" . yas-describe-tables)
     ("C-x y" . yas-insert-snippet))
    (:yas-keymap
     ("<tab>" . nil)
     ("C-<tab>" . nil))
    :config
    (yas-global-mode t))

  (leaf company
    :ensure t
    :require t
    :delight t
    :after yasnippet
    :defvar
    company-backends company-mode/enable-yas company-search-map
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
    :setq
    (company-backends . (mapcar #'company/backend-yasnippet company-backends))
    :config
    (global-company-mode t)
    (add-to-list 'company-backends 'company-files)
    (leaf company-box
      :ensure t
      :require t
      :hook
      (company-mode . company-box-mode)))

  (leaf flycheck
    :ensure t
    :require t
    :custom
    (global-flycheck-mode . t))

  (leaf lsp-mode
    :ensure t
    :require t
    :commands lsp
    :after company
    :defvar company-backends
    :custom
    (lsp-prefer-flymake . nil)
    (lsp-enable-snippet . t)
    (lsp-enable-indentation . nil)
    (lsp-docmuent-sync-method . 'incremental)
    (lsp-inhibit-message . t)
    (create-lockfiles . nil)
    :bind
    ("C-l" . nil)
    ("C-l C-l" . lsp)
    ("C-l d" . lsp-goto-definition)
    ("C-l f" . lsp-format-buffer)
    ("C-l h" . lsp-describe-definition)
    ("C-l l" . lsp-lens-mode)
    ("C-l r" . lsp-rename)
    ("C-l <f5>" . lsp-restart-workspace)
    :hook
    (prog-major-mode . lsp-prog-major-mode-enable)
    :config
    (leaf lsp-ui
      :ensure t
      :require t
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
      :after company lsp-mode lsp-ui yasnippet
      :commands company-lsp
      :custom
      (company-lsp-cache-candidates . nil)
      (company-lsp-async . t)
      (company-lsp-enable-recompletion . t)
      (company-lsp-enable-snippet . t)
      :init
      (push 'company-lsp company-backends)))
  )

(leaf *モード
  :config
  (leaf cc-mode
    :mode
    ("\\.c\\'" "\\.h\\'" . c-mode)
    ("\\.cpp\\'" "\\.cxx\\'" "\\.hpp\\'" "\\.hxx\\'" . c++-mode)
    :setq
    (c-default-style . "strustrup")
    (c-auto-newline . t)
    (electric-pair-mode . t)
    :config
    (define-auto-insert "\\.cpp$" "cpp-template.cpp")
    (leaf clang-format
      :config
      (defun set-hook-after-save-clang-format ()
        (add-hook 'after-save-hook 'clang-format-buffer t t)))
    (leaf ccls
      :ensure t
      :after lsp-mode
      :when
      (file-directory-p "/usr/local/bin/ccls")
      :custom
      (ccls-executable . "/usr/local/bin/ccls")
      (ccls-sem-highlight-method . 'font-lock)
      (ccls-use-default-rainbow-sem-highlight . t)
      :hook
      ((c-mode c++-mode objc-mode) . (lambda  () (require 'ccls) (lsp))))
    :hook
    (cc-mode . (lsp company-mode flycheck-mode hs-minor-mode))
    ((c-mode c++-mode) . (set-hook-after-save-clang-format)))

  (leaf *rust
    :config
    (leaf rustic
      :mode
      ("\\.rs\\'" . rustic-mode)
      :config
      (leaf racer)
      :hook
      (rustic-mode . (lsp company-mode flycheck-mode hs-minor-mode))))

  (leaf emacs-lisp-mode
    :setq
    (flycheck-disabled-checkers . '(emacs-lisp-checkdoc))
    :config
    (leaf flycheck-package
      :after flycheck
      :ensure t
      :require t
      :config
      (flycheck-package-setup))
    (leaf eldoc
      :ensure t
      :hook
      (emacs-lisp-mode . (ielm-mode)))
    (leaf elisp-slime-nav
      :ensure t
      :hook
      (emacs-lisp-mode . (elisp-slime-nav)))
    :hook
    (emacs-lisp-mode . (company-mode flycheck-mode hs-minor-mode)))

  (leaf vue-mode
    :ensure t
    :mode
    "\\.vue\\'"
    :config
    (leaf add-node-modules-path
      :ensure t)
    (flycheck-add-mode 'javascript-eslint 'vue-mode)
    (flycheck-add-mode 'javascript-eslint 'vue-html-mode)
    (flycheck-add-mode 'javascript-eslint 'css-mode)
    :hook
    (vue-mode . (lsp company-mode flycheck-mode hs-minor-mode add-node-module-path))
    )

  (leaf powershell
    :ensure t
    :mode
    ("\\.ps1\\'" "\\.psm1\\'" "\\.psd1\\'")
    :interpreter
    "C:/windows/system32/WindowsPowerShell/v1.0/powershell.exe")

  (leaf java-mode
    :mode
    "\\.java\\'"
    :config
    (leaf lsp-java
      :ensure t
      :require t
      :after lsp cc-mode)
    :hook
    (java-mode . (lsp company-mode flycheck-mode hs-minor-mode)))

  (leaf org
    :ensure t
    :mode
    "\\.org\\'"
    :bind
    ("C-o" . nil)
    ("C-o c" . org-capture)
    ("C-o a" . org-agenda)
    ("C-o b" . org-iswitchb)
    ("C-o l" . org-store-link)
    :init
    (setq org-agenda-directory "~/Documents/org/todo")
    (setq org-agenda-files '("~/Documents/org/todo/todo.org"))
    :setq
    (org-directory . "~/Documents/org")
    (org-default-notes-file . "note.org")
    (org-todo-keywords . '((sequence "TODO(t)" "Doing(i)" "Waiting(w)" "|" "DONE(d)" "CANCEL(c)")))
    (org-clock-clocktable-default-properties . '(:maxlevel 4 :scope tree))
    (org-log-done . 'time)
    (org-hide-leading-stars . t)
    (org-startup-indented . t)
    (org-return-follows-link . t)
    (org-capture-templates . '(("m"
                                "memo"
                                entry
                                (file+headline (concat org-directory "/note.org") "MEMO")
                                "* %U%?\n\n%a\n%F\n"
                                :empty-lines-after 1)
                               ("t"
                                "TODO"
                                entry
                                (file+headline (concat org-agenda-directory "/todo.org") "InBox")
                                "** TODO %T %? \n Entered on %U %i \n"
                                :empty-lines-after 1)))
    (system-time-locale . "C")
    :config
    (define-auto-insert "\\.org$" "org-template.org")
    (leaf org-table-sticky-header
      :ensure t
      :hook
      (org-mode-hook . org-table-sticky-header-mode)))
      
  (leaf csv-mode
    :ensure t
    :mode
    "\\.csv\\'")

  (leaf markdown-mode
    :ensure t
    :mode
    "\\.markdown\\'"
    "\\.md\\'")

  (leaf yaml-mode
    :ensure t
    :mode
    "\\.yaml\\'")

  (leaf logview
    :ensure t
    :mode
    "\\.log\\'")

  (leaf sql
    :ensure t
    :mode
    "\\.sql\\'"
    "\\.ddl\\'"
    :setq
    (sql-indent-offset . 4)
    (indent-tabs-mode . nil)
    :config
    (leaf sql-indent
      :ensure t
      :config
      (load-library "sql-indent"))
    (leaf sql-complete
      :ensure t
      :config
      (load-library "sql-complete"))
    (leaf sqltransform
      :ensure t
      :config
      (load-library "sqltrasform"))
    (sql-set-product "postgres"))

  (leaf restclient
    :ensure t
    :mode
    "\\.http\\'"
    :setq
    (restclient-log-requeset . t)
    (restclient-same-buffer-response . t)
    :config
    (leaf company-restclient
      :ensure t
      :require t
      :after company)
)  )

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


(leaf *外部設定ファイルの読み込み
  :config
  (setq external-conf-directory "~/.emacs.d/conf")
  (leaf init-loader
    :ensure t
    :when
    (file-directory-p external-conf-directory)
    :defvar
    init-loader-show-log-after-init
    :setq
    (init-loader-show-log-after-init . 'error-only)
    :config
    (init-loader-load external-conf-directory))
  )

