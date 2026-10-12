;; insert-block-xy.lsp - Insert a block at typed X,Y coordinates
;; Command: IBXY
;; Usage: type the block name and coordinates; scale 1, rotation 0
(defun c:IBXY ( / name x y )
  (setq name (getstring T "\nBlock name: "))
  (if (/= name "")
    (progn
      (setq x (getreal "\nX: "))
      (setq y (getreal "\nY: "))
      (if (and x y)
        (progn
          (command "_.INSERT" name (list x y 0.0) 1 1 0)
          (princ "\nBlock inserted.")
        )
      )
    )
  )
  (princ)
)
