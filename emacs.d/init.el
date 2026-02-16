(require 'package)
(setq-default package-archives '(("melpa" . "https://melpa.org/packages/")
                                 ("melpa-stable" . "https://stable.melpa.org/packages/")
                                 ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(require 'use-package-ensure)
(setq-default use-package-always-ensure t)

(use-package auto-package-update
  :config
  (setq-default auto-package-update-delete-old-versions t)
  (setq-default auto-package-update-hide-results t)
  (auto-package-update-maybe))


;; utils ---------------------------------------------------------------
(use-package evil-org
  :hook (org-mode . evil-org-mode))

(use-package ivy
  :config (ivy-mode 1))
(use-package ivy-rich
  :after (ivy)
  :config (ivy-rich-mode 1))
(use-package counsel
  :after (ivy))

(use-package recentf
  :after (counsel)
  :config
  (recentf-mode 1)
  (setq-default recentf-max-menu-items 25))


;; editing -------------------------------------------------------------
(use-package undo-tree
  :config
  (global-undo-tree-mode))

(use-package evil
  :init (setq-default evil-want-C-i-jump nil) ; don't know yet
  :config
  (evil-mode 1)
  (evil-set-undo-system 'undo-tree))

(defadvice align-regexp (around align-regexp-with-spaces activate)
  (let ((indent-tabs-mode nil))
    ad-do-it))


;; completion ----------------------------------------------------------
(use-package company
  :config
  (setq-default company-idle-delay 0)
  (global-company-mode -1))

(abbrev-mode)

(setq show-paren-style 'paren)
(setq blink-matching-paren t)

;; lsp -----------------------------------------------------------------
(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs)


;; hooks ---------------------------------------------------------------
(add-hook 'emacs-lisp-mode-hook
          (lambda () (setq-local indent-tabs-mode nil
                                 tab-width 2
                                 emacs-lisp-indent-offset 2
                                 evil-shift-width tab-width)))
(add-hook 'c++-mode-hook
          (lambda ()
            (add-function
             :before-until (local 'tree-sitter-hl-face-mapping-function)
             (lambda (capture-name)
               (pcase capture-name
                 ("property" 'tree-sitter-hl-face:variable)
                 ("variable.special" 'tree-sitter-hl-face:type.builtin))))))

;; mappings ------------------------------------------------------------
(use-package general
  :config
  (general-define-key
   :states '(normal)
   ", ;" "A;"

   "M-h" "gT"
   "M-l" "gt"

   "C-f" #'evil-scroll-down
   "C-b" #'evil-scroll-up

   "C-x C-r" #'counsel-recentf)

  (general-define-key
   :states '(normal visual)
   ", y" (lambda () (interactive)
           (evil-use-register ?+)
           (call-interactively 'evil-yank))
   ", p" "\"+p")

  (general-define-key
   :states '(insert)
   "C-c" ""))


;; housekeeping --------------------------------------------------------
(setq-default custom-file "~/.emacs.d/custom.el")
(ignore-error file-missing (load-file custom-file))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(column-number-mode)
(global-display-line-numbers-mode)

(use-package tao-theme
  :config
  (setq-default
   tao-theme-use-boxes        nil
   tao-theme-use-sepia        nil
   tao-theme-sepia-depth      10
   tao-theme-sepia-saturation 1.03))
(load-theme 'monotropic)

(set-face-attribute 'default nil :height 140)
(set-face-attribute 'mode-line nil :height 140)
(set-face-italic 'font-lock-comment-face nil)
(set-face-italic 'font-lock-string-face nil)
(set-face-italic 'font-lock-type-face nil)
(set-frame-font "Jetbrains Mono" nil t)

(auto-save-mode -1)
(save-place-mode)

(setq-default
 scroll-step                       1
 scroll-conservatively             101
 truncate-lines                    t
 truncate-partial-width-windows    nil
 display-line-numbers-type         'relative
 inhibit-startup-screen            t
 select-enable-clipboard           nil

 indent-tabs-mode                  nil
 tab-width                         4
 c-basic-offset                    4
 c-default-style                   "linux"
 c++-indent-offset                 4

 undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))
 backup-by-copying                 t ;; disable symlinks
 backup-directory-alist            `(("." . "~/.emacs.d/backup"))
 auto-save-file-name-transforms    `((".*" "~/.emacs.d/autosave" t))
 delete-old-versions               t
 kept-new-versions                 6
 kept-old-versions                 2
 version-control                   t ;; use versioned backups
 )

