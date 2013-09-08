;;; This script generates the nix expressions for pkgs.emacsPackages.
;;; Please DO NOT run it in an Emacs with your own configuration -
;;; this script isn't entirely pure (it setq's package-archives).

;;; If you run it, please take not that it will first fetch all
;;; packages to /tmp/nix-emacs-packages and then run
;;; `nix-prefetch-url' to add them to the nix-store. You can safely
;;; delete /tmp/nix-emacs-packages afterwards.

(require 'package)
(require 'cl-lib)

(defconst nix-package-repositories
  '(("gnu" . "http://elpa.gnu.org/packages/")
    ("marmalade" . "http://marmalade-repo.org/packages/")
    ;; ("org" . "http://orgmode.org/elpa/")
    ))

(require 'finder-inf)
(defconst nix-emacs-included-packages
  (append (mapcar 'car package--builtins)
          '(emacs))
  "Packages which are included in Emacs and shouldn't be listed
  in the deps argument.")

(defconst nix-emacs-disabled-packages '())

(defun nix-make-package-url (base-url name package-spec)
  (concat base-url
          (symbol-name name) "-" (package-version-join (package-desc-vers package-spec))
          (cl-case (package-desc-kind package-spec) (tar ".tar")  (single ".el"))))

(defun nix-normalize-package-name (package-name)
  (intern (replace-regexp-in-string
           "\\+" "-plus"
           (replace-regexp-in-string
            "\\." "_"
            (symbol-name package-name)))))

(defun nix-make-deps-string (deps available-packages)
  (concat
   "[ "
   (if deps
       (cl-reduce
        (lambda (a b)
          (concat a " " b))
        (mapcar (lambda (d)
                  (let ((in-emacs? (memq (car d) nix-emacs-included-packages)))
                    ;; We want to add packages to `deps' if it's NOT
                    ;; shipped with Emacs OR if it's in Emacs AND
                    ;; there's a (possible newer) version of the
                    ;; package available in a repository.
                    (when (or (not in-emacs?)
                              (and in-emacs? (memq (car d) available-packages)))
                      (symbol-name
                       (nix-normalize-package-name
                        (car d))))))
                deps))
     "")
   " ]"))

(defun nix-prefetch-packages (base-url filenames)
  (let ((tmpdir "/tmp/nix-emacs-packages/"))
    (ignore-errors (mkdir tmpdir))
    (list tmpdir
          (mapcar (lambda (filename)
                    (let ((out (concat tmpdir filename))
                          (location (concat base-url filename)))
                      (if (file-regular-p out)
                          out
                        (when (url-copy-file location out)
                          (message "Prefetching package from %s" location)
                          filename))))
                  filenames))))

(defun nix-get-sha256 (url)
  (message "Getting sha256 of %s" url)
  (let* ((output (shell-command-to-string (concat "nix-prefetch-url " url)))
         (sha256 (car (last (butlast (split-string output "\n"))))))
    ;; Make sure `sha256' is 52 chars long. If it's not, treat as
    ;; error and return nil.
    (when (= (length sha256) 52)
      sha256)))

(defun nix-generate-package-expression (name
                                        package-spec
                                        base-url
                                        available-packages)
  (let* ((url (nix-make-package-url base-url name package-spec))
         (sha256 (nix-get-sha256 (nix-make-package-url
                                  "file:///tmp/nix-emacs-packages/"
                                  name package-spec))))
    (format
     "
  %s = buildEmacsPackage {
    name = \"%s-%s\";
    src = fetchurl {
      url = \"%s\";
      sha256 = \"%s\";
    };

    deps = %s;
    description = \"%s\";
  };
"
     (symbol-name (nix-normalize-package-name name))
     (symbol-name (nix-normalize-package-name name))
     (package-version-join (package-desc-vers package-spec))
     url
     sha256
     (nix-make-deps-string (package-desc-reqs package-spec)
                           available-packages)
     (replace-regexp-in-string "\"" "'" (package-desc-doc package-spec)))))


(defun nix-remove-duplicate-packages (package-list)
  "Removes duplicate and older packages."
  (let (lst)
    (cl-dolist (p package-list)
      (when (and (not (cl-find-if (lambda (x) (eq (car x) (car p))) lst))
                 (not (cl-find-if (lambda (x) (eq x (car p))) nix-emacs-disabled-packages))
                 (cl-every (lambda (op) (if (eq (car op) (car p))
                                            (version-list-<= (aref (cdr op) 0) (aref (cdr p) 0))
                                          t))
                           package-list))
        (setq lst (cons p lst))))
    lst))

(defun nix-generate-emacs-packages (filename)
  (setq package-archives nix-package-repositories)
  (message "Generating emacs packages to %s" filename)
  (let ((out-buffer (get-buffer-create "generated-emacs-packages.nix")))
    (with-current-buffer out-buffer
      ;; Insert preamble and nix-lambda,
      (insert "# This file is generated by nixpkgs/maintainers/scripts/generate-emacs-packages.el.\n")
      (insert "# DO NOT EDIT THIS FILE.\n")
      (insert "{ buildEmacsPackage, fetchurl, otherPackages }:\n")
      (insert "with otherPackages; rec {\n")

      ;; Loop all archives, generating an attr for each.
      (cl-dolist (archive package-archives)
        (message "Generating packages from %s" (cdr archive))
        (insert (format "\n%s = rec {\n" (car archive)))

        (package--with-work-buffer
         (cdr archive) "archive-contents"
         (let ((packages
                (sort
                 (mapcar (lambda (p) (cons (car p) (vconcat (cdr p) (list (cdr archive)))))
                         (cdr (read (current-buffer))))
                 (lambda (a b) (string< (symbol-name (car a)) (symbol-name (car b)))))))
           (cl-dolist (p packages)
             (nix-prefetch-packages (aref (cdr p) 4)
                                    (list (nix-make-package-url "" (car p) (cdr p)))))
           (cl-dolist (p packages)
             (with-current-buffer out-buffer
               (insert (nix-generate-package-expression
                        (car p) (cdr p)
                        (aref (cdr p) 4)
                        (mapcar 'car packages)))))))
        (insert "};\n\n"))
      (insert "}\n")
      (let ((coding-system-for-write 'utf-8-emacs))
        (write-file filename)))))
