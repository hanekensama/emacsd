(auto-install 'powerline)

(use-package powerline
  :config
  (powerline-default-theme)
  (set-face-attribute 'mode-line nil
                      :foreground "#fff"
                      :background "#0000ff"
                      :box nil)
  (set-face-attribute 'powerline-active1 nil
                      :foreground "#fff"
                      :background "#00aa00"
                      :inherit 'mode-line)
  (set-face-attribute 'powerline-active2 nil
                      :foreground "#fff"
                      :background "#000000"
                      :inherit 'mode-line)
  )
