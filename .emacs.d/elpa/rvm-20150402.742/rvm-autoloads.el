;;; rvm-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "rvm" "rvm.el" (22021 28252 813337 156000))
;;; Generated autoloads from rvm.el

(autoload 'rvm-use-default "rvm" "\
use the rvm-default ruby as the current ruby version

\(fn)" t nil)

(autoload 'rvm-activate-corresponding-ruby "rvm" "\
activate the corresponding ruby version for the file in the current buffer.
This function searches for an .rvmrc file and activates the configured ruby.
If no .rvmrc file is found, the default ruby is used insted.

\(fn)" t nil)

(autoload 'rvm-use "rvm" "\
switch the current ruby version to any ruby, which is installed with rvm

\(fn NEW-RUBY NEW-GEMSET)" t nil)

(autoload 'rvm-open-gem "rvm" "\


\(fn GEMHOME)" t nil)

;;;***

;;;### (autoloads nil nil ("rvm-pkg.el") (22021 28252 822353 770000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; rvm-autoloads.el ends here
