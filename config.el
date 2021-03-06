;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package! evil-cleverparens
  :hook (evil-local-mode . evil-cleverparens-mode))

(add-hook 'org-mode-hook 'turn-on-auto-fill)

(setq evil-escape-key-sequence "fd")

(setq lsp-clients-angular-language-server-command
  '("node"
    "/usr/local/lib/node_modules/@angular/language-server"
    "--ngProbeLocations"
    "/usr/local/lib/node_modules"
    "--tsProbeLocations"
    "/usr/local/lib/node_modules"
    "--stdio"))

(map! :leader
      (:prefix-map ("j" . "jump")
       :desc "avy char" "j" #'avy-goto-char
       :desc "avy line" "l" #'avy-goto-line))

(map! :leader
      :prefix "w"
      :desc "split window vertically" "/" #'split-window-right
      :desc "split window horizontally" "-" #'split-window-below)

(map! :leader
      (:prefix ("e" . "flycheck")
       :desc "flycheck clear" "c" #'flycheck-clear
       :desc "flycheck buffer" "b" #'flycheck-buffer
       :desc "flycheck error list" "l" #'flycheck-list-errors
       :desc "flycheck next error" "n" #'flycheck-next-error
       :desc "flycheck previous error" "p" #'flycheck-previous-error))

(setq confirm-kill-emacs nil
      projectile-project-search-path '("~/projects")
      lsp-log-info nil                       ;; set to t for debugging lsp
      read-process-output-max (* 1024 1024)) ;; 1mb

(setq typescript-indent-level 2
      lsp-ui-sideline-enable nil)

(setq org-latex-packages-alist '(("" "siunitx" t)))

;; if the cider repl history does not work
;; dont like these actions and they conflict with cider repl
;; (global-set-key (kbd "C-k") nil)
;; (global-set-key (kbd "C-j") nil)

;;clojure configs
(define-key evil-insert-state-map (kbd "C-k") nil)
(with-eval-after-load "cider-mode"
  (define-key evil-emacs-state-map (kbd "<up>") 'cider-repl-previous-input)
  (define-key cider-repl-mode-map (kbd "C-k") 'cider-repl-previous-input)
  (define-key cider-repl-mode-map (kbd "C-j") 'cider-repl-next-input)
  (define-key cider-repl-mode-map (kbd "<up>") 'cider-repl-previous-input)
  (define-key cider-repl-mode-map (kbd "<down>") 'cider-repl-next-input))
