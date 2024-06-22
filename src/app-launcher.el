(use-package app-launcher
  :ensure '(app-launcher :host github :repo "SebastienWae/app-launcher"))
;; create a global keyboard shortcut with the following code
;; emacsclient -cF "((visibility . nil))" -e "(emacs-run-launcher)"

(defun emacs-run-launcher ()
  "Create and select a frame called emacs-run-launcher which consists only of a minibuffer and has specific dimensions. Runs app-launcher-run-app on that frame, which is an emacs command that prompts you to select an app and open it in a dmenu like behaviour. Delete the frame after that command has exited"
  (interactive)
  (with-selected-frame 
    (make-frame '((name . "emacs-run-launcher")
                  (minibuffer . only)
                  (fullscreen . 0) ; no fullscreen
                  (undecorated . t) ; remove title bar
                  (auto-raise . t) ; focus on this frame
                  (internal-border-width . 10)
                  (width . 100)
                  (height . 12)))
                  (unwind-protect
                    (app-launcher-run-app)
                    (delete-frame))))

(provide 'app-launcher)

;; app-launcher.el ends here
