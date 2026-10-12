;; insert-blocks-csv.lsp - Insert blocks from a CSV list
;; Command: IBCSV
;; Usage: CSV rows in the form x,y,blockname
(defun c:IBCSV ( / file f line parts n x y name )
  (vl-load-com)
  (setq file (getfiled "Open CSV (x,y,blockname)" "" "csv" 8))
  (if file
    (progn
      (setq f (open file "r") n 0)
      (while (setq line (read-line f))
        (if (/= line "")
          (progn
            (setq parts (read (strcat "(" (vl-string-translate "," " " line) ")")))
            (if (= (length parts) 3)
              (progn
                (setq x (car parts) y (cadr parts) name (caddr parts))
                (if (and (numberp x) (numberp y) (= (type name) 'STR))
                  (progn
                    (command "_.INSERT" name (list x y 0.0) 1 1 0)
                    (setq n (1+ n))
                  )
                )
              )
            )
          )
        )
      )
      (close f)
      (princ (strcat "\nBlocks inserted: " (itoa n)))
    )
  )
  (princ)
)
