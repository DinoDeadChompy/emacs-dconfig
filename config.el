(add-to-list 'load-path "~/.config/emacs/src")

(require 'elpaca-setup) ;; Loads the elpaca manager
(require 'buffer-move) ;; Loads the buffer move functions to allow easy moving of panes
(require 'app-launcher) ;; Loads the app launcher function for application launching

(use-package evil
  :init
  (setq evil-want-intergration t)
  (setq evil-want-keybinding nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  :config
  (define-key evil-normal-state-map (kbd "q") :ignore t)
  (evil-set-initial-state 'vterm-mode 'insert)
  (evil-set-initial-state 'eat-mode 'insert)
  (evil-mode))
  (use-package evil-collection
    :after evil
    :config
    (setq evil-collection-mode-list '(dashboard dired ibuffer))
    (evil-collection-init))

;; Using RETURN to follow links in Org/Evil 
;; Unmap keys in 'evil-maps if not done, (setq org-return-follows-link t) will not work
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))
;; Setting RETURN key in org-mode to follow links
  (setq org-return-follows-link  t)

(use-package general
  :config
  (general-evil-setup)

;; setup 'SPC' as the global leader key for Emacs
(general-create-definer ddc/leader-keys
  :states '(normal insert visual emacs)
  :keymaps 'override
  :prefix "SPC" ;; set the leader key
  :global-prefix "M-SPC") ;; set the leader key for all states no matter what

(ddc/leader-keys
  "SPC" '(counsel-M-x :wk "M-x shortcut")
  "." '(find-file :wk "Find file")
  "f c" '((lambda () (interactive) (find-file "~/.config/emacs/config.org")) :wk "Edit emacs config")
  "f r" '(counsel-recentf :wk "Find recent files")
  "TAB TAB" '(comment-line :wk "Comment lines"))

(ddc/leader-keys
    "b" '(:ignore t :wk "Bookmarks/Buffers")
    "b c" '(clone-indirect-buffer :wk "Create indirect buffer copy in a split")
    "b C" '(clone-indirect-buffer-other-window :wk "Clone indirect buffer in new window")
    "b d" '(bookmark-delete :wk "Delete bookmark")
    "b i" '(ibuffer :wk "Ibuffer")
    "b k" '(kill-this-buffer :wk "Kill this buffer")
    "b K" '(kill-some-buffers :wk "Kill multiple buffers")
    "b l" '(list-bookmarks :wk "List bookmarks")
    "b m" '(bookmark-set :wk "Set bookmark")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer")
    "b R" '(rename-buffer :wk "Rename buffer")
    "b s" '(basic-save-buffer :wk "Save buffer")
    "b S" '(save-some-buffers :wk "Save multiple buffers")
    "b w" '(bookmark-save :wk "Save current bookmarks to bookmark file"))

(ddc/leader-keys
  "d" '(:ignore t :wk "Dired")
  "d d" '(dired :wk "Open dired")
  "d j" '(dired-jump :wk "Dired jump to current")
  "d p" '(dired-preview-mode :wk "Dired preview"))

(ddc/leader-keys
  "e" '(:ignore t :wk "Evaluate")    
  "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
  "e d" '(eval-defun :wk "Evaluate defun containing or after point")
  "e e" '(eval-expression :wk "Evaluate and elisp expression")
  "e h" '(counsel-esh-history :which-key "Eshell history")
  "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
  "e r" '(eval-region :wk "Evaluate elisp in region") 
  "e s" '(eshell :which-key "Eshell"))

(ddc/leader-keys
  "h" '(:ignore t :wk "Help")
  "h a" '(counsel-apropos :wk "Apropos")
  "h b" '(describe-bindings :wk "Describe bindings")
  "h c" '(describe-char :wk "Describe character under cursor")
  "h d" '(:ignore t :wk "Emacs documentation")
  "h d a" '(about-emacs :wk "About Emacs")
  "h d d" '(view-emacs-debugging :wk "View Emacs debugging")
  "h d f" '(view-emacs-FAQ :wk "View Emacs FAQ")
  "h d m" '(info-emacs-manual :wk "The Emacs manual")
  "h d n" '(view-emacs-news :wk "View Emacs news")
  "h d o" '(describe-distribution :wk "How to obtain Emacs")
  "h d p" '(view-emacs-problems :wk "View Emacs problems")
  "h d t" '(view-emacs-todo :wk "View Emacs todo")
  "h d w" '(describe-no-warranty :wk "Describe no warranty")
  "h e" '(view-echo-area-messages :wk "View echo area messages")
  "h f" '(describe-function :wk "Describe function")
  "h F" '(describe-face :wk "Describe face")
  "h g" '(describe-gnu-project :wk "Describe GNU Project")
  "h i" '(info :wk "Info")
  "h I" '(describe-input-method :wk "Describe input method")
  "h k" '(describe-key :wk "Describe key")
  "h l" '(view-lossage :wk "Display recent keystrokes and the commands run")
  "h L" '(describe-language-environment :wk "Describe language environment")
  "h m" '(describe-mode :wk "Describe mode")
  "h p" '(elpaca-manager :wk "Elpaca Package Manager")
  "h r" '(:ignore t :wk "Reload")
  "h r r" '((lambda () (interactive)
              (load-file "~/.config/emacs/init.el")
              (ignore (elpaca-process-queues)))
            :wk "Reload emacs config")
  "h t" '(load-theme :wk "Load theme")
  "h v" '(describe-variable :wk "Describe variable")
  "h w" '(where-is :wk "Prints keybinding for command if set")
  "h x" '(describe-command :wk "Display full documentation for command"))

(ddc/leader-keys
  "o" '(:ignore t :wk "Org")
  "o a" '(org-agenda :wk "Org agenda")
  "o e" '(org-export-dispatch :wk "Org export dispatch")
  "o i" '(org-toggle-item :wk "Org toggle item")
  "o t" '(org-todo :wk "Org todo")
  "o B" '(org-babel-tangle :wk "Org babel tangle")
  "o T" '(org-todo-list :wk "Org todo list"))

(ddc/leader-keys
  "o b" '(:ignore t :wk "Tables")
  "o b -" '(org-table-insert-hline :wk "Insert hline in table"))

(ddc/leader-keys
  "o d" '(:ignore t :wk "Date/deadline")
  "o d t" '(org-time-stamp :wk "Org time stamp"))

(ddc/leader-keys
  "p" '(projectile-command-map :wk "Projectile"))

(ddc/leader-keys
  "t" '(:ignore t :wk "Toggle")
  "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
  "t t" '(visual-line-mode :wk "Toggle truncated lines")
  "t v" '(vterm-toggle :wk "Toggle vterm"))

(ddc/leader-keys
  "w" '(:ignore t :wk "Windows")
  ;; Window splits
  "w c" '(evil-window-delete :wk "Close window")
  "w n" '(evil-window-new :wk "New window")
  "w s" '(evil-window-split :wk "Horizontal split window")
  "w v" '(evil-window-vsplit :wk "Vertical split window")
  ;; Window motions
  "w h" '(evil-window-left :wk "Window left")
  "w j" '(evil-window-down :wk "Window down")
  "w k" '(evil-window-up :wk "Window up")
  "w l" '(evil-window-right :wk "Window right")
  "w w" '(evil-window-next :wk "Goto next window")
  ;; Move Windows
  "w H" '(buf-move-left :wk "Buffer move left")
  "w J" '(buf-move-down :wk "Buffer move down")
  "w K" '(buf-move-up :wk "Buffer move up")
  "w L" '(buf-move-right :wk "Buffer move right"))
)

(use-package which-key
  :init
    (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
        which-key-sort-order #'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10
        which-key-side-window-max-height 0.25
        which-key-idle-delay 0.8
        which-key-max-description-length 25
        which-key-allow-imprecise-window-fit nil
        which-key-separator " → " ))

(use-package dired-open
  :config
  (setq dired-open-extensions '(("gif" . "sxiv")
                                ("jpg" . "sxiv")
                                ("png" . "sxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv"))))

(use-package dired-preview
  :after dired
  :config
    (setq dired-preview-max-size 90000000)
    (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
    (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
)

(use-package sudo-edit
  :config
    (ddc/leader-keys
      "f u" '(sudo-edit-find-file :wk "Sudo find file")
      "f U" '(sudo-edit :wk "Sudo edit file")))

(use-package all-the-icons
    :ensure t
    :if (display-graphic-p))

(use-package all-the-icons-dired
  :diminish
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(use-package counsel
  :after ivy
  :diminish
  :config (counsel-mode))

(use-package ivy
  :bind
  ;; ivy-resume resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :diminish
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :after ivy
  :ensure t
  :diminish
  :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer))

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  (setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  ;;(setq dashboard-startup-banner "$HOME/.config/emacs/images/emacs-dash.png")  ;; use custom image as banner
  (setq dashboard-center-content t) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :custom
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook))

(use-package eshell-syntax-highlighting
  :after esh-mode
  :config
  (eshell-syntax-highlighting-global-mode +1))

;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
;; eshell-rc-script -- your profile for eshell; like a bashrc for eshell.
;; eshell-aliases-file -- sets an aliases file for the eshell.
  
(setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
      eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
      eshell-history-size 5000
      eshell-buffer-maximum-lines 5000
      eshell-hist-ignoredups t
      eshell-scroll-to-bottom-on-input t
      eshell-destroy-buffer-when-process-dies t
      eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))

(use-package diminish)

(use-package projectile
  :diminish
  :config
  (projectile-mode 1))

(use-package flycheck
  :ensure t
  :defer t
  :diminish
  :init (global-flycheck-mode))

(use-package company
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(use-package git-timemachine
  :after git-timemachine
  :hook (evil-normalize-keymaps . git-timemachine-hook)
  :config
    (evil-define-key 'normal git-timemachine-mode-map (kbd "C-j") 'git-timemachine-show-previous-revision)
    (evil-define-key 'normal git-timemachine-mode-map (kbd "C-k") 'git-timemachine-show-next-revision)
)

(use-package magit)

(use-package hl-todo
  :hook ((org-mode . hl-todo-mode)
         (prog-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

(use-package vterm
:config
(setq shell-file-name "/bin/zsh"
      vterm-max-scrollback 5000))

(use-package vterm-toggle
  :after vterm
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                     (let ((buffer (get-buffer buffer-or-name)))
                       (with-current-buffer buffer
                         (or (equal major-mode 'vterm-mode)
                             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                  (display-buffer-reuse-window display-buffer-at-bottom)
                  ;;(display-buffer-reuse-window display-buffer-in-direction)
                  ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                  ;;(direction . bottom)
                  ;;(dedicated . t) ;dedicated is supported in emacs27
                  (reusable-frames . visible)
                  (window-height . 0.3))))

(use-package eat
  :config
    (eat-eshell-mode t))

(use-package rainbow-mode
  :diminish
  :hook 
  ((org-mode prog-mode) . rainbow-mode))

;; Add modes here
;; example: (use-package lua-mode)

;; Primary font for most things
(set-face-attribute 'default nil
  :font "JetBrains Mono"
  :height 110
  :weight 'medium)

;; Sets the font for non text editing buffers
(set-face-attribute 'variable-pitch nil
  :font "Noto Sans"
  :height 120
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "JetBrains Mono"
  :height 110
  :weight 'medium)

;; Makes commented text and keywords italic
;; Doesn't work in normal Emacs on the client version
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; This sets the default font on all graphical frames created after restarted Emacs
;; Does the same thing as 'set-face-attribute default'
(add-to-list 'default-frame-alist '(font . "JetBrains Mono-11"))

;; Adjusts line spacing
(setq-default line-spacing 0.12)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode 1)
(global-visual-line-mode t)

(setq make-backup-files nil) ; stop creating ~ files

(setq history-length 25)
(savehist-mode 1)

(save-place-mode 1)

(setq use-dialog-box nil)

(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

(global-set-key [escape] 'keyboard-escape-quit)

;;(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")
    ;;(load-theme 'dinomacs t)
(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled

  (load-theme 'doom-tokyo-night t)
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 30      ;; sets modeline height
        doom-modeline-bar-width 5    ;; sets right bar width
        doom-modeline-persp-name t   ;; adds perspective name to modeline
        doom-modeline-persp-icon t)) ;; adds folder icon next to persp name

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(electric-indent-mode -1)
(setq org-edit-src-content-indentation 0)

(require 'org-tempo)

(eval-after-load 'org-indent '(diminish 'org-indent-mode))

(custom-set-faces
    '(org-block ((t ( :background nil))))
    '(org-block-begin-line ((t ( :background nil))))
    '(org-block-end-line ((t ( :background nil)))))
