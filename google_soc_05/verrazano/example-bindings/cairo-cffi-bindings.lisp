;;; WARNING: This is a generated file, editing it is not advised!
(in-package :cl-user)
(asdf:operate 'asdf:load-op :verrazano-runtime)
(DEFPACKAGE :CAIRO-CFFI-BINDINGS (:USE :CFFI) (:NICKNAMES)
            (:EXPORT "CAIRO-VERSION" "CAIRO-VERSION-STRING" "CAIRO-CREATE" "CAIRO-REFERENCE"
             "CAIRO-DESTROY" "CAIRO-GET-REFERENCE-COUNT" "CAIRO-GET-USER-DATA"
             "CAIRO-SET-USER-DATA" "CAIRO-SAVE" "CAIRO-RESTORE" "CAIRO-PUSH-GROUP"
             "CAIRO-PUSH-GROUP-WITH-CONTENT" "CAIRO-POP-GROUP" "CAIRO-POP-GROUP-TO-SOURCE"
             "CAIRO-SET-OPERATOR" "CAIRO-SET-SOURCE" "CAIRO-SET-SOURCE-RGB" "CAIRO-SET-SOURCE-RGBA"
             "CAIRO-SET-SOURCE-SURFACE" "CAIRO-SET-TOLERANCE" "CAIRO-SET-ANTIALIAS"
             "CAIRO-SET-FILL-RULE" "CAIRO-SET-LINE-WIDTH" "CAIRO-SET-LINE-CAP"
             "CAIRO-SET-LINE-JOIN" "CAIRO-SET-DASH" "CAIRO-SET-MITER-LIMIT" "CAIRO-TRANSLATE"
             "CAIRO-SCALE" "CAIRO-ROTATE" "CAIRO-TRANSFORM" "CAIRO-SET-MATRIX"
             "CAIRO-IDENTITY-MATRIX" "CAIRO-USER-TO-DEVICE" "CAIRO-USER-TO-DEVICE-DISTANCE"
             "CAIRO-DEVICE-TO-USER" "CAIRO-DEVICE-TO-USER-DISTANCE" "CAIRO-NEW-PATH"
             "CAIRO-MOVE-TO" "CAIRO-NEW-SUB-PATH" "CAIRO-LINE-TO" "CAIRO-CURVE-TO" "CAIRO-ARC"
             "CAIRO-ARC-NEGATIVE" "CAIRO-REL-MOVE-TO" "CAIRO-REL-LINE-TO" "CAIRO-REL-CURVE-TO"
             "CAIRO-RECTANGLE" "CAIRO-CLOSE-PATH" "CAIRO-PAINT" "CAIRO-PAINT-WITH-ALPHA"
             "CAIRO-MASK" "CAIRO-MASK-SURFACE" "CAIRO-STROKE" "CAIRO-STROKE-PRESERVE" "CAIRO-FILL"
             "CAIRO-FILL-PRESERVE" "CAIRO-COPY-PAGE" "CAIRO-SHOW-PAGE" "CAIRO-IN-STROKE"
             "CAIRO-IN-FILL" "CAIRO-STROKE-EXTENTS" "CAIRO-FILL-EXTENTS" "CAIRO-RESET-CLIP"
             "CAIRO-CLIP" "CAIRO-CLIP-PRESERVE" "CAIRO-CLIP-EXTENTS"
             "CAIRO-COPY-CLIP-RECTANGLE-LIST" "CAIRO-RECTANGLE-LIST-DESTROY"
             "CAIRO-FONT-OPTIONS-CREATE" "CAIRO-FONT-OPTIONS-COPY" "CAIRO-FONT-OPTIONS-DESTROY"
             "CAIRO-FONT-OPTIONS-STATUS" "CAIRO-FONT-OPTIONS-MERGE" "CAIRO-FONT-OPTIONS-EQUAL"
             "CAIRO-FONT-OPTIONS-HASH" "CAIRO-FONT-OPTIONS-SET-ANTIALIAS"
             "CAIRO-FONT-OPTIONS-GET-ANTIALIAS" "CAIRO-FONT-OPTIONS-SET-SUBPIXEL-ORDER"
             "CAIRO-FONT-OPTIONS-GET-SUBPIXEL-ORDER" "CAIRO-FONT-OPTIONS-SET-HINT-STYLE"
             "CAIRO-FONT-OPTIONS-GET-HINT-STYLE" "CAIRO-FONT-OPTIONS-SET-HINT-METRICS"
             "CAIRO-FONT-OPTIONS-GET-HINT-METRICS" "CAIRO-SELECT-FONT-FACE" "CAIRO-SET-FONT-SIZE"
             "CAIRO-SET-FONT-MATRIX" "CAIRO-GET-FONT-MATRIX" "CAIRO-SET-FONT-OPTIONS"
             "CAIRO-GET-FONT-OPTIONS" "CAIRO-SET-FONT-FACE" "CAIRO-GET-FONT-FACE"
             "CAIRO-SET-SCALED-FONT" "CAIRO-GET-SCALED-FONT" "CAIRO-SHOW-TEXT" "CAIRO-SHOW-GLYPHS"
             "CAIRO-TEXT-PATH" "CAIRO-GLYPH-PATH" "CAIRO-TEXT-EXTENTS" "CAIRO-GLYPH-EXTENTS"
             "CAIRO-FONT-EXTENTS" "CAIRO-FONT-FACE-REFERENCE" "CAIRO-FONT-FACE-DESTROY"
             "CAIRO-FONT-FACE-GET-REFERENCE-COUNT" "CAIRO-FONT-FACE-STATUS"
             "CAIRO-FONT-FACE-GET-TYPE" "CAIRO-FONT-FACE-GET-USER-DATA"
             "CAIRO-FONT-FACE-SET-USER-DATA" "CAIRO-SCALED-FONT-CREATE"
             "CAIRO-SCALED-FONT-REFERENCE" "CAIRO-SCALED-FONT-DESTROY"
             "CAIRO-SCALED-FONT-GET-REFERENCE-COUNT" "CAIRO-SCALED-FONT-STATUS"
             "CAIRO-SCALED-FONT-GET-TYPE" "CAIRO-SCALED-FONT-GET-USER-DATA"
             "CAIRO-SCALED-FONT-SET-USER-DATA" "CAIRO-SCALED-FONT-EXTENTS"
             "CAIRO-SCALED-FONT-TEXT-EXTENTS" "CAIRO-SCALED-FONT-GLYPH-EXTENTS"
             "CAIRO-SCALED-FONT-GET-FONT-FACE" "CAIRO-SCALED-FONT-GET-FONT-MATRIX"
             "CAIRO-SCALED-FONT-GET-CTM" "CAIRO-SCALED-FONT-GET-FONT-OPTIONS" "CAIRO-GET-OPERATOR"
             "CAIRO-GET-SOURCE" "CAIRO-GET-TOLERANCE" "CAIRO-GET-ANTIALIAS"
             "CAIRO-GET-CURRENT-POINT" "CAIRO-GET-FILL-RULE" "CAIRO-GET-LINE-WIDTH"
             "CAIRO-GET-LINE-CAP" "CAIRO-GET-LINE-JOIN" "CAIRO-GET-MITER-LIMIT"
             "CAIRO-GET-DASH-COUNT" "CAIRO-GET-DASH" "CAIRO-GET-MATRIX" "CAIRO-GET-TARGET"
             "CAIRO-GET-GROUP-TARGET" "CAIRO-COPY-PATH" "CAIRO-COPY-PATH-FLAT" "CAIRO-APPEND-PATH"
             "CAIRO-PATH-DESTROY" "CAIRO-STATUS" "CAIRO-STATUS-TO-STRING"
             "CAIRO-SURFACE-CREATE-SIMILAR" "CAIRO-SURFACE-REFERENCE" "CAIRO-SURFACE-FINISH"
             "CAIRO-SURFACE-DESTROY" "CAIRO-SURFACE-GET-REFERENCE-COUNT" "CAIRO-SURFACE-STATUS"
             "CAIRO-SURFACE-GET-TYPE" "CAIRO-SURFACE-GET-CONTENT" "CAIRO-SURFACE-WRITE-TO-PNG"
             "CAIRO-SURFACE-WRITE-TO-PNG-STREAM" "CAIRO-SURFACE-GET-USER-DATA"
             "CAIRO-SURFACE-SET-USER-DATA" "CAIRO-SURFACE-GET-FONT-OPTIONS" "CAIRO-SURFACE-FLUSH"
             "CAIRO-SURFACE-MARK-DIRTY" "CAIRO-SURFACE-MARK-DIRTY-RECTANGLE"
             "CAIRO-SURFACE-SET-DEVICE-OFFSET" "CAIRO-SURFACE-GET-DEVICE-OFFSET"
             "CAIRO-SURFACE-SET-FALLBACK-RESOLUTION" "CAIRO-IMAGE-SURFACE-CREATE"
             "CAIRO-IMAGE-SURFACE-CREATE-FOR-DATA" "CAIRO-IMAGE-SURFACE-GET-DATA"
             "CAIRO-IMAGE-SURFACE-GET-FORMAT" "CAIRO-IMAGE-SURFACE-GET-WIDTH"
             "CAIRO-IMAGE-SURFACE-GET-HEIGHT" "CAIRO-IMAGE-SURFACE-GET-STRIDE"
             "CAIRO-IMAGE-SURFACE-CREATE-FROM-PNG" "CAIRO-IMAGE-SURFACE-CREATE-FROM-PNG-STREAM"
             "CAIRO-PATTERN-CREATE-RGB" "CAIRO-PATTERN-CREATE-RGBA"
             "CAIRO-PATTERN-CREATE-FOR-SURFACE" "CAIRO-PATTERN-CREATE-LINEAR"
             "CAIRO-PATTERN-CREATE-RADIAL" "CAIRO-PATTERN-REFERENCE" "CAIRO-PATTERN-DESTROY"
             "CAIRO-PATTERN-GET-REFERENCE-COUNT" "CAIRO-PATTERN-STATUS"
             "CAIRO-PATTERN-GET-USER-DATA" "CAIRO-PATTERN-SET-USER-DATA" "CAIRO-PATTERN-GET-TYPE"
             "CAIRO-PATTERN-ADD-COLOR-STOP-RGB" "CAIRO-PATTERN-ADD-COLOR-STOP-RGBA"
             "CAIRO-PATTERN-SET-MATRIX" "CAIRO-PATTERN-GET-MATRIX" "CAIRO-PATTERN-SET-EXTEND"
             "CAIRO-PATTERN-GET-EXTEND" "CAIRO-PATTERN-SET-FILTER" "CAIRO-PATTERN-GET-FILTER"
             "CAIRO-PATTERN-GET-RGBA" "CAIRO-PATTERN-GET-SURFACE"
             "CAIRO-PATTERN-GET-COLOR-STOP-RGBA" "CAIRO-PATTERN-GET-COLOR-STOP-COUNT"
             "CAIRO-PATTERN-GET-LINEAR-POINTS" "CAIRO-PATTERN-GET-RADIAL-CIRCLES"
             "CAIRO-MATRIX-INIT" "CAIRO-MATRIX-INIT-IDENTITY" "CAIRO-MATRIX-INIT-TRANSLATE"
             "CAIRO-MATRIX-INIT-SCALE" "CAIRO-MATRIX-INIT-ROTATE" "CAIRO-MATRIX-TRANSLATE"
             "CAIRO-MATRIX-SCALE" "CAIRO-MATRIX-ROTATE" "CAIRO-MATRIX-INVERT"
             "CAIRO-MATRIX-MULTIPLY" "CAIRO-MATRIX-TRANSFORM-DISTANCE"
             "CAIRO-MATRIX-TRANSFORM-POINT" "CAIRO-DEBUG-RESET-STATIC-DATA"
             "CAIRO-PDF-SURFACE-CREATE" "CAIRO-PDF-SURFACE-CREATE-FOR-STREAM"
             "CAIRO-PDF-SURFACE-SET-SIZE" "CAIRO-RECTANGLE-LIST-T" "CAIRO-BOOL-T"
             "CAIRO-SUBPIXEL-ORDER-T" "CAIRO-HINT-STYLE-T" "CAIRO-HINT-METRICS-T"
             "CAIRO-FONT-WEIGHT-T" "CAIRO-FONT-SLANT-T" "CAIRO-FONT-TYPE-T" "CAIRO-FONT-FACE-T"
             "CAIRO-SCALED-FONT-T" "CAIRO-OPERATOR-T" "CAIRO-ANTIALIAS-T" "CAIRO-FILL-RULE-T"
             "CAIRO-LINE-CAP-T" "CAIRO-LINE-JOIN-T" "CAIRO-PATH-T" "CAIRO-T" "CAIRO-SURFACE-TYPE-T"
             "CAIRO-CONTENT-T" "CAIRO-FONT-OPTIONS-T" "CAIRO-FORMAT-T" "CAIRO-READ-FUNC-T"
             "CAIRO-DESTROY-FUNC-T" "CAIRO-USER-DATA-KEY-T" "CAIRO-PATTERN-TYPE-T" "CAIRO-EXTEND-T"
             "CAIRO-FILTER-T" "CAIRO-PATTERN-T" "CAIRO-MATRIX-T" "CAIRO-WRITE-FUNC-T"
             "CAIRO-SURFACE-T" "CAIRO-PATH-DATA-T" "CAIRO-PATH-DATA-TYPE-T" "CAIRO-RECTANGLE-T"
             "CAIRO-STATUS-T" "CAIRO-PATH" "CAIRO-FONT-EXTENTS-T" "CAIRO-TEXT-EXTENTS-T"
             "CAIRO-GLYPH-T"))

(in-package :CAIRO-CFFI-BINDINGS)
(cffi:defcstruct _cairo-matrix (xx :double) (yx :double) (xy :double) (yy :double) (x0 :double)
 (y0 :double))
(cffi:defcstruct _cairo-user-data-key (unused :int))
(cffi:defcstruct _cairo-rectangle (x :double) (y :double) (width :double) (height :double))
(cffi::defctype* cairo-status-t _cairo-status)
(cffi:defcenum _cairo-status (:cairo-status-success 0) (:cairo-status-no-memory 1)
 (:cairo-status-invalid-restore 2) (:cairo-status-invalid-pop-group 3)
 (:cairo-status-no-current-point 4) (:cairo-status-invalid-matrix 5)
 (:cairo-status-invalid-status 6) (:cairo-status-null-pointer 7) (:cairo-status-invalid-string 8)
 (:cairo-status-invalid-path-data 9) (:cairo-status-read-error 10) (:cairo-status-write-error 11)
 (:cairo-status-surface-finished 12) (:cairo-status-surface-type-mismatch 13)
 (:cairo-status-pattern-type-mismatch 14) (:cairo-status-invalid-content 15)
 (:cairo-status-invalid-format 16) (:cairo-status-invalid-visual 17)
 (:cairo-status-file-not-found 18) (:cairo-status-invalid-dash 19)
 (:cairo-status-invalid-dsc-comment 20) (:cairo-status-invalid-index 21)
 (:cairo-status-clip-not-representable 22))
(cffi::defctype* cairo-rectangle-t _cairo-rectangle)
(cffi:defcstruct _cairo-rectangle-list (status cairo-status-t) (rectangles :pointer)
 (num-rectangles :int))
(cffi:defcstruct cairo-glyph-t (index :unsigned-long) (x :double) (y :double))
(cffi:defcstruct cairo-text-extents-t (x-bearing :double) (y-bearing :double) (width :double)
 (height :double) (x-advance :double) (y-advance :double))
(cffi:defcstruct cairo-font-extents-t (ascent :double) (descent :double) (height :double)
 (max-x-advance :double) (max-y-advance :double))
(cffi:defcstruct _cairo-path-data-t-anonymous-169 (x :double) (y :double))
(cffi::defctype* cairo-path-data-type-t _cairo-path-data-type)
(cffi:defcenum _cairo-path-data-type (:cairo-path-move-to 0) (:cairo-path-line-to 1)
 (:cairo-path-curve-to 2) (:cairo-path-close-path 3))
(cffi:defcstruct _cairo-path-data-t-anonymous-164 (type cairo-path-data-type-t) (length :int))
(cffi:defcstruct _cairo-path-data-t (header _cairo-path-data-t-anonymous-164)
 (point _cairo-path-data-t-anonymous-169))
(cffi::defctype* cairo-path-data-t _cairo-path-data-t)
(cffi:defcstruct cairo-path (status cairo-status-t) (data :pointer) (num-data :int))
(cffi::defctype* cairo-surface-t _cairo-surface)
(cffi:defcstruct _cairo-surface)
(cffi::defctype* cairo-write-func-t :pointer)
(cffi::defctype* cairo-matrix-t _cairo-matrix)
(cffi::defctype* cairo-pattern-t _cairo-pattern)
(cffi:defcstruct _cairo-pattern)
(cffi::defctype* cairo-filter-t _cairo-filter)
(cffi:defcenum _cairo-filter (:cairo-filter-fast 0) (:cairo-filter-good 1) (:cairo-filter-best 2)
 (:cairo-filter-nearest 3) (:cairo-filter-bilinear 4) (:cairo-filter-gaussian 5))
(cffi::defctype* cairo-extend-t _cairo-extend)
(cffi:defcenum _cairo-extend (:cairo-extend-none 0) (:cairo-extend-repeat 1)
 (:cairo-extend-reflect 2) (:cairo-extend-pad 3))
(cffi::defctype* cairo-pattern-type-t _cairo-pattern-type)
(cffi:defcenum _cairo-pattern-type (:cairo-pattern-type-solid 0) (:cairo-pattern-type-surface 1)
 (:cairo-pattern-type-linear 2) (:cairo-pattern-type-radial 3))
(cffi::defctype* cairo-user-data-key-t _cairo-user-data-key)
(cffi::defctype* cairo-destroy-func-t :pointer)
(cffi::defctype* cairo-read-func-t :pointer)
(cffi::defctype* cairo-format-t _cairo-format)
(cffi:defcenum _cairo-format (:cairo-format-argb-32 0) (:cairo-format-rgb-24 1)
 (:cairo-format-a-8 2) (:cairo-format-a-1 3))
(cffi::defctype* cairo-font-options-t _cairo-font-options)
(cffi:defcstruct _cairo-font-options)
(cffi::defctype* cairo-content-t _cairo-content)
(cffi:defcenum _cairo-content (:cairo-content-color 4096) (:cairo-content-alpha 8192)
 (:cairo-content-color-alpha 12288))
(cffi::defctype* cairo-surface-type-t _cairo-surface-type)
(cffi:defcenum _cairo-surface-type (:cairo-surface-type-image 0) (:cairo-surface-type-pdf 1)
 (:cairo-surface-type-ps 2) (:cairo-surface-type-xlib 3) (:cairo-surface-type-xcb 4)
 (:cairo-surface-type-glitz 5) (:cairo-surface-type-quartz 6) (:cairo-surface-type-win-32 7)
 (:cairo-surface-type-beos 8) (:cairo-surface-type-directfb 9) (:cairo-surface-type-svg 10)
 (:cairo-surface-type-os-2 11))
(cffi::defctype* cairo-t _cairo)
(cffi:defcstruct _cairo)
(cffi::defctype* cairo-path-t cairo-path)
(cffi::defctype* cairo-line-join-t _cairo-line-join)
(cffi:defcenum _cairo-line-join (:cairo-line-join-miter 0) (:cairo-line-join-round 1)
 (:cairo-line-join-bevel 2))
(cffi::defctype* cairo-line-cap-t _cairo-line-cap)
(cffi:defcenum _cairo-line-cap (:cairo-line-cap-butt 0) (:cairo-line-cap-round 1)
 (:cairo-line-cap-square 2))
(cffi::defctype* cairo-fill-rule-t _cairo-fill-rule)
(cffi:defcenum _cairo-fill-rule (:cairo-fill-rule-winding 0) (:cairo-fill-rule-even-odd 1))
(cffi::defctype* cairo-antialias-t _cairo-antialias)
(cffi:defcenum _cairo-antialias (:cairo-antialias-default 0) (:cairo-antialias-none 1)
 (:cairo-antialias-gray 2) (:cairo-antialias-subpixel 3))
(cffi::defctype* cairo-operator-t _cairo-operator)
(cffi:defcenum _cairo-operator (:cairo-operator-clear 0) (:cairo-operator-source 1)
 (:cairo-operator-over 2) (:cairo-operator-in 3) (:cairo-operator-out 4) (:cairo-operator-atop 5)
 (:cairo-operator-dest 6) (:cairo-operator-dest-over 7) (:cairo-operator-dest-in 8)
 (:cairo-operator-dest-out 9) (:cairo-operator-dest-atop 10) (:cairo-operator-xor 11)
 (:cairo-operator-add 12) (:cairo-operator-saturate 13))
(cffi::defctype* cairo-scaled-font-t _cairo-scaled-font)
(cffi:defcstruct _cairo-scaled-font)
(cffi::defctype* cairo-font-face-t _cairo-font-face)
(cffi:defcstruct _cairo-font-face)
(cffi::defctype* cairo-font-type-t _cairo-font-type)
(cffi:defcenum _cairo-font-type (:cairo-font-type-toy 0) (:cairo-font-type-ft 1)
 (:cairo-font-type-win-32 2) (:cairo-font-type-atsui 3))
(cffi::defctype* cairo-font-slant-t _cairo-font-slant)
(cffi:defcenum _cairo-font-slant (:cairo-font-slant-normal 0) (:cairo-font-slant-italic 1)
 (:cairo-font-slant-oblique 2))
(cffi::defctype* cairo-font-weight-t _cairo-font-weight)
(cffi:defcenum _cairo-font-weight (:cairo-font-weight-normal 0) (:cairo-font-weight-bold 1))
(cffi::defctype* cairo-hint-metrics-t _cairo-hint-metrics)
(cffi:defcenum _cairo-hint-metrics (:cairo-hint-metrics-default 0) (:cairo-hint-metrics-off 1)
 (:cairo-hint-metrics-on 2))
(cffi::defctype* cairo-hint-style-t _cairo-hint-style)
(cffi:defcenum _cairo-hint-style (:cairo-hint-style-default 0) (:cairo-hint-style-none 1)
 (:cairo-hint-style-slight 2) (:cairo-hint-style-medium 3) (:cairo-hint-style-full 4))
(cffi::defctype* cairo-subpixel-order-t _cairo-subpixel-order)
(cffi:defcenum _cairo-subpixel-order (:cairo-subpixel-order-default 0)
 (:cairo-subpixel-order-rgb 1) (:cairo-subpixel-order-bgr 2) (:cairo-subpixel-order-vrgb 3)
 (:cairo-subpixel-order-vbgr 4))
(cffi::defctype* cairo-bool-t :int)
(cffi::defctype* cairo-rectangle-list-t _cairo-rectangle-list)
(cl:progn
 (cffi:defcfun ("cairo_pdf_surface_set_size" cairo-pdf-surface-set-size) :void (surface :pointer)
  (width_in_points :double) (height_in_points :double))
 (cffi:defcfun ("cairo_pdf_surface_create_for_stream" cairo-pdf-surface-create-for-stream) :pointer
  (write_func cairo-write-func-t) (closure :pointer) (width_in_points :double)
  (height_in_points :double))
 (cffi:defcfun ("cairo_pdf_surface_create" cairo-pdf-surface-create) :pointer (filename :string)
  (width_in_points :double) (height_in_points :double))
 (cffi:defcfun ("cairo_debug_reset_static_data" cairo-debug-reset-static-data) :void)
 (cffi:defcfun ("cairo_matrix_transform_point" cairo-matrix-transform-point) :void
  (matrix :pointer) (x :pointer) (y :pointer))
 (cffi:defcfun ("cairo_matrix_transform_distance" cairo-matrix-transform-distance) :void
  (matrix :pointer) (dx :pointer) (dy :pointer))
 (cffi:defcfun ("cairo_matrix_multiply" cairo-matrix-multiply) :void (result :pointer) (a :pointer)
  (b :pointer))
 (cffi:defcfun ("cairo_matrix_invert" cairo-matrix-invert) cairo-status-t (matrix :pointer))
 (cffi:defcfun ("cairo_matrix_rotate" cairo-matrix-rotate) :void (matrix :pointer)
  (radians :double))
 (cffi:defcfun ("cairo_matrix_scale" cairo-matrix-scale) :void (matrix :pointer) (sx :double)
  (sy :double))
 (cffi:defcfun ("cairo_matrix_translate" cairo-matrix-translate) :void (matrix :pointer)
  (tx :double) (ty :double))
 (cffi:defcfun ("cairo_matrix_init_rotate" cairo-matrix-init-rotate) :void (matrix :pointer)
  (radians :double))
 (cffi:defcfun ("cairo_matrix_init_scale" cairo-matrix-init-scale) :void (matrix :pointer)
  (sx :double) (sy :double))
 (cffi:defcfun ("cairo_matrix_init_translate" cairo-matrix-init-translate) :void (matrix :pointer)
  (tx :double) (ty :double))
 (cffi:defcfun ("cairo_matrix_init_identity" cairo-matrix-init-identity) :void (matrix :pointer))
 (cffi:defcfun ("cairo_matrix_init" cairo-matrix-init) :void (matrix :pointer) (xx :double)
  (yx :double) (xy :double) (yy :double) (x0 :double) (y0 :double))
 (cffi:defcfun ("cairo_pattern_get_radial_circles" cairo-pattern-get-radial-circles) cairo-status-t
  (pattern :pointer) (x0 :pointer) (y0 :pointer) (r0 :pointer) (x1 :pointer) (y1 :pointer)
  (r1 :pointer))
 (cffi:defcfun ("cairo_pattern_get_linear_points" cairo-pattern-get-linear-points) cairo-status-t
  (pattern :pointer) (x0 :pointer) (y0 :pointer) (x1 :pointer) (y1 :pointer))
 (cffi:defcfun ("cairo_pattern_get_color_stop_count" cairo-pattern-get-color-stop-count)
  cairo-status-t (pattern :pointer) (count :pointer))
 (cffi:defcfun ("cairo_pattern_get_color_stop_rgba" cairo-pattern-get-color-stop-rgba)
  cairo-status-t (pattern :pointer) (index :int) (offset :pointer) (red :pointer) (green :pointer)
  (blue :pointer) (alpha :pointer))
 (cffi:defcfun ("cairo_pattern_get_surface" cairo-pattern-get-surface) cairo-status-t
  (pattern :pointer) (surface :pointer))
 (cffi:defcfun ("cairo_pattern_get_rgba" cairo-pattern-get-rgba) cairo-status-t (pattern :pointer)
  (red :pointer) (green :pointer) (blue :pointer) (alpha :pointer))
 (cffi:defcfun ("cairo_pattern_get_filter" cairo-pattern-get-filter) cairo-filter-t
  (pattern :pointer))
 (cffi:defcfun ("cairo_pattern_set_filter" cairo-pattern-set-filter) :void (pattern :pointer)
  (filter cairo-filter-t))
 (cffi:defcfun ("cairo_pattern_get_extend" cairo-pattern-get-extend) cairo-extend-t
  (pattern :pointer))
 (cffi:defcfun ("cairo_pattern_set_extend" cairo-pattern-set-extend) :void (pattern :pointer)
  (extend cairo-extend-t))
 (cffi:defcfun ("cairo_pattern_get_matrix" cairo-pattern-get-matrix) :void (pattern :pointer)
  (matrix :pointer))
 (cffi:defcfun ("cairo_pattern_set_matrix" cairo-pattern-set-matrix) :void (pattern :pointer)
  (matrix :pointer))
 (cffi:defcfun ("cairo_pattern_add_color_stop_rgba" cairo-pattern-add-color-stop-rgba) :void
  (pattern :pointer) (offset :double) (red :double) (green :double) (blue :double) (alpha :double))
 (cffi:defcfun ("cairo_pattern_add_color_stop_rgb" cairo-pattern-add-color-stop-rgb) :void
  (pattern :pointer) (offset :double) (red :double) (green :double) (blue :double))
 (cffi:defcfun ("cairo_pattern_get_type" cairo-pattern-get-type) cairo-pattern-type-t
  (pattern :pointer))
 (cffi:defcfun ("cairo_pattern_set_user_data" cairo-pattern-set-user-data) cairo-status-t
  (pattern :pointer) (key :pointer) (user_data :pointer) (destroy cairo-destroy-func-t))
 (cffi:defcfun ("cairo_pattern_get_user_data" cairo-pattern-get-user-data) :pointer
  (pattern :pointer) (key :pointer))
 (cffi:defcfun ("cairo_pattern_status" cairo-pattern-status) cairo-status-t (pattern :pointer))
 (cffi:defcfun ("cairo_pattern_get_reference_count" cairo-pattern-get-reference-count)
  :unsigned-int (pattern :pointer))
 (cffi:defcfun ("cairo_pattern_destroy" cairo-pattern-destroy) :void (pattern :pointer))
 (cffi:defcfun ("cairo_pattern_reference" cairo-pattern-reference) :pointer (pattern :pointer))
 (cffi:defcfun ("cairo_pattern_create_radial" cairo-pattern-create-radial) :pointer (cx0 :double)
  (cy0 :double) (radius0 :double) (cx1 :double) (cy1 :double) (radius1 :double))
 (cffi:defcfun ("cairo_pattern_create_linear" cairo-pattern-create-linear) :pointer (x0 :double)
  (y0 :double) (x1 :double) (y1 :double))
 (cffi:defcfun ("cairo_pattern_create_for_surface" cairo-pattern-create-for-surface) :pointer
  (surface :pointer))
 (cffi:defcfun ("cairo_pattern_create_rgba" cairo-pattern-create-rgba) :pointer (red :double)
  (green :double) (blue :double) (alpha :double))
 (cffi:defcfun ("cairo_pattern_create_rgb" cairo-pattern-create-rgb) :pointer (red :double)
  (green :double) (blue :double))
 (cffi:defcfun
  ("cairo_image_surface_create_from_png_stream" cairo-image-surface-create-from-png-stream)
  :pointer (read_func cairo-read-func-t) (closure :pointer))
 (cffi:defcfun ("cairo_image_surface_create_from_png" cairo-image-surface-create-from-png) :pointer
  (filename :string))
 (cffi:defcfun ("cairo_image_surface_get_stride" cairo-image-surface-get-stride) :int
  (surface :pointer))
 (cffi:defcfun ("cairo_image_surface_get_height" cairo-image-surface-get-height) :int
  (surface :pointer))
 (cffi:defcfun ("cairo_image_surface_get_width" cairo-image-surface-get-width) :int
  (surface :pointer))
 (cffi:defcfun ("cairo_image_surface_get_format" cairo-image-surface-get-format) cairo-format-t
  (surface :pointer))
 (cffi:defcfun ("cairo_image_surface_get_data" cairo-image-surface-get-data) :pointer
  (surface :pointer))
 (cffi:defcfun ("cairo_image_surface_create_for_data" cairo-image-surface-create-for-data) :pointer
  (data :pointer) (format cairo-format-t) (width :int) (height :int) (stride :int))
 (cffi:defcfun ("cairo_image_surface_create" cairo-image-surface-create) :pointer
  (format cairo-format-t) (width :int) (height :int))
 (cffi:defcfun ("cairo_surface_set_fallback_resolution" cairo-surface-set-fallback-resolution)
  :void (surface :pointer) (x_pixels_per_inch :double) (y_pixels_per_inch :double))
 (cffi:defcfun ("cairo_surface_get_device_offset" cairo-surface-get-device-offset) :void
  (surface :pointer) (x_offset :pointer) (y_offset :pointer))
 (cffi:defcfun ("cairo_surface_set_device_offset" cairo-surface-set-device-offset) :void
  (surface :pointer) (x_offset :double) (y_offset :double))
 (cffi:defcfun ("cairo_surface_mark_dirty_rectangle" cairo-surface-mark-dirty-rectangle) :void
  (surface :pointer) (x :int) (y :int) (width :int) (height :int))
 (cffi:defcfun ("cairo_surface_mark_dirty" cairo-surface-mark-dirty) :void (surface :pointer))
 (cffi:defcfun ("cairo_surface_flush" cairo-surface-flush) :void (surface :pointer))
 (cffi:defcfun ("cairo_surface_get_font_options" cairo-surface-get-font-options) :void
  (surface :pointer) (options :pointer))
 (cffi:defcfun ("cairo_surface_set_user_data" cairo-surface-set-user-data) cairo-status-t
  (surface :pointer) (key :pointer) (user_data :pointer) (destroy cairo-destroy-func-t))
 (cffi:defcfun ("cairo_surface_get_user_data" cairo-surface-get-user-data) :pointer
  (surface :pointer) (key :pointer))
 (cffi:defcfun ("cairo_surface_write_to_png_stream" cairo-surface-write-to-png-stream)
  cairo-status-t (surface :pointer) (write_func cairo-write-func-t) (closure :pointer))
 (cffi:defcfun ("cairo_surface_write_to_png" cairo-surface-write-to-png) cairo-status-t
  (surface :pointer) (filename :string))
 (cffi:defcfun ("cairo_surface_get_content" cairo-surface-get-content) cairo-content-t
  (surface :pointer))
 (cffi:defcfun ("cairo_surface_get_type" cairo-surface-get-type) cairo-surface-type-t
  (surface :pointer))
 (cffi:defcfun ("cairo_surface_status" cairo-surface-status) cairo-status-t (surface :pointer))
 (cffi:defcfun ("cairo_surface_get_reference_count" cairo-surface-get-reference-count)
  :unsigned-int (surface :pointer))
 (cffi:defcfun ("cairo_surface_destroy" cairo-surface-destroy) :void (surface :pointer))
 (cffi:defcfun ("cairo_surface_finish" cairo-surface-finish) :void (surface :pointer))
 (cffi:defcfun ("cairo_surface_reference" cairo-surface-reference) :pointer (surface :pointer))
 (cffi:defcfun ("cairo_surface_create_similar" cairo-surface-create-similar) :pointer
  (other :pointer) (content cairo-content-t) (width :int) (height :int))
 (cffi:defcfun ("cairo_status_to_string" cairo-status-to-string) :string (status cairo-status-t))
 (cffi:defcfun ("cairo_status" cairo-status) cairo-status-t (cr :pointer))
 (cffi:defcfun ("cairo_path_destroy" cairo-path-destroy) :void (path :pointer))
 (cffi:defcfun ("cairo_append_path" cairo-append-path) :void (cr :pointer) (path :pointer))
 (cffi:defcfun ("cairo_copy_path_flat" cairo-copy-path-flat) :pointer (cr :pointer))
 (cffi:defcfun ("cairo_copy_path" cairo-copy-path) :pointer (cr :pointer))
 (cffi:defcfun ("cairo_get_group_target" cairo-get-group-target) :pointer (cr :pointer))
 (cffi:defcfun ("cairo_get_target" cairo-get-target) :pointer (cr :pointer))
 (cffi:defcfun ("cairo_get_matrix" cairo-get-matrix) :void (cr :pointer) (matrix :pointer))
 (cffi:defcfun ("cairo_get_dash" cairo-get-dash) :void (cr :pointer) (dashes :pointer)
  (offset :pointer))
 (cffi:defcfun ("cairo_get_dash_count" cairo-get-dash-count) :int (cr :pointer))
 (cffi:defcfun ("cairo_get_miter_limit" cairo-get-miter-limit) :double (cr :pointer))
 (cffi:defcfun ("cairo_get_line_join" cairo-get-line-join) cairo-line-join-t (cr :pointer))
 (cffi:defcfun ("cairo_get_line_cap" cairo-get-line-cap) cairo-line-cap-t (cr :pointer))
 (cffi:defcfun ("cairo_get_line_width" cairo-get-line-width) :double (cr :pointer))
 (cffi:defcfun ("cairo_get_fill_rule" cairo-get-fill-rule) cairo-fill-rule-t (cr :pointer))
 (cffi:defcfun ("cairo_get_current_point" cairo-get-current-point) :void (cr :pointer) (x :pointer)
  (y :pointer))
 (cffi:defcfun ("cairo_get_antialias" cairo-get-antialias) cairo-antialias-t (cr :pointer))
 (cffi:defcfun ("cairo_get_tolerance" cairo-get-tolerance) :double (cr :pointer))
 (cffi:defcfun ("cairo_get_source" cairo-get-source) :pointer (cr :pointer))
 (cffi:defcfun ("cairo_get_operator" cairo-get-operator) cairo-operator-t (cr :pointer))
 (cffi:defcfun ("cairo_scaled_font_get_font_options" cairo-scaled-font-get-font-options) :void
  (scaled_font :pointer) (options :pointer))
 (cffi:defcfun ("cairo_scaled_font_get_ctm" cairo-scaled-font-get-ctm) :void (scaled_font :pointer)
  (ctm :pointer))
 (cffi:defcfun ("cairo_scaled_font_get_font_matrix" cairo-scaled-font-get-font-matrix) :void
  (scaled_font :pointer) (font_matrix :pointer))
 (cffi:defcfun ("cairo_scaled_font_get_font_face" cairo-scaled-font-get-font-face) :pointer
  (scaled_font :pointer))
 (cffi:defcfun ("cairo_scaled_font_glyph_extents" cairo-scaled-font-glyph-extents) :void
  (scaled_font :pointer) (glyphs :pointer) (num_glyphs :int) (extents :pointer))
 (cffi:defcfun ("cairo_scaled_font_text_extents" cairo-scaled-font-text-extents) :void
  (scaled_font :pointer) (utf8 :string) (extents :pointer))
 (cffi:defcfun ("cairo_scaled_font_extents" cairo-scaled-font-extents) :void (scaled_font :pointer)
  (extents :pointer))
 (cffi:defcfun ("cairo_scaled_font_set_user_data" cairo-scaled-font-set-user-data) cairo-status-t
  (scaled_font :pointer) (key :pointer) (user_data :pointer) (destroy cairo-destroy-func-t))
 (cffi:defcfun ("cairo_scaled_font_get_user_data" cairo-scaled-font-get-user-data) :pointer
  (scaled_font :pointer) (key :pointer))
 (cffi:defcfun ("cairo_scaled_font_get_type" cairo-scaled-font-get-type) cairo-font-type-t
  (scaled_font :pointer))
 (cffi:defcfun ("cairo_scaled_font_status" cairo-scaled-font-status) cairo-status-t
  (scaled_font :pointer))
 (cffi:defcfun ("cairo_scaled_font_get_reference_count" cairo-scaled-font-get-reference-count)
  :unsigned-int (scaled_font :pointer))
 (cffi:defcfun ("cairo_scaled_font_destroy" cairo-scaled-font-destroy) :void
  (scaled_font :pointer))
 (cffi:defcfun ("cairo_scaled_font_reference" cairo-scaled-font-reference) :pointer
  (scaled_font :pointer))
 (cffi:defcfun ("cairo_scaled_font_create" cairo-scaled-font-create) :pointer (font_face :pointer)
  (font_matrix :pointer) (ctm :pointer) (options :pointer))
 (cffi:defcfun ("cairo_font_face_set_user_data" cairo-font-face-set-user-data) cairo-status-t
  (font_face :pointer) (key :pointer) (user_data :pointer) (destroy cairo-destroy-func-t))
 (cffi:defcfun ("cairo_font_face_get_user_data" cairo-font-face-get-user-data) :pointer
  (font_face :pointer) (key :pointer))
 (cffi:defcfun ("cairo_font_face_get_type" cairo-font-face-get-type) cairo-font-type-t
  (font_face :pointer))
 (cffi:defcfun ("cairo_font_face_status" cairo-font-face-status) cairo-status-t
  (font_face :pointer))
 (cffi:defcfun ("cairo_font_face_get_reference_count" cairo-font-face-get-reference-count)
  :unsigned-int (font_face :pointer))
 (cffi:defcfun ("cairo_font_face_destroy" cairo-font-face-destroy) :void (font_face :pointer))
 (cffi:defcfun ("cairo_font_face_reference" cairo-font-face-reference) :pointer
  (font_face :pointer))
 (cffi:defcfun ("cairo_font_extents" cairo-font-extents) :void (cr :pointer) (extents :pointer))
 (cffi:defcfun ("cairo_glyph_extents" cairo-glyph-extents) :void (cr :pointer) (glyphs :pointer)
  (num_glyphs :int) (extents :pointer))
 (cffi:defcfun ("cairo_text_extents" cairo-text-extents) :void (cr :pointer) (utf8 :string)
  (extents :pointer))
 (cffi:defcfun ("cairo_glyph_path" cairo-glyph-path) :void (cr :pointer) (glyphs :pointer)
  (num_glyphs :int))
 (cffi:defcfun ("cairo_text_path" cairo-text-path) :void (cr :pointer) (utf8 :string))
 (cffi:defcfun ("cairo_show_glyphs" cairo-show-glyphs) :void (cr :pointer) (glyphs :pointer)
  (num_glyphs :int))
 (cffi:defcfun ("cairo_show_text" cairo-show-text) :void (cr :pointer) (utf8 :string))
 (cffi:defcfun ("cairo_get_scaled_font" cairo-get-scaled-font) :pointer (cr :pointer))
 (cffi:defcfun ("cairo_set_scaled_font" cairo-set-scaled-font) :void (cr :pointer)
  (scaled_font :pointer))
 (cffi:defcfun ("cairo_get_font_face" cairo-get-font-face) :pointer (cr :pointer))
 (cffi:defcfun ("cairo_set_font_face" cairo-set-font-face) :void (cr :pointer)
  (font_face :pointer))
 (cffi:defcfun ("cairo_get_font_options" cairo-get-font-options) :void (cr :pointer)
  (options :pointer))
 (cffi:defcfun ("cairo_set_font_options" cairo-set-font-options) :void (cr :pointer)
  (options :pointer))
 (cffi:defcfun ("cairo_get_font_matrix" cairo-get-font-matrix) :void (cr :pointer)
  (matrix :pointer))
 (cffi:defcfun ("cairo_set_font_matrix" cairo-set-font-matrix) :void (cr :pointer)
  (matrix :pointer))
 (cffi:defcfun ("cairo_set_font_size" cairo-set-font-size) :void (cr :pointer) (size :double))
 (cffi:defcfun ("cairo_select_font_face" cairo-select-font-face) :void (cr :pointer)
  (family :string) (slant cairo-font-slant-t) (weight cairo-font-weight-t))
 (cffi:defcfun ("cairo_font_options_get_hint_metrics" cairo-font-options-get-hint-metrics)
  cairo-hint-metrics-t (options :pointer))
 (cffi:defcfun ("cairo_font_options_set_hint_metrics" cairo-font-options-set-hint-metrics) :void
  (options :pointer) (hint_metrics cairo-hint-metrics-t))
 (cffi:defcfun ("cairo_font_options_get_hint_style" cairo-font-options-get-hint-style)
  cairo-hint-style-t (options :pointer))
 (cffi:defcfun ("cairo_font_options_set_hint_style" cairo-font-options-set-hint-style) :void
  (options :pointer) (hint_style cairo-hint-style-t))
 (cffi:defcfun ("cairo_font_options_get_subpixel_order" cairo-font-options-get-subpixel-order)
  cairo-subpixel-order-t (options :pointer))
 (cffi:defcfun ("cairo_font_options_set_subpixel_order" cairo-font-options-set-subpixel-order)
  :void (options :pointer) (subpixel_order cairo-subpixel-order-t))
 (cffi:defcfun ("cairo_font_options_get_antialias" cairo-font-options-get-antialias)
  cairo-antialias-t (options :pointer))
 (cffi:defcfun ("cairo_font_options_set_antialias" cairo-font-options-set-antialias) :void
  (options :pointer) (antialias cairo-antialias-t))
 (cffi:defcfun ("cairo_font_options_hash" cairo-font-options-hash) :unsigned-long
  (options :pointer))
 (cffi:defcfun ("cairo_font_options_equal" cairo-font-options-equal) cairo-bool-t
  (options :pointer) (other :pointer))
 (cffi:defcfun ("cairo_font_options_merge" cairo-font-options-merge) :void (options :pointer)
  (other :pointer))
 (cffi:defcfun ("cairo_font_options_status" cairo-font-options-status) cairo-status-t
  (options :pointer))
 (cffi:defcfun ("cairo_font_options_destroy" cairo-font-options-destroy) :void (options :pointer))
 (cffi:defcfun ("cairo_font_options_copy" cairo-font-options-copy) :pointer (original :pointer))
 (cffi:defcfun ("cairo_font_options_create" cairo-font-options-create) :pointer)
 (cffi:defcfun ("cairo_rectangle_list_destroy" cairo-rectangle-list-destroy) :void
  (rectangle_list :pointer))
 (cffi:defcfun ("cairo_copy_clip_rectangle_list" cairo-copy-clip-rectangle-list) :pointer
  (cr :pointer))
 (cffi:defcfun ("cairo_clip_extents" cairo-clip-extents) :void (cr :pointer) (x1 :pointer)
  (y1 :pointer) (x2 :pointer) (y2 :pointer))
 (cffi:defcfun ("cairo_clip_preserve" cairo-clip-preserve) :void (cr :pointer))
 (cffi:defcfun ("cairo_clip" cairo-clip) :void (cr :pointer))
 (cffi:defcfun ("cairo_reset_clip" cairo-reset-clip) :void (cr :pointer))
 (cffi:defcfun ("cairo_fill_extents" cairo-fill-extents) :void (cr :pointer) (x1 :pointer)
  (y1 :pointer) (x2 :pointer) (y2 :pointer))
 (cffi:defcfun ("cairo_stroke_extents" cairo-stroke-extents) :void (cr :pointer) (x1 :pointer)
  (y1 :pointer) (x2 :pointer) (y2 :pointer))
 (cffi:defcfun ("cairo_in_fill" cairo-in-fill) cairo-bool-t (cr :pointer) (x :double) (y :double))
 (cffi:defcfun ("cairo_in_stroke" cairo-in-stroke) cairo-bool-t (cr :pointer) (x :double)
  (y :double))
 (cffi:defcfun ("cairo_show_page" cairo-show-page) :void (cr :pointer))
 (cffi:defcfun ("cairo_copy_page" cairo-copy-page) :void (cr :pointer))
 (cffi:defcfun ("cairo_fill_preserve" cairo-fill-preserve) :void (cr :pointer))
 (cffi:defcfun ("cairo_fill" cairo-fill) :void (cr :pointer))
 (cffi:defcfun ("cairo_stroke_preserve" cairo-stroke-preserve) :void (cr :pointer))
 (cffi:defcfun ("cairo_stroke" cairo-stroke) :void (cr :pointer))
 (cffi:defcfun ("cairo_mask_surface" cairo-mask-surface) :void (cr :pointer) (surface :pointer)
  (surface_x :double) (surface_y :double))
 (cffi:defcfun ("cairo_mask" cairo-mask) :void (cr :pointer) (pattern :pointer))
 (cffi:defcfun ("cairo_paint_with_alpha" cairo-paint-with-alpha) :void (cr :pointer)
  (alpha :double))
 (cffi:defcfun ("cairo_paint" cairo-paint) :void (cr :pointer))
 (cffi:defcfun ("cairo_close_path" cairo-close-path) :void (cr :pointer))
 (cffi:defcfun ("cairo_rectangle" cairo-rectangle) :void (cr :pointer) (x :double) (y :double)
  (width :double) (height :double))
 (cffi:defcfun ("cairo_rel_curve_to" cairo-rel-curve-to) :void (cr :pointer) (dx1 :double)
  (dy1 :double) (dx2 :double) (dy2 :double) (dx3 :double) (dy3 :double))
 (cffi:defcfun ("cairo_rel_line_to" cairo-rel-line-to) :void (cr :pointer) (dx :double)
  (dy :double))
 (cffi:defcfun ("cairo_rel_move_to" cairo-rel-move-to) :void (cr :pointer) (dx :double)
  (dy :double))
 (cffi:defcfun ("cairo_arc_negative" cairo-arc-negative) :void (cr :pointer) (xc :double)
  (yc :double) (radius :double) (angle1 :double) (angle2 :double))
 (cffi:defcfun ("cairo_arc" cairo-arc) :void (cr :pointer) (xc :double) (yc :double)
  (radius :double) (angle1 :double) (angle2 :double))
 (cffi:defcfun ("cairo_curve_to" cairo-curve-to) :void (cr :pointer) (x1 :double) (y1 :double)
  (x2 :double) (y2 :double) (x3 :double) (y3 :double))
 (cffi:defcfun ("cairo_line_to" cairo-line-to) :void (cr :pointer) (x :double) (y :double))
 (cffi:defcfun ("cairo_new_sub_path" cairo-new-sub-path) :void (cr :pointer))
 (cffi:defcfun ("cairo_move_to" cairo-move-to) :void (cr :pointer) (x :double) (y :double))
 (cffi:defcfun ("cairo_new_path" cairo-new-path) :void (cr :pointer))
 (cffi:defcfun ("cairo_device_to_user_distance" cairo-device-to-user-distance) :void (cr :pointer)
  (dx :pointer) (dy :pointer))
 (cffi:defcfun ("cairo_device_to_user" cairo-device-to-user) :void (cr :pointer) (x :pointer)
  (y :pointer))
 (cffi:defcfun ("cairo_user_to_device_distance" cairo-user-to-device-distance) :void (cr :pointer)
  (dx :pointer) (dy :pointer))
 (cffi:defcfun ("cairo_user_to_device" cairo-user-to-device) :void (cr :pointer) (x :pointer)
  (y :pointer))
 (cffi:defcfun ("cairo_identity_matrix" cairo-identity-matrix) :void (cr :pointer))
 (cffi:defcfun ("cairo_set_matrix" cairo-set-matrix) :void (cr :pointer) (matrix :pointer))
 (cffi:defcfun ("cairo_transform" cairo-transform) :void (cr :pointer) (matrix :pointer))
 (cffi:defcfun ("cairo_rotate" cairo-rotate) :void (cr :pointer) (angle :double))
 (cffi:defcfun ("cairo_scale" cairo-scale) :void (cr :pointer) (sx :double) (sy :double))
 (cffi:defcfun ("cairo_translate" cairo-translate) :void (cr :pointer) (tx :double) (ty :double))
 (cffi:defcfun ("cairo_set_miter_limit" cairo-set-miter-limit) :void (cr :pointer) (limit :double))
 (cffi:defcfun ("cairo_set_dash" cairo-set-dash) :void (cr :pointer) (dashes :pointer)
  (num_dashes :int) (offset :double))
 (cffi:defcfun ("cairo_set_line_join" cairo-set-line-join) :void (cr :pointer)
  (line_join cairo-line-join-t))
 (cffi:defcfun ("cairo_set_line_cap" cairo-set-line-cap) :void (cr :pointer)
  (line_cap cairo-line-cap-t))
 (cffi:defcfun ("cairo_set_line_width" cairo-set-line-width) :void (cr :pointer) (width :double))
 (cffi:defcfun ("cairo_set_fill_rule" cairo-set-fill-rule) :void (cr :pointer)
  (fill_rule cairo-fill-rule-t))
 (cffi:defcfun ("cairo_set_antialias" cairo-set-antialias) :void (cr :pointer)
  (antialias cairo-antialias-t))
 (cffi:defcfun ("cairo_set_tolerance" cairo-set-tolerance) :void (cr :pointer) (tolerance :double))
 (cffi:defcfun ("cairo_set_source_surface" cairo-set-source-surface) :void (cr :pointer)
  (surface :pointer) (x :double) (y :double))
 (cffi:defcfun ("cairo_set_source_rgba" cairo-set-source-rgba) :void (cr :pointer) (red :double)
  (green :double) (blue :double) (alpha :double))
 (cffi:defcfun ("cairo_set_source_rgb" cairo-set-source-rgb) :void (cr :pointer) (red :double)
  (green :double) (blue :double))
 (cffi:defcfun ("cairo_set_source" cairo-set-source) :void (cr :pointer) (source :pointer))
 (cffi:defcfun ("cairo_set_operator" cairo-set-operator) :void (cr :pointer) (op cairo-operator-t))
 (cffi:defcfun ("cairo_pop_group_to_source" cairo-pop-group-to-source) :void (cr :pointer))
 (cffi:defcfun ("cairo_pop_group" cairo-pop-group) :pointer (cr :pointer))
 (cffi:defcfun ("cairo_push_group_with_content" cairo-push-group-with-content) :void (cr :pointer)
  (content cairo-content-t))
 (cffi:defcfun ("cairo_push_group" cairo-push-group) :void (cr :pointer))
 (cffi:defcfun ("cairo_restore" cairo-restore) :void (cr :pointer))
 (cffi:defcfun ("cairo_save" cairo-save) :void (cr :pointer))
 (cffi:defcfun ("cairo_set_user_data" cairo-set-user-data) cairo-status-t (cr :pointer)
  (key :pointer) (user_data :pointer) (destroy cairo-destroy-func-t))
 (cffi:defcfun ("cairo_get_user_data" cairo-get-user-data) :pointer (cr :pointer) (key :pointer))
 (cffi:defcfun ("cairo_get_reference_count" cairo-get-reference-count) :unsigned-int (cr :pointer))
 (cffi:defcfun ("cairo_destroy" cairo-destroy) :void (cr :pointer))
 (cffi:defcfun ("cairo_reference" cairo-reference) :pointer (cr :pointer))
 (cffi:defcfun ("cairo_create" cairo-create) :pointer (target :pointer))
 (cffi:defcfun ("cairo_version_string" cairo-version-string) :string)
 (cffi:defcfun ("cairo_version" cairo-version) :int))
