(add-to-list 'load-path "~/.emacs.d/lisp")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dirtrack-list (quote (":\\(.*\\)[$#] " 1)))
 '(js-indent-level 2)
 '(markdown-command "pandoc")
 '(show-paren-mode t)
 '(sql-mysql-options
   (quote
    ("-A" "--default-character-set=utf8" "-C" "-t" "-f" "-n"))))

;; Spaces, no tabs.
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq c-basic-offset 4)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(set-face-attribute 'default nil :font "Latin Modern Mono" :height 90)

(setq visual-line-mode t)
(setq x-select-enable-clipboard t)

;; Right-click shows functions in current module
(global-set-key [mouse-3] 'imenu)

;; Comment-Region
(global-set-key [?\C-\;] 'comment-region)
(global-set-key [?\C-\:] 'uncomment-region)

;;LineNum Mode Key
(global-set-key [\C-f5] 'linum-mode)
(global-linum-mode 1)


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

;; compare-windows ignore whitespace
(setq compare-ignore-whitespace 1)

(setq tramp-verbose 5)

(add-to-list 'load-path "~/.emacs.d/nyan-mode-master")
(require 'nyan-mode)

(add-to-list 'load-path "~/.emacs.d/fireplace")
(require 'fireplace)

(put 'downcase-region 'disabled nil)

(require 're-builder)
(setq reb-re-syntax 'string)

;;default modes
(electric-pair-mode 1)
(nyan-mode 1)
(delete-selection-mode 1)
;; save the buffers, their file names, major modes, buffer positions, and so on
(desktop-save-mode 1)
;;Column Numbering
(column-number-mode 1)


(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

(add-hook 'ruby-mode-hook 'robe-mode)
(require 'rvm)
(rvm-use-default)

(add-to-list 'auto-mode-alist '("\\.js.jsx$" . js-mode))

(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(setq css-indent-offset 2)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; code folding
(require 'fold-dwim)
(global-set-key (kbd "<f7>")      'fold-dwim-toggle)
(global-set-key (kbd "<M-f7>")    'fold-dwim-hide-all)
(global-set-key (kbd "<S-M-f7>")  'fold-dwim-show-all)
;; use hs-minor-mode in all programming modes
(add-hook 'prog-mode-hook #'hs-minor-mode)
;; add ruby support
(eval-after-load "hideshow"
  '(add-to-list 'hs-special-modes-alist
    `(ruby-mode
      ,(rx (or "def" "class" "module" "do" "{" "[")) ; Block start
      ,(rx (or "}" "]" "end"))                       ; Block end
      ,(rx (or "#" "=begin"))                        ; Comment start
      ruby-forward-sexp nil)))


(require 'helm-config)
(setq org-mobile-directory "~/MobileOrg")
(setq org-directory "~/notes")
(setq org-mobile-files '("~/notes/doujinshi.org"))
(setq org-mobile-inbox-for-pull "~/notes/from_mobile.org")

;; yaml-mode indent on newline
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(global-set-key (kbd "C-x g") 'magit-status)

(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
(put 'upcase-region 'disabled nil)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (set-face-attribute 'web-mode-html-tag-face nil :foreground "dark green")
  (set-face-background 'web-mode-current-element-highlight-face "gray84")
  (setq web-mode-enable-auto-quoting nil)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)

;; http://emacs.stackexchange.com/a/26279
(defun delete-file-visited-by-buffer (buffername)
  "Delete the file visited by the buffer named BUFFERNAME."
  (interactive "b")
  (let* ((buffer (get-buffer buffername))
         (filename (buffer-file-name buffer)))
    (when filename
      (delete-file filename)
      (kill-buffer-ask buffer))))