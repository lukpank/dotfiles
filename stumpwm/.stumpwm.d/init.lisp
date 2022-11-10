(in-package :stumpwm)

(set-prefix-key (kbd "s-s"))

(set-font "-xos4-terminus-medium-r-normal--32-320-72-72-c-160-iso10646-1")

(setf *mouse-focus-policy* :sloppy
      *message-window-gravity* :center
      *input-window-gravity* :center
      *window-border-style* :thin
      *time-modeline-string* "%k:%M"
      *screen-mode-line-format* "[^B%n^b] %W^>%d")

(when *initializing*
  (setf (group-name (current-group)) "1")
  (mapc #'gnewbg '("2" "3" "4" "5" "6" "7" "8" "9"))
  (gnewbg-float "0"))

(loop for name in  '("1" "2" "3" "4" "5" "6" "7" "8" "9" "0")
      for shift in '("!" "@" "#" "$" "%" "^" "&" "*" "(" ")")
      do (define-key *top-map* (kbd (concat "s-" name)) (concat "gselect " name))
	 (define-key *top-map* (kbd (concat "s-" shift)) (concat "gmove " name)))

(define-key *root-map* (kbd "c") "exec alacritty")
(define-key *root-map* (kbd "V") "vsplit")
(define-key *root-map* (kbd "e") "exec emacsclient -n -c -a ''")
(define-key *root-map* (kbd "M-e") "emacs")
(define-key *root-map* (kbd "s-l") "exec slock")

(define-key *top-map* (kbd "s-q") "restart-soft")
(define-key *top-map* (kbd "s-Q") "quit-confirm")
(define-key *top-map* (kbd "s-S-RET") "exec alacritty")
(define-key *top-map* (kbd "s-S-F6") "toggle-theme")
(define-key *top-map* (kbd "s-a") "gother")
(define-key *top-map* (kbd "s-b") "mode-line")
(define-key *top-map* (kbd "s-f") "fullscreen")
(define-key *top-map* (kbd "s-i") "gprev")
(define-key *top-map* (kbd "s-o") "gnext")
(define-key *top-map* (kbd "s-I") "gprev-with-window")
(define-key *top-map* (kbd "s-O") "gnext-with-window")
(define-key *top-map* (kbd "s-p") "exec")
(define-key *top-map* (kbd "s-P") "exec rofi -theme Arc-Dark -show combi")

(define-key *top-map* (kbd "s-j") "move-focus down")
(define-key *top-map* (kbd "s-k") "move-focus up")
(define-key *top-map* (kbd "s-h") "move-focus left")
(define-key *top-map* (kbd "s-l") "move-focus right")

(define-key *top-map* (kbd "s-J") "move-window down")
(define-key *top-map* (kbd "s-K") "move-window up")
(define-key *top-map* (kbd "s-H") "move-window left")
(define-key *top-map* (kbd "s-L") "move-window right")

(define-key *top-map* (kbd "s-w") "select-head 0")
(define-key *top-map* (kbd "s-e") "select-head 1")
(define-key *top-map* (kbd "s-r") "select-head 2")

(defpackage :my-stumpwm-config
  (:use :cl))

(in-package :my-stumpwm-config)

(stumpwm:defcommand select-head (num) (:rest)
  (let ((head (nth (parse-integer num) (stumpwm:screen-heads (stumpwm:current-screen)))))
    (stumpwm::focus-frame (stumpwm:current-group)
			  (car (stumpwm::head-frames (stumpwm:current-group) head)))))

(load "~/quicklisp/setup.lisp")
(ql:quickload :slynk)

(stumpwm:defcommand slynk () ()
  (let ((port 4005))
    (slynk:create-server :dont-close t :port port)
    (stumpwm:echo-string (stumpwm:current-screen) (format nil "Slynk started at port ~D" port))))

(stumpwm:load-module :stumpwm-base16)
(when stumpwm:*initializing*
  (stumpwm-base16:load-theme "espresso"))

(dolist (head (stumpwm:screen-heads (stumpwm:current-screen)))
  (stumpwm:enable-mode-line (stumpwm:current-screen) head t))

(defparameter *themes* '(:dark (:stumpwm "espresso"
				:emacs "dark"
				:alacritty "dark"
				:gtk "Materia-dark")
			 :light (:stumpwm "nova"
				 :emacs "light"
				 :alacritty "light"
				 :gtk "Materia-light")))

(defparameter *themes-order* '(:dark :light :light :dark))

(defparameter *theme* :light)

(stumpwm:defcommand toggle-theme () ()
  (setf *theme* (getf *themes-order* *theme*))
  (let ((theme (getf *themes* *theme*)))
   (stumpwm-base16:load-theme (getf theme :stumpwm))
   (dolist (head (stumpwm:screen-heads (stumpwm:current-screen)))
     (stumpwm:toggle-mode-line (stumpwm:current-screen) head)
     (stumpwm:toggle-mode-line (stumpwm:current-screen) head))
   (mapc #'stumpwm:run-shell-command
	 (list (concatenate 'string
			    "sed -i -E 's#Net/ThemeName .*#Net/ThemeName \""
			    (getf theme :gtk)
			    "\"#' ~/.config/xsettingsd/xsettingsd.conf")
	       "pkill -HUP -x xsettingsd; "
	       (concatenate 'string
			    "sed -i 's/^colors: [*].*/colors: *"
			    (getf theme :alacritty)
			    "/' ~/.config/alacritty/alacritty.yml; ")
	       (concatenate 'string
			    "emacsclient --eval \"(my-select-theme '"
			    (getf theme :emacs)
			    ")\"")))))

(if stumpwm:*initializing*
    (toggle-theme))
