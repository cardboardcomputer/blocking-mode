;; command to comment/uncomment text
(defun blocking-comment-dwim (arg)
  "Comment or uncomment current line or region in a smart way.
For detail, see `comment-dwim'."
  (interactive "*P")
  (require 'newcomment)
  (let (
        (comment-start "#") (comment-end "")
        )
    (comment-dwim arg)))

;; keywords for syntax coloring
(setq blocking-keywords
      `(
        ("\\[[^\s-]+\\]" . font-lock-variable-name-face)
        ("^ *[^\s-]+" . font-lock-keyword-face)
        (" \\?.+$" . font-lock-string-face)
        (" \\(Transform\\|Parent\\|Align\\|Unalign\\|LogTime\\|Log\\|Fork\\|Save\\|Breakpoint\\|Tag\\|Interrupt\\|Queue\\|Exec\\|Dialog\\|Sync\\|Wait\\|Event\\|Listen\\|Input\\|Player\\|Marker\\|Interact\\|Audio\\|Warp\\|Walk\\|Run\\|Turn\\|Look\\|Unlook\\|Follow\\|Unfollow\\|Gesture\\|Push\\|Pop\\|Clear\\|Message\\|Set\\|Enable\\|Disable\\)\\*? " . font-lock-function-name-face)
        )
      )

;; syntax table
(defvar blocking-syntax-table nil "Syntax table for `blocking-mode'.")
(setq blocking-syntax-table
      (let ((st (make-syntax-table)))

        ;; bash style comment: “# …” 
        (modify-syntax-entry ?# "< b" st)
        (modify-syntax-entry ?\n "> b" st)
        (modify-syntax-entry ?\" "w" st)

        st))

(define-derived-mode blocking-mode fundamental-mode
  "blocking-mode is a major mode for editing KRZ blocking files."
  :syntax-table blocking-syntax-table

  (setq font-lock-defaults '(blocking-keywords))
  (setq mode-name "Blocking")

  ;; modify the keymap
  (define-key blocking-mode-map [remap comment-dwim] 'blocking-comment-dwim)
  )

(provide 'blocking-mode)
