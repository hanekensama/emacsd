(use-package maxframe
  :ensure t   
  )

(defun start-e2wm()
  (interactive)
  (maximize-frame)
  (sleep-for 0.1) ; これがないと画面分割の割合がバグる
  (e2wm:start-management)
  )

(defun stop-e2wm()
  (interactive)
  (e2wm:stop-management)
  (restore-frame)
  )

(use-package e2wm
  :ensure t
  :defer t
  )

(bind-key "M-+" 'start-e2wm)
(bind-key "M-_" 'stop-e2wm)
