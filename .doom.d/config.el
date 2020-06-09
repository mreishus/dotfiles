;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Check out this guy's:
;; https://tecosaur.github.io/emacs-config/config.html#intro

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
;;
;; (setq doom-font (font-spec :family "Iosevka Term" :size 20 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq-default
  uniquify-buffer-name-style 'forward            ; Uniquify buffer names
  scroll-margin 3                                ; Add a margin when scrolling vertically
  show-trailing-whitespace t                     ; Display trailing whitespaces
)
(setq
  centaur-tabs-style "wave"
  doom-font (font-spec :family "Iosevka Term" :size 16)
  doom-big-font (font-spec :family "Iosevka Term" :size 26)
  doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 16)
  org-catch-invisible-edits "show-and-error"
  org-journal-file-type 'monthly
  org-log-done 'time    ; Add timestamp when closing t0d0s
  projectile-project-search-path '("~/h20/dev/" "~/h20/edu/" "~/Sync/" "~/h20/txt/" "~/h20/misc")
  truncate-string-ellipsis "…"
  which-key-idle-delay 0.5 ; Help me faster
)

(when (string= (system-name) "atlas")
  (setq
    doom-font (font-spec :family "Iosevka Term" :size 20)
    doom-big-font (font-spec :family "Iosevka Term" :size 36)
    doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 20)
  )
)

;; Theme
(setq doom-theme 'doom-wilmersdorf)
;; Second fav
;; (setq doom-theme 'doom-dark+
;;      doom-dark+-blue-modeline t
;; )

;; Other possible themes
;; (setq
;;  doom-one-brighter-comments t
;;  doom-one-comment-bg t
;;  doom-one-brighter-modeline t
;;  doom-theme 'doom-one)
;; (setq doom-theme 'doom-tomorrow-night)
;;(setq doom-theme 'doom-city-lights)
;; See more themes here: https://github.com/hlissner/emacs-doom-themes/tree/screenshots#doom-one
;; (Some themes don't have screenshots)

; Turn off Solaire Mode
; This changes background color based on buffer type
(after! solaire-mode
  (solaire-global-mode -1))

; Force BG color = black. Turn off highlighted current line
(custom-set-faces
  '(default ((t (:background "#111111"))))
  '(hl-line ((t (:background "#111111"))))
  '(org-block ((t (:background "#222222"))))
  '(org-hide  ((t (:foreground "#111111"))))
 )

; I don't need "jk" to leave insert mode.
(setq evil-escape-unordered-key-sequence t)

(display-time-mode 1)                             ; Enable time in the mode-line
(display-battery-mode 1)                          ; On laptops it's nice to know how much power you have

;(setq +doom-dashboard-banner-file (expand-file-name "banner.png" doom-private-dir))

; Variable width font in markdown
(add-hook! (gfm-mode markdown-mode) #'mixed-pitch-mode)

;; Turn on snippet completion in python
;; This doesn't seem to work?
;; https://github.com/hlissner/doom-emacs/issues/3200
;; (after! python
;;   (set-company-backend! 'python-mode '(company-yasnippet ...)))
;; I don't know what to put in the ... section.
;; However, I can always use C-x C-s (remember: "excess") for snippet completion.

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


; If I want to disable smartparens
; (remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

(load! "+bindings")
(load! "+org")
