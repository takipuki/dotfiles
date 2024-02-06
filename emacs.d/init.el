;; -*- lexical-binding: t; -*-
;; Emacs comes with package.el for installing packages.
;; Try M-x list-packages to see what's available.
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; setup.el provides a macro for configuration patterns
;; it makes package installation and config nice and tidy!
;; https://www.emacswiki.org/emacs/SetupEl
(if (package-installed-p 'setup)
    nil
  (if (memq 'setup package-archive-contents)
      nil
    (package-refresh-contents))
  (package-install 'setup))
(require 'setup)

;; my configs
(setq evil-want-C-i-jump nil)
(require 'evil)
(evil-mode 1)
(evil-set-undo-system 'undo-redo)

(setq scroll-step 1)
(menu-bar-mode -1)

(setq catppuccin-flavor 'latte) ;; or 'frappe, 'macchiato, or 'mocha
(load-theme 'catppuccin :no-confirm)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

(set-frame-font "JetBrainsMono Nerd Font-14.5" nil t)
(use-package ligature
  :load-path "path-to-ligature-repo"
  :config
  ;; Enable all JetBrains Mono ligatures in programming modes
  (ligature-set-ligatures 't '("-|" "-~" "---" "-<<" "-<" "--" "->" "->>" "-->" "///" "/=" "/=="
                                       "/>" "//" "/*" "*>" "***" "*/" "<-" "<<-" "<=>" "<=" "<|" "<||"
                                       "<|||" "<|>" "<:" "<>" "<-<" "<<<" "<==" "<<=" "<=<" "<==>" "<-|"
                                       "<<" "<~>" "<=|" "<~~" "<~" "<$>" "<$" "<+>" "<+" "</>" "</" "<*"
                                       "<*>" "<->" "<!--" ":>" ":<" ":::" "::" ":?" ":?>" ":=" "::=" "=>>"
                                       "==>" "=/=" "=!=" "=>" "===" "=:=" "==" "!==" "!!" "!=" ">]" ">:"
                                       ">>-" ">>=" ">=>" ">>>" ">-" ">=" "&&&" "&&" "|||>" "||>" "|>" "|]"
                                       "|}" "|=>" "|->" "|=" "||-" "|-" "||=" "||" ".." ".?" ".=" ".-" "..<"
                                       "..." "+++" "+>" "++" "[||]" "[<" "[|" "{|" "??" "?." "?=" "?:" "##"
                                       "###" "####" "#[" "#{" "#=" "#!" "#:" "#_(" "#_" "#?" "#(" ";;" "_|_"
                                       "__" "~~" "~~>" "~>" "~-" "~@" "$>" "^=" "]#"))
  ;; Enables ligature checks globally in all buffers. You can also do it
  ;; per mode with `ligature-mode'.
  ); (global-ligature-mode t)

;(load-file "~/.emacs.d/myfuncs.el")
(require 'w3m-load)
(require 'tagedit)
(tagedit-mode 1)

(org-babel-do-load-languages 'org-babel-load-languages
                             '((shell . t)
                               (lua . t)
                               (C . t)))

(add-hook 'after-init-hook 'global-company-mode)


;; All other features are loaded one by one from
;; the customizations directory. Read those files
;; to find out what they do.
(add-to-list 'load-path "~/.emacs.d/customizations")

(defvar addons
  '("ui.el"
    "navigation.el"
    "projects.el"
    "git.el"
    "filetree.el"
    "editing.el"
    "elisp-editing.el"
    "setup-clojure.el"
    "setup-js.el"
    "shell-integration.el"))

(dolist (x addons)
  (load x))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file 'noerror)
