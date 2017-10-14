(defvar eww-disable-colorize t)
(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))

(defun eww-disable-color ()
  "eww で文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t)
  (eww-reload))

(defun eww-enable-color ()
  "eww で文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil)
  (eww-reload))

(defun eww-mode-hook--rename-buffer ()
  "ewwを複数バッファで起動するときにバッファの名前を変更する"
  (rename-buffer "eww" t))

(defun eww-search (term)
  "検索結果をハイライト"
  (interactive "sSearch terms: ")
  (setq eww-hl-search-word term)
  (eww-browse-url (concat eww-search-prefix term)))

(defun browse-url-with-eww ()
  "現在カーソルがあるURL文字列をewwで開く"
  (interactive)
  (let ((url-region (bounds-of-thing-at-point 'url)))
    ;; url
    (if url-region
        (eww-browse-url (buffer-substring-no-properties (car url-region)
                                                        (cdr url-region))))
    ;; org-link
    (setq browse-url-browser-function 'eww-browse-url)
    (org-open-at-point)))

(defun eww-disable-images ()
  "eww で画像表示させない"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image-alt)
  (eww-reload))
(defun eww-enable-images ()
  "eww で画像表示させる"
  (interactive)
  (setq-local shr-put-image-function 'shr-put-image)
  (eww-reload))
(defun shr-put-image-alt (spec alt &optional flags)
  (insert alt))
(defun eww-mode-hook--disable-image ()
  (setq-local shr-put-image-function 'shr-put-image-alt))

(use-package eww
  :bind
  (("C-c w" . eww-search)
   ("C-c u" . browse-url-with-eww))

  :config
   (bind-keys :map eww-mode-map
             ("r" . eww-reload)
             ("w" . eww-copy-page-url)
             ("p" . scroll-down)
             ("n" . scroll-up))
 
  ;; 検索エンジンをGoogleに設定
  (setq eww-search-prefix "http://www.google.co.jp/search?q=")
  
  (bind-key "r" 'eww-reload eww-mode-map)
  (advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
  (advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
  ;; 複数バッファで起動する設定
  (add-hook 'eww-mode-hook 'eww-mode-hook--rename-buffer)
  ;; 現在のURLを外部ブラウザで開く
  (setq browse-url-generic-program (executable-find "firefox"))
  (setq shr-external-browser 'browse-url-generic)
  ;; デフォルトでは画像を非表示
                                        ; (add-hook 'eww-mode-hook 'eww-mode-hook--disable-image)
  (use-package ace-link
    :config
    (eval-after-load 'eww '(define-key eww-mode-map "f" 'ace-link-eww))
    (ace-link-setup-default))
  )
