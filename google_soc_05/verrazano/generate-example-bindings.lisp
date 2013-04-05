(in-package :cl-user)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :asdf))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (asdf:operate 'asdf:load-op :verrazano))

(in-package :verrazano-user)

(defun generate-binding* (name headers &rest args
                          &key (working-directory (verrazano::system-relative-pathname
                                                   :verrazano "example-bindings/"))
                          (debug nil)
                          (gccxml-flags "-I/usr/include")
                          &allow-other-keys)
  (format *debug-io* "~%~%; *** Processing binding ~S~%" name)
  (remove-from-plistf args :working-directory :gccxml-flags :debug)
  (block try
    (handler-bind ((serious-condition
                    (lambda (error)
                      (unless debug
                        (warn "Failed to generated binding for ~S, error: ~A" name error)
                        (return-from try)))))
      (let ((*print-right-margin* 100))
        (generate-binding (append
                           (list :cffi
                                 :package-name name
                                 :input-files headers
                                 :working-directory working-directory
                                 :gccxml-flags gccxml-flags)
                           args)
                          :keep-temporary-files nil))))
  (values))

(defun generate-oracle-binding ()
  (generate-binding*
   :oracle-cffi-bindings
   '("oci.h"
     "oratypes.h"
     "ocidfn.h"
     "oci1.h"
     "oro.h"
     "ori.h"
     "ociapr.h"
     "ociap.h"
     "oci8dp.h"
     "ociextp.h")
   :gccxml-flags "-I /usr/lib/oracle/xe/app/oracle/product/10.2.0/client/rdbms/public/"
   :package-nicknames "OCI"
   :standard-name-transformer-replacements
   ;; drop "OCI" prefix
   `(,(cl-ppcre:create-scanner "(^OCI_?)") "")))

(defun generate-curl-binding ()
  (generate-binding*
   :curl-cffi-bindings
   '("curl/curl.h"
     "curl/curlver.h"
     "curl/easy.h"
     "curl/mprintf.h"
     "curl/multi.h")))

(defun generate-graphviz-binding ()
  (generate-binding*
   :graphviz-cffi-bindings
   '("graphviz/gvc.h"
     "graphviz/graph.h"
     "graphviz/types.h"
     "graphviz/geom.h")
   :gccxml-flags "`pkg-config --cflags libgvc`"
   :node-filter (lambda (node)
                  (or (not (typep node 'gccxml:macro))
                      (not (search "DEPRECATED_BY"
                                   (verrazano::raw-body-of node)))))))

(defun generate-mozjs-binding ()
  (generate-binding*
   "MOZJS-CFFI-BINDINGS"
   '("jsapi.h"
     "jspubtd.h")
   :gccxml-flags "-DXP_UNIX -I /usr/include/mozjs/"
   :package-nicknames '("MOZJS*")
   :standard-name-transformer-replacements
   `(,(cl-ppcre:create-scanner "^JS_?(.*)")
      ,(lambda (original start end match-start match-end reg-starts reg-ends)
               (declare (ignore start end match-start match-end))
               (flet ((match-group (position)
                        (subseq original (elt reg-starts position) (elt reg-ends position))))
                 (bind ((name (match-group 0)))
                   (if (member original '("jsint8" "jsuint8" "jsint16" "jsuint16" "jsint32" "jsuint32" "jsint64" "jsuint64"
                                          "jsfloat32" "jsfloat64")
                               :test #'string-equal)
                       original
                       name)))))))

(defun generate-cairo-binding ()
  (generate-binding*
   :cairo-cffi-bindings
   '("cairo/cairo.h"
     "cairo/cairo-pdf.h")
   :gccxml-flags "`pkg-config --cflags cairo`"))

(defun generate-imagemagick-binding ()
  (generate-binding*
   :imagemagick-cffi-bindings
   '("magick/ImageMagick.h"
     "magick/draw.h"
     "magick/image.h"
     "magick/methods.h"
     "magick/resize.h"
     "magick/constitute.h"
     "wand/magick-wand.h"
     "wand/magick-attribute.h"
     "wand/pixel-wand.h"
     "wand/drawing-wand.h"
     "wand/pixel-iterator.h"
     "wand/magick-image.h")))

(defun generate-opengl-binding ()
  (generate-binding*
   :opengl-cffi-bindings
   '("GL/gl.h"
     "GL/glu.h"
     "GL/glut.h")
   :standard-name-transformer-replacements
   ;; transform "3DFoo" patterns (in names like "gluBuild3DMipmaps" => glu-build-3d-mipmaps)
   `(,(cl-ppcre:create-scanner "([a-z][1-3]D)([A-Z])")
      ,(lambda (original start end match-start match-end reg-starts reg-ends)
               (declare (ignore start end match-start match-end))
               (flet ((match-group (position)
                        (subseq original (elt reg-starts position) (elt reg-ends position))))
                 (concatenate 'string
                              (string-downcase (match-group 0))
                              "-"
                              (string-downcase (match-group 1))))))))

(defun generate-fltk-binding ()
  (generate-binding*
   :fltk-cffi-bindings
   '("FL/Fl.H"
     "FL/Fl_Window.H"
     "FL/Fl_Button.H"
     "FL/Fl_Input.H"
     "FL/Fl_Output.H")
   :gccxml-flags "`fltk-config --cxxflags`"))

(defun generate-ftgl-binding ()
  (generate-binding*
   :ftgl-cffi-bindings
   '("FTGL/FTGLOutlineFont.h"
     "FTGL/FTGLPolygonFont.h"
     "FTGL/FTGLBitmapFont.h"
     "FTGL/FTGLTextureFont.h"
     "FTGL/FTGLPixmapFont.h")
   :gccxml-flags "`freetype-config --cflags`"))

(defun generate-ldap-binding ()
  (generate-binding*
   :ldap-cffi-bindings
   '("ldap.h")))

(defun generate-posix-binding ()
  (generate-binding*
   :posix-cffi-bindings
   '("unistd.h"
     "fcntl.h")
   :package-nicknames '(:posix)))

(defun generate-openal-binding ()
  (generate-binding*
   :openal-cffi-bindings
   '("AL/al.h"
     "AL/alut.h"
     "AL/alc.h")
   #+win32 :gccxml-flags #+win32 "--gccxml-compiler bcc32 -IC:\\openal\\include\\"))

(defun generate-libarchive-bindings ()
  (generate-binding*
   :libarchive-cffi-bindings
   '("archive.h")))

(defun generate-example-bindings ()
  (generate-oracle-binding)
  (generate-curl-binding)
  (generate-graphviz-binding)
  (generate-mozjs-binding)
  (generate-cairo-binding)
  (generate-imagemagick-binding)
  (generate-opengl-binding)
  (generate-fltk-binding)
  (generate-ftgl-binding)
  (generate-ldap-binding)
  (generate-posix-binding)
  (generate-openal-binding)
  (generate-libarchive-bindings)
  (format *debug-io* "Done."))

(generate-example-bindings)

(in-package :cl-user)
(quit)
