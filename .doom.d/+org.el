;;; +org.el --- Org mode settings                    -*- lexical-binding: t; -*-

;; Copyright (C) 2020  MMR

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/h20/org/")

; Turn on Word-Wrap in org mode (Insert newlines automatically). It's called ("auto fill" mode)
(add-hook! 'org-mode-hook 'turn-on-auto-fill);
; Variable width font, and pretty mode in org (unsure of what pretty mode does)
(add-hook! 'org-mode-hook #'+org-pretty-mode #'mixed-pitch-mode)

;; == org-journal begin ==

;; org-journal: skip carry over of previous days clocked entries when it is
;; under the drawer LOGBOOK.

(setq org-journal-skip-carryover-drawers (list "LOGBOOK"))

;; Start all new journals with title and folding options
(defun org-journal-file-header-func (time)
  "Custom function to create journal header."
  (concat
    (pcase org-journal-file-type
      (`daily "#+TITLE: Daily Journal\n#+STARTUP: showeverything")
      (`weekly "#+TITLE: Weekly Journal\n#+STARTUP: overview")
      (`monthly "#+TITLE: Monthly Journal\n#+STARTUP: overview")
      (`yearly "#+TITLE: Yearly Journal\n#+STARTUP: overview"))))

(setq org-journal-file-header 'org-journal-file-header-func)

;; To be used when integrating with capture
(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-min)))

;; == org-journal end ==

; Org capture templates - Add only one
;; (after! org
;;   (add-to-list 'org-capture-templates
;;                '("m" "Meeting" entry
;;                  (file+headline +org-capture-notes-file "Inbox")
;;                   "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
;; ))

;; Capture Templates - Define all
(after! org (setq org-capture-templates
'(
  ("t" "Personal todo" entry
    (file+headline +org-capture-todo-file "Inbox")
    "* TODO %?\n%i\n%a" :prepend t :clock-in t :clock-resume t)
  ("n" "Personal notes" entry
    (file+headline +org-capture-notes-file "Inbox")
    "* %u %?\n%i\n%a" :prepend t :clock-in t :clock-resume t)
  ("j" "Journal entry" entry (function org-journal-find-location)
    "* %(format-time-string org-journal-time-format)%^{Title}\n%i%?"
    :clock-in t :clock-resume t
  )
  ("m" "Meeting" entry
    (file+headline +org-capture-notes-file "Inbox")
    "* MEETING with %^{with} about %^{subject} :MEETING:\n%U" :clock-in t :clock-resume t)
  ("r" "Respond" entry (file+headline +org-capture-todo-file "Inbox")
    "* TODO Respond to %^{from} on %^{subject}\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t)

  ("p" "Templates for projects")
  ("pt" "Project-local todo" entry
    (file+headline +org-capture-project-todo-file "Inbox")
    "* TODO %?\n%i\n%a" :prepend t :clock-in t :clock-resume t)
  ("pn" "Project-local notes" entry
    (file+headline +org-capture-project-notes-file "Inbox")
    "* %U %?\n%i\n%a" :prepend t :clock-in t :clock-resume t)
  ("pc" "Project-local changelog" entry
    (file+headline +org-capture-project-changelog-file "Unreleased")
    "* %U %?\n%i\n%a" :prepend t :clock-in t :clock-resume t)

  ("o" "Centralized templates for projects")
  ("ot" "Project todo" entry #'+org-capture-central-project-todo-file
   "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil :clock-in t :clock-resume t)
  ("on" "Project notes" entry #'+org-capture-central-project-notes-file
   "* %U %?\n %i\n %a" :heading "Notes" :prepend t :clock-in t :clock-resume t)
  ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file
   "* %U %?\n %i\n %a" :heading "Changelog" :prepend t :clock-in t :clock-resume t)
)))
