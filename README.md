# GstarCAD Block Insert Tools

Insert a block at typed coordinates, or place a whole list of blocks from a CSV file.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Placing blocks by coordinates is a daily task in survey and setting-out work. These tools insert a block at typed X,Y coordinates, and insert a whole list of blocks from a simple CSV file of x,y,blockname rows.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/insert-block-xy.lsp` | ;; insert-block-xy.lsp - Insert a block at typed X,Y coordinates
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
 |
| `scripts/insert-blocks-csv.lsp` | ;; insert-blocks-csv.lsp - Insert blocks from a CSV list
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
