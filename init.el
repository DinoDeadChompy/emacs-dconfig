(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))

