;; -*- lexical-binding: t; -*-
;; Emacs comes with package.el for installing packages.
;; Try M-x list-packages to see what's available.
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package all-the-icons)
(use-package avy)
(use-package catppuccin-theme)
(use-package almost-mono-themes
  :config
  ;; (load-theme 'almost-mono-black t)
  ;; (load-theme 'almost-mono-gray t)
  (load-theme 'almost-mono-cream t)
  ;; (load-theme 'almost-mono-white t)
  )
(use-package company)
(use-package company-lua)
(use-package doom-themes)
(use-package hl-todo)
(use-package ligature)
(use-package rainbow-delimiters)
(use-package undo-fu-session)
(use-package yasnippet-snippets
  :config (yas-minor-mode))

(use-package tree-sitter
  :hook (java-mode . tree-sitter-mode)
  :hook (java-mode . tree-sitter-hl-mode))
(use-package tree-sitter-langs)

(defun set-sw ()
  (make-local-variable 'evil-shift-width)
  (setq evil-shift-width 3))

(use-package haskell-mode
  :hook (haskell-mode . set-sw))

(use-package ivy :config (ivy-mode))
(use-package counsel)
(use-package ivy-rich :config (ivy-rich-mode))

(use-package markdown-mode
  :hook
  (markdown-mode . set-sw))

(use-package which-key
  :config
  (which-key-mode)
  (setq which-key-idle-delay 0.3))

(use-package doom-modeline
  :config (doom-modeline-mode t))

(use-package recentf
  :config (recentf-mode 1)
          (setq recentf-max-menu-items 25)
          (global-set-key "\C-x\ \C-r" 'counsel-recentf))

(defun org-syntax-table-modify ()
  "Modify `org-mode-syntax-table' for the current org buffer."
  (modify-syntax-entry ?< "." org-mode-syntax-table)
  (modify-syntax-entry ?> "." org-mode-syntax-table))
;; (add-hook 'evil-org-mode-hook #'org-syntax-table-modify)

(use-package evil-org
  :hook (evil-org-mode . org-syntax-table-modify)
  ;; :config
  ;; (add-hook 'org-mode-hook (lambda () (evil-org-mode 1)))
)

(use-package org
  :hook (org-mode . evil-org-mode)
  :hook (org-mode . org-indent-mode)
  )

;; (define-key org-mode-map (kbd "TAB") 'org-cycle)
;; (add-hook 'org-mode-hook (lambda () (define-key org-mode-map (kbd "TAB") #'org-cycle)))

(use-package evil
  :init (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-redo)

  (define-key evil-normal-state-map (kbd "z y")
    (lambda () (interactive)
      (evil-use-register ?+)
      (call-interactively 'evil-yank)))

  (define-key evil-normal-state-map (kbd "z p") "\"+p")
  (define-key evil-normal-state-map (kbd "z j") 'evil-avy-goto-char)
  (define-key evil-normal-state-map (kbd "z x") 'align-regexp)
  (define-key evil-normal-state-map (kbd "z X")
    (lambda () (interactive)
      (setq current-prefix-arg '(t))
      (call-interactively 'align-regexp)))

  (define-key evil-normal-state-map (kbd "z e") ":(org-table-export \"tmp.tsv\" \"orgtbl-to-tsv\")")

  ;; (define-key evil-normal-state-map (kbd "C-a") (kbd ":s/(/z"))
  ;; (define-key evil-visual-state-map (kbd ";") (kbd ":'<,'>s/d/z"))

  (define-key evil-insert-state-map (kbd "C-e") 'yas-expand)
  (define-key evil-insert-state-map (kbd "C-j") 'yas-next-field-or-maybe-expand)
  (define-key evil-insert-state-map (kbd "C-k") 'yas-prev-field)

  (define-key evil-normal-state-map (kbd "M-h") "gT")
  (define-key evil-normal-state-map (kbd "M-l") "gt")
  ;; (define-key evil-insert-state-map (kbd "S-SPC") "_")

  :hook
  (sh-mode . sw-2)
  (elixir-mode . sw-2)
  ;;(add-hook 'sh-mode-hook (lambda () (setq evil-shift-width 2)))
  )

(defun sw-2 () (setq evil-shift-width 2))
(defun sw-4 () (setq evil-shift-width 4))

(use-package company
  :config (add-hook 'after-init-hook 'global-company-mode))

(use-package ligature
  :load-path "path-to-ligature-repo"
  :config
  ;; Enable all JetBrains Mono ligatures in programming modes
  (ligature-set-ligatures 't '(  "-~" "-<<" "-<"  "->" "->>" "-->" "///" "/=" "/=="
                                       "/>" "//" "/*" "*>" "***" "*/" "<-" "<<-" "<=>" "<=" "<|" "<||"
                                       "<|||" "<|>" "<:" "<>" "<-<" "<<<" "<==" "<<=" "<=<" "<==>" "<-|"
                                       "<<" "<~>" "<=|" "<~~" "<~" "<$>" "<$" "<+>" "<+" "</>" "</" "<*"
                                       "<*>" "<->" "<!--" ":>" ":<" ":::" "::" ":?" ":?>" ":=" "::=" "=>>"
                                       "==>" "=/=" "=!=" "=>"  "=:="  "!==" "!!" "!=" ">]" ">:"
                                       ">>-" ">>=" ">=>" ">>>" ">-" ">=" "&&&" "&&" "|||>" "||>" "|>" "|]"
                                       "|}" "|=>" "|->" "|=" "||-"  "||=" "||" ".." ".?" ".=" ".-" "..<"
                                       "..." "+++" "+>" "++" "[||]" "[<" "[|" "{|" "??" "?." "?=" "?:" "##"
                                       "###" "####" "#[" "#{" "#=" "#!" "#:" "#_(" "#_" "#?" "#(" ";;" "_|_"
                                       "__" "~~" "~~>" "~>" "~-" "~@" "$>" "^=" "]#"))
  ;; "---"  "--" "===" "==" "-|" "|-"
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  ); (global-ligature-mode t)


;;;;; editing

;; Key binding to use "hippie expand" for text autocompletion
;; http://www.emacswiki.org/emacs/HippieExpand
(global-set-key (kbd "M-/") 'hippie-expand)

;; Lisp-friendly hippie expand
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

(save-place-mode 1)
(setq save-place-file (concat user-emacs-directory "places"))

(show-paren-mode 1)

(setq-default indent-tabs-mode nil)
setq-default tab-width 4)

(electric-indent-mode nil)

(setq-default
  sh-basic-offset 2
  sh-indentation 2
  lua-indent-level 4
  )

(add-hook 'java-mode-hook (lambda () (setq c-basic-offset 4)))

;;;;; appearance

(add-to-list 'default-frame-alist
             '(font . "JetBrainsMono Nerd Font-14.5"))
;; (set-face-attribute 'default nil :height 140)

;; (setq catppuccin-flavor 'latte) ;; or 'frappe, 'macchiato, or 'mocha
;; (catppuccin-reload)
;; (load-theme 'catppuccin :no-confirm)
;; (load-theme 'doom-solarized-light :no-confirm)

(setq scroll-step 1)
(menu-bar-mode -1)
(line-number-mode -1)
(setq display-line-numbers-type 'relative) ; absolute
(global-display-line-numbers-mode t)

(tooltip-mode -1)                 ;; disable tooltips
(tool-bar-mode -1)                ;; the toolbar is pretty ugly
(scroll-bar-mode -1)              ;; disable visible scrollbar
(blink-cursor-mode 0)             ;; turn off blinking cursor. distracting!
(setq create-lockfiles nil)       ;; no need for ~ files when editing
(fset 'yes-or-no-p 'y-or-n-p)     ;; changes all yes/no questions to y/n type
(setq inhibit-startup-message t)  ;; go straight to scratch buffer on startup
(setq ring-bell-function 'ignore) ;; turn off audible bell


;;;;; misc

(desktop-save-mode 1)

(org-babel-do-load-languages 'org-babel-load-languages
                             '((shell . t)
                               (lua . t)
                               (python . t)
                               (C . t)))
(setq org-link-descriptive nil)

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

;;(setq custom-file (concat user-emacs-directory "custom.el"))
;; (load custom-file 'noerror)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms '((".*" "~/.emacs.d/backups" t)))
 '(backup-directory-alist '(("." . "~/.emacs.d/backups/")))
 '(c-basic-offset 8)
 '(calendar-week-start-day 6)
 '(coffee-tab-width 2)
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 1)
 '(custom-safe-themes
    '("80214de566132bf2c844b9dee3ec0599f65c5a1f2d6ff21a2c8309e6e70f9242" default))
 '(electric-indent-mode t)
 '(electric-pair-mode t)
 '(global-ligature-mode t)
 '(global-undo-tree-mode t)
 '(lisp-body-indent 2)
 '(lisp-indent-offset 2)
 '(org-agenda-files '("/home/taki/.notes/plan.org"))
 '(org-agenda-span 'fortnight)
 '(org-agenda-start-on-weekday 6)
 '(org-confirm-babel-evaluate nil)
 '(org-edit-src-content-indentation 0)
 '(org-html-htmlize-font-prefix "org-")
 '(org-html-htmlize-output-type 'css)
 '(org-list-allow-alphabetical t)
 '(package-selected-packages
    '(almost-mono-themes haskell-mode auto-package-update elixir-mode tree-sitter-langs tree-sitter java-snippets evil-org markdown-mode counsel elm-mode zig-mode racket-mode avy magit tagedit smooth-scrolling smooth-scroll htmlize go-mode undo-fu-session underline-with-char hl-todo gnuplot gnuplot-mode yasnippet-snippets http company-lua epresent w3m org evil ligature catppuccin-theme clj-refactor cider-hydra company cider clojure-mode which-key treemacs-projectile setup rainbow-delimiters paredit lsp-treemacs lsp-ivy ivy-rich doom-themes doom-modeline counsel-projectile all-the-icons))
 '(select-enable-clipboard nil)
 '(select-enable-primary nil)
 '(tab-width 4)
 '(tex-fontify-script nil)
 '(truncate-lines t)
 '(undo-fu-session-global-mode t)
 '(undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
 '(use-package-always-ensure t)
 '(x-select-enable-clipboard-manager nil)
 '(yas-global-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
