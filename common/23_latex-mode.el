(use-package yatex
  :defer t
  :ensure t
  :mode (("\\.tex\\'" . yatex-mode)
         ("\\.ltx\\'" . yatex-mode)
         ("\\.cls\\'" . yatex-mode)
         ("\\.sty\\'" . yatex-mode)
         ("\\.clo\\'" . yatex-mode)
         ("\\.bbl\\'" . yatex-mode))
  :init
  (setq YaTeX-inhibit-prefix-letter t)
  (setq YaTeX-kanji-code nil)
  (setq YaTeX-latex-message-code 'utf-8)
  (setq YaTeX-use-AMS-LaTeX t)
  (setq YaTeX-dvi2-command-ext-alist
        '(("TeXworks\\|texworks\\|texstudio\\|mupdf\\|SumatraPDF\\|Preview\\|Skim\\|TeXShop\\|evince\\|okular\\|zathura\\|qpdfview\\|Firefox\\|firefox\\|chrome\\|chromium\\|Adobe\\|Acrobat\\|AcroRd32\\|acroread\\|pdfopen\\|xdg-open\\|open\\|start" . ".pdf")))
  (setq tex-command "platex -synctex=1")
  ;; (setq tex-command "pdflatex -synctex=1")
  (setq dvi2-command "xdvi")
  (setq bibtex-command "pbibtex")
  (setq dviprint-command-format "dvipdfmx")

  (add-hook 'yatex-mode-hook '(lambda () (auto-fill-mode -1))) ;; 自動で改行しない
  (add-hook 'yatex-mode-hook 'turn-on-reftex)
  (setq tab-width 4)
  )
