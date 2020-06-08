
;;; Three journal bindings I got from a blog somewhere

(map! :leader
      (:prefix ("j" . "journal") ;; org-journal bindings
        :desc "Create new journal entry" "j" #'org-journal-new-entry
        :desc "Open previous entry" "p" #'org-journal-open-previous-entry
        :desc "Open next entry" "n" #'org-journal-open-next-entry
        :desc "Search journal" "s" #'org-journal-search-forever
        :desc "Read journal" "r" #'org-journal-open-current-journal-file)
)

;; The built-in calendar mode mappings for org-journal
;; conflict with evil bindings
(map!
 (:map calendar-mode-map
   :n "o" #'org-journal-display-entry
   :n "p" #'org-journal-previous-entry
   :n "n" #'org-journal-next-entry
   :n "O" #'org-journal-new-date-entry))

;; Local leader (<SPC m>) bindings for org-journal in calendar-mode
;; I was running out of bindings, and these are used less frequently
;; so it is convenient to have them under the local leader prefix
(map!
 :map (calendar-mode-map)
 :localleader
 "w" #'org-journal-search-calendar-week
 "m" #'org-journal-search-calendar-month
 "y" #'org-journal-search-calendar-year)

;;; _Y _P - Yank and paste to/from ~/.editor.tmp
(defun write-region-to-editor-tmp (beg end)
  "Write the currently selected region to ~/.editor.tmp."
  (interactive "rP")
  (write-region beg end "~/.editor.tmp")
  (evil-exit-visual-state)
)

(defun insert-file-editor-tmp ()
  "Paste in from ~/.editor.tmp."
  (interactive)
  (evil-open-below 1)
  (insert-file "~/.editor.tmp")
  (evil-force-normal-state)
)

(map! :v "_Y" #'write-region-to-editor-tmp)
(map! :n "_P" #'insert-file-editor-tmp)
