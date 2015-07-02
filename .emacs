(add-to-list 'load-path "~/.emacs.d/")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dirtrack-list (quote (":\\(.*\\)[$#] " 1)))
 '(show-paren-mode t)
 '(sql-mysql-options (quote ("-A" "--default-character-set=utf8" "-C" "-t" "-f" "-n"))))

(setq visual-line-mode t)
(setq x-select-enable-clipboard t)
(delete-selection-mode 1)

;; Right-click shows functions in current module
(global-set-key [mouse-3] 'imenu)

;; Comment-Region
(global-set-key [?\C-\;] 'comment-region)
(global-set-key [?\C-\:] 'uncomment-region)

;;LineNum Mode Key
(global-set-key [\C-f5] 'linum-mode)
(global-linum-mode 1)

;;Column Numbering
(column-number-mode 1)

;; Frame title bar formatting to show full path of file, also, top-hat man.
(setq-default
 frame-title-format
 '((buffer-file-name
    "%f"
    (dired-directory
     dired-directory
     (revert-buffer-function " %b"
			     ("%b -- Dir:  " default-directory))))))
;;Newline + Indent
(define-key global-map (kbd "RET") 'newline-and-indent)

;;Remove end newline
(setq mode-require-final-newline nil)
(setq require-final-newline nil)
;; recognize UTF-8 as valid encoding
(define-coding-system-alias 'UTF-8 'utf-8)

;;Enable and configure Ido
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-default-buffer-method 'selected-window)

;; open recently closed files 
;; from http://stackoverflow.com/questions/2227401/how-to-get-a-list-of-last-closed-files-in-emacs

(defvar closed-files (list))

(defun track-closed-file ()
  (and buffer-file-name
       (message buffer-file-name)
       (or (delete buffer-file-name closed-files) t)
       (add-to-list 'closed-files buffer-file-name)))

(defun last-closed-files ()
  (interactive)
  (find-file (ido-completing-read "Last closed: " closed-files)))

(fset 'line-to-next-buffer
   [?\C-a ?\C-  ?\C-e ?\M-w ?\C-x ?o ?\C-y return])
(global-set-key (kbd "C-c s") 'line-to-next-buffer)

(add-hook 'kill-buffer-hook 'track-closed-file)
(put 'narrow-to-region 'disabled nil)

;;DirTrack
(add-hook 'shell-mode-hook
          (lambda ()
            (setq shell-dirtrackp nil)
            (add-hook 'comint-preoutput-filter-functions 'dirtrack nil t)
	    (dirtrack-mode t)))
(add-hook 'ssh-mode-hook (lambda () (setq dirtrackp nil)))


;; Kill all other buffers
(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

;; save the buffers, their file names, major modes, buffer positions, and so on
(desktop-save-mode 1)

;; Spaces, no tabs.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)

;; compare-windows ignore whitespace
(setq compare-ignore-whitespace 1)

(require 'fold-dwim)
(global-set-key (kbd "<f7>")      'fold-dwim-toggle)
(global-set-key (kbd "<M-f7>")    'fold-dwim-hide-all)
(global-set-key (kbd "<S-M-f7>")  'fold-dwim-show-all)

(setq tramp-verbose 5)

(add-to-list 'load-path "~/.emacs.d/nyan-mode-master")
(require 'nyan-mode)

(put 'downcase-region 'disabled nil)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))