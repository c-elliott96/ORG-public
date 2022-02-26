(setq user-full-name "Christian Elliott"
      user-mail-address "cdelliott96@gmail.com")

(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/") ; Should I change this to elpa?
	("melpa" . "https://melpa.org/packages/")))

;; I really should know more about the next ~ 5 lines.
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'package)
(require 'use-package)

(use-package use-package-ensure-system-package 
  :ensure t)

(use-package async
  :init
  (autoload 'dired-async-mode "dired-async.el" nil t)
  (dired-async-mode 1)
  (async-bytecomp-package-mode 1)
  (autoload 'dired-async-mode "dired-async.el" nil t)
  (async-bytecomp-package-mode 1)
  (dired-async-mode 1))

(defun is-mac-p
    ()
  (eq system-type 'darwin))

(defun is-linux-p
    ()
  (eq system-type 'gnu/linux))

(defun is-windows-p
    ()
  (or
   (eq system-type 'ms-dos)
   (eq system-type 'windows-nt)
   (eq system-type 'cygwin)))

(defun is-bsd-p
    ()
  (eq system-type 'gnu/kfreebsd))

(server-start)

(setq ring-bell-function 'ignore)

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((prog-mode . lsp-deferred)
	 (lsp-mode . lsp-enable-which-key-integration))
  :custom
  (lsp-enable-folding nil)
  (lsp-enable-links nil)
  (lsp-enable-snippet nil)
  (lsp-keymap-prefix "C-c ;")
  (read-process-output-max (* 1024 1024)))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode))

(when (is-mac-p)
  (defun toggle-fullscreen ()
    "Toggle full screen"
    (interactive)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))
  )

(use-package tex
  :ensure auctex)

(when (is-mac-p)
  (setq insert-directory-program "gls" dired-use-ls-dired t)

  ;; For LaTex settings or for fixing errors like =org-create-formula-image: Can’t find ‘latex’ (you need to install the programs: latex and dvipng.)=
  (setenv "PATH" (concat "/Library/TeX/texbin" (getenv "PATH")))
  (setq exec-path (append '("/Library/TeX/texbin") exec-path))
  )

(when (is-mac-p)
  (setq mac-allow-anti-aliasing t))

(setq-default
 cursor-in-non-selected-windows t       ; Hide the cursor in non-selected windows
 fill-column 80                         ; Set width for automatic line breaks
 load-prefer-newer t                    ; Prefer the newest version of a file
 gc-cons-threshold (* 8 1024 1024)      ; Increase GC size
 help-window-select t                   ; Focus new help window when opened
 inhibit-startup-screen t               ; Disable start-up screen
 read-process-output-max (* 1024 1024)  ; Increase read size per process
 scroll-conservatively most-positive-fixnum ; Always scroll by one line
 scroll-margin 2                        ; Add a margin when scrolling vertically     !!
 select-enable-clipboard t)             ; Merge system's and Emacs' clipboard
(delete-selection-mode 1)               ; Replace region when inserting text
(fset 'yes-or-no-p 'y-or-n-p)           ; Replace yes/no prompts with y/n
(put 'downcase-region 'disabled nil)    ; Enable downcase-region
(put 'upcase-region 'disabled nil)      ; Enable upcase-region
(set-default-coding-systems 'utf-8)     ; Default to utf-8 encoding
(global-prettify-symbols-mode +1)       ; Prettify symbols
(show-paren-mode 1)
(column-number-mode 1)
(global-hl-line-mode) ; TODO Make org-mode source code HL a different color

(use-package ibuffer
  :ensure nil
  :preface
  (defvar protected-buffers '("*scratch*" "*Messages*")
    "Buffer that cannot be killed.")
  :bind ("C-x C-b" . ibuffer))

(use-package move-text
  :bind (("M-p" . move-text-up)
	 ("M-n" . move-text-down))
  :config (move-text-default-bindings))

(setq org-hide-emphasis-markers t)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq org-startup-indented t
      org-src-tab-acts-natively t
      org-fontify-done-headline t
      org-pretty-entities t)

(setq-default prettify-symbols-alist '(("#+BEGIN_SRC" . "λ")
                                       ("#+END_SRC" . "λ")
                                       ("#+begin_src" . "λ")
                                       ("#+end_src" . "λ")
                                       (">=" . "≥")
                                       ("=>" . "⇨")))
(setq prettify-symbols-unprettify-at-point 'right-edge)
(add-hook 'org-mode-hook 'prettify-symbols-mode)

(custom-theme-set-faces
 'user
 (if (is-mac-p)
     '(variable-pitch ((t (:family "ETBembo" :height 220 :weight normal))))
   '(variable-pitch ((t (:family "ETBembo" :height 180 :weight normal)))))
 ;;'(fixed-pitch ((t ( :family "Consolas" :slant normal :weight normal :height 0.9 :width normal))))
 '(fixed-pitch ((t ( :family "Menlo" :slant normal :weight thin :height 160 :width normal)))))

(custom-theme-set-faces
 'user
 '(org-block                 ((t (:inherit fixed-pitch))))
 '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
 '(org-property-value        ((t (:inherit fixed-pitch))) t)
 '(org-special-keyword       ((t (:inherit (font-lock-comment-face fixed-pitch)))))
 '(org-tag                   ((t (:inherit (shadow fixed-pitch) :weight bold))))
 '(org-verbatim              ((t (:inherit (shadow fixed-pitch))))))

(use-package org-pretty-tags
  :ensure t
  :config
  (setq org-pretty-tags-surrogate-strings
        (quote
         (("Work" . "")
          ("Home" . "")))))
(org-pretty-tags-global-mode)

(use-package org-fancy-priorities
  :ensure t
  :hook (org-mode . org-fancy-priorities-mode)
  :config
  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

(use-package org
  :init
  ;; Set org-agenda file(s)
  (setq org-agenda-files (list "~/ORG/master-TODO.org"))

  ;; turn on visual line mode for org buffers
  (add-hook 'org-mode-hook #'visual-line-mode)

  ;; turn on variable-pitch-mode in org buffers
  (add-hook 'org-mode-hook #'variable-pitch-mode)

  ;; tangle blocks on save
  ;; TODO: only enable this functionality in Emacs.org
  (add-hook 'org-mode-hook
            (lambda () (add-hook 'after-save-hook #'org-babel-tangle
                                 :append :local)))
  :custom
  (org-support-shift-select 'always)

  :config
  ;; https://stackoverflow.com/questions/11272236/how-to-make-formule-bigger-in-org-mode-of-emacs
  ;; Adjusts the scale of latex in .org files. C-h v org-format-latex-options for more info, or above link
  (setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))

  ;; Set org-agenda "Weekly" view to display 14 days
  ;; Can be day, week, month, year, or any number of days.
  ;; TODO: What is the difference in just setting the variable (like above)
  ;; as opposed to using "setq" like below?
  (setq org-agenda-span '14) )

(use-package ledger-mode
  :ensure t)

(use-package elpy
  :ensure t
  :init
  (elpy-enable))

;; (use-package company
;;   :bind (:map company-active-map
;; 	 ("C-n" . company-select-next)
;; 	 ("C-p" . company-select-previous))
;;   :config
;;   (setq company-idle-delay 0.3)
;;   (global-company-mode t))

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay 0.5)
  (company-minimum-prefix-length 1)
  (company-show-quick-access t)
  (company-tooltip-align-annotations 't))

(use-package company-box
  :if (display-graphic-p)
  :after company
  :hook (company-mode . company-box-mode))

(use-package undo-tree
  :diminish
  :bind ("C-x u" . undo-tree-visualize)
  :config

  ;; Always on
  (global-undo-tree-mode)

  ;; Each node in tree gets timestamps
  (setq undo-tree-visualizer-timestamps t)

  ;; Show a diff window displaying changes between undo nodes
  (setq undo-tree-visualizer-diff t))

(use-package which-key
  :diminish
  :config (which-key-mode)
  (which-key-setup-side-window-bottom)
  (setq which-key-idle-delay 0.2))

(use-package doom-themes
  :config
  ;; (load-theme 'doom-gruvbox t)
  ;;(load-theme 'doom-gruvbox-light t)
  (load-theme 'doom-zenburn t)
  (doom-themes-org-config)
  (setq zenburn-use-variable-pitch t)
  (setq zenburn-scale-org-headlines t)
  (setq zenburn-scale-outline-headlines t))

(use-package zenburn-theme
  :disabled
  :config
  (load-theme 'zenburn t)
  :init
  ;; use variable-pitch fonts for some headings and titles
  (setq zenburn-use-variable-pitch t)

  ;; scale headings in org-mode
  (setq zenburn-scale-org-headlines t)

  ;; scale headings in outline-mode
  (setq zenburn-scale-outline-headlines t))

(use-package doom-modeline
  :init (doom-modeline-mode)
  :custom
  (doom-modeline-icon (display-graphic-p)))

(use-package solaire-mode
  :defer 0.1
  :custom (solaire-mode-remap-fringe t)
  :config (solaire-global-mode))

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(setq inhibit-startup-message t)                ; Not sure if I need this given setting in Better Defaults
(tool-bar-mode -1)                              ; Disable the toolbar
(tooltip-mode -1)                               ; Disable tooltips
(set-fringe-mode 10)                            ; Add fringe
(menu-bar-mode -1)                              ; Disable the menu bar
(setq visible-bell t)                           ; Activate visible bell
(scroll-bar-mode 1)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq use-dialog-box nil) ;; Disable dialog boxes since they weren't working in Mac OSX

(column-number-mode)

;; Enable line numbers for some modes
(dolist (mode '(text-mode-hook
		prog-mode-hook
		conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))

;; Override some modes which derive from the above
(dolist (mode '(org-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package centered-window
  :custom
  (cwm-centered-window-width 130)
  (cwm-frame-internal-border 0)
  (cwm-incremental-padding t)
  (cwm-incremental-padding-% 2)
  (cwm-left-fringe-ratio 0)
  (cwm-use-vertical-padding t)
  :config (centered-window-mode))

(use-package switch-window
  :bind (("C-x o" . switch-window)
	 ("C-x w" . switch-window-then-swap-buffer)))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (:map dired-mode-map
	      ("h" . dired-up-directory)
	      ("j" . dired-next-line)
	      ("k" . dired-previous-line)
	      ("l" . dired-single-buffer))
  :delight "Dired"
  :custom
  ;; (when (eq system-type 'darwin)
  ;;   (insert-directory-program "gls" dired-use-ls-dired t))
  (dired-auto-revert-buffer t)
  (dired-dwim-target t)
  (dired-hide-details-hide-symlink-targets nil)
  (dired-listing-switches "-alh --group-directories-first")
  (dired-ls-F-marks-symlinks nil)
  (dired-recursive-copies 'always))

(use-package dired-single
  :after dired
  :bind (:map dired-mode-map
	      ([remap dired-find-file] . dired-single-buffer)
	      ([remap dired-up-directory] . dired-single-up-directory)
	      ("M-DEL" . dired-prev-subdir)))

(use-package dired-open
  :after (dired dired-jump)
  :custom (dired-open-extensions '(("mp4" . "mpv"))))

(use-package all-the-icons-dired
  :if (display-graphic-p)
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :bind (:map dired-mode-map
	      ("H" . dired-hide-dotfiles-mode)))

(use-package dired-subtree
  :after dired
  :bind (:map dired-mode-map
	      ("<tab>" . dired-subtree-toggle)))

(use-package dired-narrow
  :ensure nil
  :bind (("C-c C-n" . dired-narrow)
	 ("C-c C-f" . dired-narrow-fuzzy)))

(use-package pdf-tools
  :disabled
  :config
  (pdf-tools-install)
  )

(use-package org-pdfview
  :disabled
  )

;; (set-face-attribute 'default nil :family "Source Code Pro")
;; (set-face-attribute 'default nil :height 165)
;; (set-fontset-font t 'latin "Noto Sans")
;; (set-face-attribute 'default nil :family "Menlo")
;; (set-face-attribute 'default nil :height 165)
;; (set-fontset-font t 'latin "Noto Sans")

(use-package unicode-fonts
   :ensure t
   :config
   (unicode-fonts-setup))

(if (version< "27.0" emacs-version)
    (set-fontset-font
     "fontset-default" 'unicode "Apple Color Emoji" nil 'prepend)
  (set-fontset-font
   t 'symbol (font-spec :family "Apple Color Emoji") nil 'prepend))

(use-package company-emoji
  :ensure t)
(use-package company
  :config
  ;; ...
  (add-to-list 'company-backends 'company-emoji))

(use-package all-the-icons
  :if (display-graphic-p)
  :commands all-the-icons-install-fonts
  :config (unless (find-font (font-spec :name "all-the-icons"))
            (all-the-icons-install-fonts t)))

(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))
