# Types and Programming Languages

Collection of resources and boilerplate code for those of us working through Benjamin Pierce's
"Types and Programming Languages". Will be targeting OCaml but any language works in theory.

## What is OCaml

ML (Meta-Language) is a family of statically typed functional programming languages that take
advantage of type inference (we'll learn how to implement that dw) and several other awesome type
system features to catch many bugs at compile time.

OCaml is the most industry-ready of the MLs, and is used by a few decently sized companies, despite
coming from academia. It can be either interpreted or compiled.

## OCaml on Mac

```bash
brew install gpatch opam
opam init  # respond y to edit .zshrc or f and choose different shell rc
eval $(opam env --switch=default)

# verify:
which ocaml
ocaml -version

# install the recommended packages
opam install utop dune merlin

# If you use vscode: ocaml-lsp-server
```

Merlin further instructions:
```

   Quick setup for VIM
   -------------------
   Append this to your .vimrc to add merlin to vim's runtime-path:
     let g:opamshare = substitute(system('opam var share'),'\n$','','''')
     execute "set rtp+=" . g:opamshare . "/merlin/vim"

   Also run the following line in vim to index the documentation:
     :execute "helptags " . g:opamshare . "/merlin/vim/doc"

   Quick setup for EMACS
   -------------------
   Add opam emacs directory to your load-path by appending this to your .emacs:
     (let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
      (when (and opam-share (file-directory-p opam-share))
       ;; Register Merlin
       (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
       (autoload 'merlin-mode "merlin" nil t nil)
       ;; Automatically start it in OCaml buffers
       (add-hook 'tuareg-mode-hook 'merlin-mode t)
       (add-hook 'caml-mode-hook 'merlin-mode t)
       ;; Use opam switch to lookup ocamlmerlin binary
       (setq merlin-command 'opam)))

   Take a look at https://github.com/ocaml/merlin for more information

   Quick setup with opam-user-setup
   --------------------------------

   Opam-user-setup support Merlin.

     $ opam user-setup install

   should take care of basic setup.
   See https://github.com/OCamlPro/opam-user-setup
```

### What the packages are

`utop` is the "universal toplevel", a nicer REPL

`dune` is a mature OCaml build system

`merlin` gives good autocomplete, type checking, and other niceties to `vim` and `emacs`

`ocaml-lsp-server` is needed for the vscode ocaml extensions

