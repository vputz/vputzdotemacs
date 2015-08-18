
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/emacs-lisp")
;; (load "~/.emacs.d/emacs-lisp/imathconv.el")
;; MELPA
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(package-refresh-contents)
(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))
(require 'use-package)
(package-initialize)
(setq use-package-always-ensure t)
(use-package solarized-theme
  :config (load-theme 'solarized-dark))
(use-package dash)
(use-package yasnippet
  :config (yas-global-mode t))
(use-package flycheck)
(use-package web-mode)
(use-package anything)
(use-package ido)
(use-package feature-mode)
(use-package yaml-mode)
(use-package smart-tab
	     :config (setq smart-tab-using-hippie-expand t)
                     (global-smart-tab-mode 1))
;; from bytes.inso.cc/2011/08/13/auto-installing-packages-in-emacs-with-elpa-and-el-get
;;(require 'ipython)
;;(setq py-python-command-args '("--matplotlib" "--colors" "LightBG"))

(setq inhibit-startup-message t)		     
;;(add-hook 'text-mode-hook 'turn-on-auto-fill)
;; (normal-erase-is-backspace-mode)
;; add conf files to auto-mode-alist
(setq auto-mode-alist (cons '("\\.conf$" . shell-script-mode) auto-mode-alist))
;; add fortran 95 files to auto-mode-alist
(setq auto-mode-alist (cons '("\\.f95$" . f90-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("SConstruct" . python-mode))
(add-to-list 'auto-mode-alist '("SConscript" . python-mode))
(add-to-list 'auto-mode-alist '("\\.cu$" . c-mode))
(add-to-list 'auto-mode-alist '("\\.imath$" . imath-mode))

(setq url-proxy-services
      '(("no_proxy" . "^\\(localhost\\|10.*\\)")
	("http" . "odysseus:3128")
	("https" . "odysseus:3128")))

(add-to-list 'hippie-expand-try-functions-list
         'yas/hippie-try-expand)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;;imath helper
(defun imath-clean ()
  "Cleans latex from imath mode"
  (interactive)
  (replace-regexp "\&{latex.*?latex}" ""))

;;ido
(require 'ido)
(ido-mode t)

;;flycheck
;; turn on flychecking globally
;; use web-mode for .jsx files
(require 'flycheck)
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(add-hook 'after-init-hook #'global-flycheck-mode)
;; disable jshint since we prefer eslint
(setq-default flycheck-disabled-checkers
	      (append flycheck-disabled-checkers
		      '(javascript-jshint)))
;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)
;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
	      (append flycheck-disabled-checkers
		      '(json-jsonlist)))

(add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
(require 'web-mode)
(defun my-web-mode-hook ()
  "hooks for web mode"
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4))
(add-hook 'web-mode-hook 'my-web-mode-hook)

(setq imaxima-use-maxima-mode-flag t)

(defun indent-or-complete ()
  "Complete if point is at end of line, and indent line."
  (interactive)
  (if (and (looking-at "$") (not (looking-back "^\\s-*")))
      (hippie-expand nil))
  (indent-for-tab-command)
  )
(global-set-key (kbd "TAB") 'indent-or-complete)

(show-paren-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(global-font-lock-mode t nil (font-lock))
 '(global-smart-tab-mode t)
 '(nil nil t)
 '(org-agenda-files (quote ("~/org/notes.org" "~/marion/notes.org"))))
;;; init.el ends here

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
