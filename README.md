# About `c-elliott96/ORG-public`
This repository serves as my global knowledge and *org*anization home. A minor detail: this serves as my public version, mostly for demonstrative purposes.
## Files and folders
### `c-latex/`
This folder houses all my personal LaTeX files.
### `c-ledger/`
This folder houses my personal accounting files using the [Ledger](https://www.ledger-cli.org/) accounting system. 
#### TODO Finish `ImportTransactions.py` to automate the transaction import process from bank .csv.
### `emacs-learning-notes.org`
An old file for notes on Emacs.
#### TODO Move this into `master-notes.org`.
### `Emacs.org`
This file is my literate Emacs configuration. In it are header definitions that tangle and export all emacs-lisp code on save to a file named `init.el`, for easy copying to `~/.emacs.d/`. This file (like this repository) is essentially always a work in progress.
### `encryption-help.org`
A simple file to cat out when I need reminding of my encryption/decryption syntax for GPG.
#### TODO Make this help text a bash alias, at least. Ideally, an interactive prompt to do the commands automatically.
### `Journal.org.gpg` and `Letters.org.gpg`
Since I never check sensitive information into version control, these files should always appear here in encrypted form. Journal.org is my personal journal, while Letters.org contains letters I have written to others. Often these letters are copied into my `c-latex/main-template.tex` for PDF exporting.
#### TODO Look into elisp function to achieve the previous sentence automatically from within an org file.
### `ltximg/` 
Simply houses images I might embed in .tex files.
### `main-pub.key` 
My personal public key.
### `master-notes.org`
My personal notes.
### `master-TODO.org`
My work/personal TODO file. This is the only file that `org-agenda` is configured to pull agenda tasks from, so anything I want to actually show up in my agenda needs to be entered here.
### `orgimg/`
The same as `ltximg/` but for org documents. I'm not really sure separating the two is necessary so a simple `img/` folder would probably suffice. Another TODO, I suppose.
### `scripts/`
Where I house whatever miscellaneous scripts or hacks I want to have for future use. At the moment, it houses a convenient Emacs launching script for osX.
