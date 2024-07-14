(setq! doom-leader-alt-key "M-SPC")
(map!
:nvi "M-p" #'scroll-other-window-down
:nvi "M-n" #'scroll-other-window
:after evil
:n "L" #'centaur-tabs-forward
:n "H" #'centaur-tabs-backward
:nvi "M-SPC" #'doom-leader-alt-key
:after lsp-ui
:nvi "C-l" #'lsp-ui-doc-focus-frame
 )

(setq doom-theme 'doom-vibrant)
;; (setq doom-theme 'catppuccin)
;; (setq catppuccin-flavor 'frappe) ;; or 'latte, 'frappe 'macchiato, or 'mocha

(set-frame-parameter nil 'alpha-background 100)
(add-to-list 'default-frame-alist '(alpha-background . 100))

(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 14
:weight 'normal))

(setq display-line-numbers-type 'relative)

;; (after! lsp-ui
;;   (setq lsp-ui-doc-enable t
;;         lsp-ui-doc-position 'at-point
;;         lsp-lens-enable t
;;         lsp-ui-sideline-enable t
;;         lsp-ui-doc-include-signature t
;;         lsp-headerline-breadcrumb-enable t
;;         lsp-signature-function 'lsp-signature-posframe
;;         lsp-modeline-code-actions-enable t
;;         lsp-completion-show-detail t
;;         lsp-completion-show-kind t
;;         lsp-signature-render-documentation t
;;         ;; lsp-ui-doc-max-height 15
;;         lsp-ui-doc-max-width 100)
;;   )

(use-package! centaur-tabs
:config
(setq centaur-tabs-style "wave")
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-gray-out-icons 'buffer)
(setq centaur-tabs-set-bar 'under)
    )

(add-hook 'inferior-python-mode-hook
          (lambda ()
            (setq comint-move-point-for-output t)))

(use-package! lsp-pyright
  :defer t
  :ensure t
  :init
  (setq! lsp-pyright-multi-root nil)
  )

;; (use-package! conda
;;   :config
;;   (setq! conda-env-autoactivate-mode t)
;;   (add-hook 'python-mode-hook (lambda ()
;;                                 (when
;;                                     (bound-and-true-p
;;                                      conda-project-env-path)
;;                                   (conda-env-activate-for-buffer))))
;;   )



(use-package! org
  :config
  (setq! org-log-done 'time)
  :after
  (require 'org-inlinetask)
  )

(setq org-agenda-files (list "~/org/Todo.org"
                             "~/org/Office.org"
                             "~/org/Personal.org")
)

(after! org
  (defadvice! >org-capture-prevent-restart (fn &rest args)
    :around #'+org--restart-mode-h
    (unless (buffer-base-buffer)
    ; Skip in indirect buffers with the hook cloned
       (apply fn args))))

(defun org-agenda-open-hook ()
  "Hook to be run when org-agenda is opened"
  (olivetti-mode))

;; Adds hook to org agenda mode, making follow mode active in org agenda
(add-hook 'org-agenda-mode-hook
          (lambda()
                (org-agenda-open-hook)
                (visual-line-mode -1)
                (setq truncate-lines 1)))

(use-package! org
  :config
  (setq! org-agenda-span 1
         org-agenda-start-day "+0d"
         org-agenda-skip-timestamp-if-done t
         org-agenda-skip-deadline-if-done t
         org-agenda-skip-scheduled-if-done t
         org-agenda-skip-scheduled-if-deadline-is-shown t
         org-agenda-skip-timestamp-if-deadline-is-shown t)
  )

(setq org-tag-alist '(("personal" . ?p)
                      ("family" . ?f)
                      ("game" . ?g)
                      ("office" . ?o)
                      ("knowledge" . ?k)
                      ("SCHD" . ?s)
                      ("dev" . ?d)))

(use-package all-the-icons
  :ensure t
  )
(setq org-agenda-category-icon-alist
      `(("Teaching" ,(list (all-the-icons-faicon "graduation-cap" :height 0.8))
         nil nil :ascent center)
        ("Home" ,(list (all-the-icons-faicon "home" :v-adjust 0.005))
         nil nil :ascent center)
        ("Health" ,(list (all-the-icons-faicon "heart" :v-adjust 0.0))
         nil nil :ascent center)
        ("Career" ,(list (all-the-icons-material "work" :v-adjust 0.0))
         nil nil :ascent center)
        ("Family" ,(list (all-the-icons-material "people" :v-adjust 0.005))
         nil nil :ascent center)
        ("Bard" ,(list (all-the-icons-faicon "music" :height 0.9))
         nil nil :ascent center)
        ("Stories" ,(list (all-the-icons-faicon "book" :height 0.9))
         nil nil :ascent center)
        ("Dev" ,(list (all-the-icons-faicon "code-fork" :height 0.9))
         nil nil :ascent center)
        ("Office" ,(list (all-the-icons-faicon "briefcase" :v-adjust 0.005))
         nil nil :ascent center)
        ("Author" ,(list (all-the-icons-faicon "pencil" :height 0.9))
         nil nil :ascent center)
        ("Game" ,(list (all-the-icons-faicon "gamepad" :height 0.9))
         nil nil :ascent center)
        ("Knowledge" ,(list (all-the-icons-faicon "database" :height 0.8))
         nil nil :ascent center)
        ("Personal" ,(list (all-the-icons-material "person" :height 0.9))
         nil nil :ascent center)
        ("Todo" ,(list (all-the-icons-faicon "list" :v-adjust 0.005))
         nil nil :ascent center)

        ))

(custom-set-faces!
  '(org-agenda-date :inherit outline-1 :height 1.15)
  '(org-agenda-date-today :inherit diary :height 1.15)
  '(org-agenda-date-weekend :ineherit outline-2 :height  1.15)
  '(org-agenda-date-weekend-today :inherit outline-4 :height 1.15)
  '(org-super-agenda-header :inherit custom-button :weight bold
    :height 1.05)
  )

(setq org-agenda-current-time-string "")
(setq org-agenda-time-grid '((daily) () "" ""))
(setq! org-agenda-tags-column -70)
(setq org-agenda-prefix-format '(
                                 ;; (agenda . " %i %-12:c%?-12t% s")
                                 ;; (agenda . " %i %?-12t% s")
                                 (agenda . "  %-12t %-2i ")
                                 (timeline . "  % s")
                                 ;; (todo . " %i %-12:c")
                                 (todo . "  ")
                                 (tags . " %i %-12:c")
                                 (search . " %i %-12:c")))

;; (setq org-agenda-hide-tags-regexp "")

(setq org-agenda-custom-commands
      '(("n" "Agenda and Task View"
         ((agenda)
          (todo "" ((org-agenda-overriding-header "TASKS")
                    (org-agenda-skip-function '(org-agenda-skip-entry-if 'timestamp))
                    )
                )
          )
         nil
         nil))
      )

(map! :desc "Next line"
      :map org-super-agenda-header-map
      "j" 'org-agenda-next-line)

(map! :desc "Next line"
      :map org-super-agenda-header-map
      "k" 'org-agenda-previous-line)

(require 'org-super-agenda)

(org-super-agenda-mode t)

(setq org-super-agenda-groups
      '(;; Each group has an implicit boolean OR operator
        ;; between its selectors.
        (:name " Overdue "  ; Optionally specify section name
         :scheduled past
         :deadline past
         :order 2
         :face 'error)

        ;; (:name " Personal "
        ;;        :and(:tag "personal" :not (:tag "event"))
        ;;        :order 3)

        ;; (:name " Family "
        ;;        :and(:tag "family" :not (:tag "event"))
        ;;        :order 3)

        ;; (:name " Teaching "
        ;;        :and(:tag "teaching" :not (:tag "event"))
        ;;        :order 3)

        ;; (:name " Game "
        ;;        :and(:tag "game" :not (:tag "event"))
        ;;        :order 3)

        ;; (:name " Dev "
        ;;        :and(:tag "dev" :not (:tag "event"))
        ;;        :order 3)

        ;; (:name " Music "
        ;;        :and(:tag "bard" :not (:tag "event"))
        ;;        :order 3)

        ;; (:name " Storywriting "
        ;;        :and(:tag "stories" :not (:tag "event"))
        ;;        :order 3)

        ;; (:name " Writing "
        ;;        :and(:tag "author" :not (:tag "event"))
        ;;        :order 3)

        ;; (:name " Learning "
        ;;        :and(:tag "knowledge" :not (:tag "event"))
        ;;        :order 3)

        ;; (:name " Office "
        ;;        :and(:tag "office" :not (:tag "event"))
        ;;        :order 3)

        ;; Following are Based FilePath Groupings
        (:name "Personal "
         :and(:file-path "Personal.org" :scheduled nil :not (:tag "event"))
         :order 3)

        (:name "Todo"
         :and(:file-path "Todo.org" :scheduled nil :not (:tag "event"))
         :order 3)

        (:name "Office "
         :and(:file-path "Office.org" :scheduled nil :not (:tag "event"))
         :order 3)

        ;; (:name "Home "
        ;;  :and(:file-path "Home" :not (:tag "event") :not (:deadline t))
        ;;  :order 3)

        ;; (:name "Family "
        ;;  :and(:file-path "Family" :not (:tag "event"))
        ;;  :order 3)

        ;; (:name "Career "
        ;;  :and(:file-path "Career" :not (:tag "event"))
        ;;  :order 3)

        ;; (:name "Health "
        ;;  :and(:file-path "Health" :not (:tag "event"))
        ;;  :order 3)

        ;; (:name "Teaching "
        ;;  :and(:file-path "Teaching" :not (:tag "event"))
        ;;  :order 3)

        ;; (:name "Game "
        ;;  :and(:file-path "Game" :not (:tag "event"))
        ;;  :order 3)

        ;; (:name "Dev "
        ;;  :and(:file-path "Dev" :not (:tag "event"))
        ;;  :order 3)

        ;; (:name "Music "
        ;;  :and(:file-path "Bard" :not (:tag "event"))
        ;;  :order 3)

        ;; (:name "Storywriting "
        ;;  :and(:file-path "Stories" :not (:tag "event"))
        ;;  :order 3)

        ;; (:name "Writing "
        ;;  :and(:file-path "Author" :not (:tag "event"))
        ;;  :order 3)

        ;; (:name "Learning "
        ;;  :and(:file-path "Knowledge" :not (:tag "event"))
        ;;  :order 3)

        (:name " Today "  ; Optionally specify section name
         :time-grid t
         :date today
         :scheduled today
         :order 1
         :face 'warning)
        ))

;; (setq! org-superstar-headline-bullets-list '("⁖" "◉" "○" "✸" "✿"))

(setq org-directory "~/org/")

;; (with-eval-after-load 'org (global-org-modern-mode))
(use-package! org-modern
  :hook
  (org-mode . global-org-modern-mode)
  :custom
  (org-modern-star 'replace)
  (org-modern-table nil)
  )

;; (use-package! org-gtd
;;   :after org
;;   :init
;;   (setq! org-gtd-update-ack "3.0.0")
;;   :custom
;;   (org-gtd-organize-hooks '(org-gtd-set-area-of-focus
;;                            org-set-tags-command))
;;   (org-gtd-next "NEXT")
;;   :config
;;   (setq! org-edna-use-inheritance t)
;;   (setq! org-gtd-directory "~/org")
;;   (setq! org-gtd-default-file-name "actions")
;;   (setq! org-gtd-engage-prefix-width 10)
;;   (org-edna-mode)
;;   (map! :leader
;;         (:prefix ("n g" . "org-gtd")
;;          :desc "Capture"        "c"  #'org-gtd-capture
;;          :desc "Engage"         "e"  #'org-gtd-engage
;;          :desc "Process inbox"  "p"  #'org-gtd-process-inbox
;;          :desc "Show all next"  "n"  #'org-gtd-show-all-next
;;          :desc "Focus Review"   "f"  #'org-gtd-review-area-of-focus
;;          :desc "Stuck projects" "s"  #'org-gtd-review-stuck-projects))
;;   (map! :map org-gtd-clarify-map
;;         :desc "Organize this item" "C-c c" #'org-gtd-organize
;;         )
;;   )

(setq org-capture-templates
      '(("t" "Capture Task")
        ("tx" "Uncatergorized todo" entry
         (file+headline "~/org/Todo.org" "Inbox")
         "* [ ] %?\n%i\n%a" :prepend t)
        ("tp" "Personal todo" entry
         (file+headline "~/org/Personal.org" "Inbox")
         "* [ ] %?\n%i\n%a" :prepend t)
        ("to" "Office todo" entry
         (file+headline "~/org/Office.org" "Inbox")
         "* [ ] %?\n%i\n%a" :prepend t)
        ("n" "Personal notes" entry
         (file+headline +org-capture-notes-file "Inbox")
         "* %u %?\n%i\n%a" :prepend t)
        ("j" "Journal" entry
         (file+olp+datetree +org-capture-journal-file)
         "* %U %?\n%i\n%a" :prepend t)
        ("p" "Templates for projects")
        ("pt" "Project-local todo" entry
         (file+headline +org-capture-project-todo-file "Inbox")
         "* TODO %?\n%i\n%a" :prepend t)
        ("pn" "Project-local notes" entry
         (file+headline +org-capture-project-notes-file "Inbox")
         "* %U %?\n%i\n%a" :prepend t)
        ("pc" "Project-local changelog" entry
         (file+headline +org-capture-project-changelog-file "Unreleased")
         "* %U %?\n%i\n%a" :prepend t)
        ("o" "Centralized templates for projects")
        ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
        ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :heading "Notes" :prepend t)
        ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :heading "Changelog" :prepend t)
        )
      )

(map! :leader
      (:prefix ("s a" . "Avy")
       :desc "Avy Jump Char 2" "c" #'avy-goto-char-2
       :desc "Avy Jump Symbol 1" "s" #'avy-goto-symbol-1
       :desc "Avy Jump Word or Subword 1" "w" #'avy-goto-word-or-subword-1
       )
      )

(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "o" #'dired
       :desc "Create empty file" "f" #'dired-create-empty-file
       :desc "Create directory" "d" #'dired-create-directory
       :desc "Dired jump to current" "j" #'dired-jump)
      )
(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  ; use dired-find-file instead of dired-open.
  (kbd "l") 'dired-find-file
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-do-kill-lines
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-do-touch
  ; copies filename to kill ring.
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill
  (kbd "% l") 'dired-downcase
  (kbd "% m") 'dired-mark-files-regexp
  (kbd "% u") 'dired-upcase
  )

(use-package! which-key
  :ensure t
  :config
  (setq which-key-use-C-h-commands t)
  )
;; this will unbind the C-h in evil window mode
(map! :leader
      (:prefix ("w")
       :desc "" "C-h" #'nil)
      )

(use-package! treemacs
  :config
  (setq! treemacs-collapse-dirs 4
         treemacs-wrap-around t)
)
