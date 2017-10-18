(defun company--insert-candidate2 (candidate)
  (when (> (length candidate) 0)
    (setq candidate (substring-no-properties candidate))
    (if (eq (company-call-backend 'ignore-case) 'keep-prefix)
        (insert (company-strip-prefix candidate))
      (if (equal company-prefix candidate)
          (company-select-next)
        (delete-region (- (point) (length company-prefix)) (point))
        (insert candidate))
      )))

(defun company-complete-common2 ()
  (interactive)
  (when (company-manual-begin)
    (if (and (not (cdr company-candidates))
             (equal company-common (car company-candidates)))
        (company-complete-selection)
      (company--insert-candidate2 company-common))))

(use-package company
  :defer t
  
  :init
  (setq global-company-mode t)
  
  :config
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 2)
  (setq company-selection-wrap-around t)

  (bind-keys
   :map company-active-map
   ("M-n" . nil)
   ("C-n" . company-select-next)
   ("M-p" . nil)
   ("C-p" . company-select-previous)
   ("C-h" . nil)
   ("[tab]" . company-complete-common2)
   ("[backtab]" . company-select-previous)
   )
  
  (use-package irony
    :defer t
    :init
    (use-package company)
    (use-package company-irony)
    (add-hook 'cc-mode-hook 'irony-mode)
    (add-hook 'python-mode-hook 'irony-mode)
    (add-hook 'el-mode-hook 'irony-mode)
    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
    (add-to-list 'company-backends 'company-irony)

    :config
    (setq irony-lang-compile-option-alist
          (quote ((c++-mode . "c++ -std=c++14 -lstdc++")
                  (c-mode . "c"))))
    (defun ad-irony--lang-compile-option ()
      (defvar irony-lang-compile-option-alist)
      (let ((it (cdr-safe (assq major-mode irony-lang-compile-option-alist))))
        (when it (append '("-x") (split-string it "\s")))))
    (advice-add 'irony--lang-compile-option :override #'ad-irony--lang-compile-option)
    )

  )


