(use-package web-mode
  :ensure t
  :mode (".html?")
  :init
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mide-code-indent-offset 2)

  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-auto-expanding t)
  (setq web-mode-enable-css-colorization t)
  )
  
(use-package web-beautify
  :ensure t
  :commands (
    web-beautify-css
    web-beautify-css-buffer
    web-beautify-html
    web-beautify-html-buffer
    web-beautify-js
    web-beautify-js-buffer))

