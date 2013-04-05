;;; WARNING: This is a generated file, editing it is not advised!
(in-package :cl-user)
(asdf:operate 'asdf:load-op :verrazano-runtime)
(DEFPACKAGE :IMAGEMAGICK-CFFI-BINDINGS (:USE :CFFI) (:NICKNAMES)
            (:EXPORT "CLONE-DRAW-INFO" "DESTROY-DRAW-INFO" "DRAW-AFFINE-IMAGE" "DRAW-CLIP-PATH"
             "DRAW-IMAGE" "DRAW-PATTERN-PATH" "DRAW-PRIMITIVE" "GET-AFFINE-MATRIX" "GET-DRAW-INFO"
             "CONSTITUTE-IMAGE" "PING-IMAGE" "READ-IMAGE" "READ-INLINE-IMAGE" "WRITE-IMAGE"
             "WRITE-IMAGES" "DESTROY-CONSTITUTE" "ACQUIRE-IMAGE-PIXELS" "CATCH-IMAGE-EXCEPTION"
             "ALLOCATE-IMAGE" "APPEND-IMAGES" "AVERAGE-IMAGES" "CLONE-IMAGE" "CLONE-IMAGES"
             "COMBINE-IMAGES" "DESTROY-IMAGE" "GET-IMAGE-CLIP-MASK" "NEW-MAGICK-IMAGE"
             "REFERENCE-IMAGE" "CLONE-IMAGE-INFO" "DESTROY-IMAGE-INFO" "GET-IMAGE-TYPE"
             "GET-INDEXES" "ALLOCATE-IMAGE-COLORMAP" "CLIP-IMAGE" "CLIP-PATH-IMAGE"
             "CYCLE-COLORMAP-IMAGE" "GRADIENT-IMAGE" "IS-TAINT-IMAGE" "IS-MAGICK-CONFLICT"
             "LIST-MAGICK-INFO" "PLASMA-IMAGE" "SEPARATE-IMAGE-CHANNEL" "SET-IMAGE-CLIP-MASK"
             "SET-IMAGE-EXTENT" "SET-IMAGE-INFO" "SET-IMAGE-TYPE" "SORT-COLORMAP-BY-INTENSITY"
             "STRIP-IMAGE" "SYNC-IMAGE" "SYNC-IMAGE-PIXELS" "TEXTURE-IMAGE" "ACQUIRE-ONE-PIXEL"
             "GET-IMAGE-PIXELS" "GET-ONE-PIXEL" "GET-PIXELS" "SET-IMAGE-PIXELS"
             "ALLOCATE-NEXT-IMAGE" "DESTROY-IMAGE-PIXELS" "GET-IMAGE-EXCEPTION" "GET-IMAGE-INFO"
             "MODIFY-IMAGE" "RELINQUISH-IMAGE-RESOURCES" "SET-IMAGE-BACKGROUND-COLOR"
             "SET-IMAGE-INFO-BLOB" "SET-IMAGE-INFO-FILE" "SET-IMAGE-OPACITY" "MAGNIFY-IMAGE"
             "MINIFY-IMAGE" "RESIZE-IMAGE" "SAMPLE-IMAGE" "SCALE-IMAGE" "THUMBNAIL-IMAGE"
             "ZOOM-IMAGE" "PIXEL-GET-EXCEPTION" "PIXEL-GET-COLOR-AS-STRING" "PIXEL-GET-ALPHA"
             "PIXEL-GET-BLACK" "PIXEL-GET-BLUE" "PIXEL-GET-CYAN" "PIXEL-GET-GREEN"
             "PIXEL-GET-MAGENTA" "PIXEL-GET-OPACITY" "PIXEL-GET-RED" "PIXEL-GET-YELLOW"
             "PIXEL-GET-INDEX" "IS-PIXEL-WAND" "IS-PIXEL-WAND-SIMILAR" "PIXEL-CLEAR-EXCEPTION"
             "PIXEL-SET-COLOR" "DESTROY-PIXEL-WAND" "DESTROY-PIXEL-WANDS" "NEW-PIXEL-WAND"
             "NEW-PIXEL-WANDS" "PIXEL-GET-ALPHA-QUANTUM" "PIXEL-GET-BLACK-QUANTUM"
             "PIXEL-GET-BLUE-QUANTUM" "PIXEL-GET-CYAN-QUANTUM" "PIXEL-GET-GREEN-QUANTUM"
             "PIXEL-GET-MAGENTA-QUANTUM" "PIXEL-GET-OPACITY-QUANTUM" "PIXEL-GET-RED-QUANTUM"
             "PIXEL-GET-YELLOW-QUANTUM" "PIXEL-GET-COLOR-COUNT" "CLEAR-PIXEL-WAND"
             "PIXEL-GET-MAGICK-COLOR" "PIXEL-GET-QUANTUM-COLOR" "PIXEL-SET-ALPHA"
             "PIXEL-SET-ALPHA-QUANTUM" "PIXEL-SET-BLACK" "PIXEL-SET-BLACK-QUANTUM" "PIXEL-SET-BLUE"
             "PIXEL-SET-BLUE-QUANTUM" "PIXEL-SET-COLOR-COUNT" "PIXEL-SET-CYAN"
             "PIXEL-SET-CYAN-QUANTUM" "PIXEL-SET-GREEN" "PIXEL-SET-GREEN-QUANTUM" "PIXEL-SET-INDEX"
             "PIXEL-SET-MAGENTA" "PIXEL-SET-MAGENTA-QUANTUM" "PIXEL-SET-OPACITY"
             "PIXEL-SET-OPACITY-QUANTUM" "PIXEL-SET-QUANTUM-COLOR" "PIXEL-SET-RED"
             "PIXEL-SET-RED-QUANTUM" "PIXEL-SET-YELLOW" "PIXEL-SET-YELLOW-QUANTUM"
             "DRAW-GET-TEXT-ALIGNMENT" "DRAW-GET-CLIP-PATH" "DRAW-GET-EXCEPTION" "DRAW-GET-FONT"
             "DRAW-GET-FONT-FAMILY" "DRAW-GET-TEXT-ENCODING" "DRAW-GET-VECTOR-GRAPHICS"
             "DRAW-GET-CLIP-UNITS" "DRAW-GET-TEXT-DECORATION" "DRAW-GET-FILL-ALPHA"
             "DRAW-GET-FONT-SIZE" "DRAW-GET-STROKE-DASH-ARRAY" "DRAW-GET-STROKE-DASH-OFFSET"
             "DRAW-GET-STROKE-ALPHA" "DRAW-GET-STROKE-WIDTH" "PEEK-DRAWING-WAND"
             "CLONE-DRAWING-WAND" "DESTROY-DRAWING-WAND" "DRAW-ALLOCATE-WAND" "NEW-DRAWING-WAND"
             "DRAW-GET-CLIP-RULE" "DRAW-GET-FILL-RULE" "DRAW-GET-GRAVITY"
             "DRAW-GET-STROKE-LINE-CAP" "DRAW-GET-STROKE-LINE-JOIN" "DRAW-CLEAR-EXCEPTION"
             "DRAW-COMPOSITE" "DRAW-GET-STROKE-ANTIALIAS" "DRAW-GET-TEXT-ANTIALIAS"
             "DRAW-POP-PATTERN" "DRAW-PUSH-PATTERN" "DRAW-RENDER" "DRAW-SET-CLIP-PATH"
             "DRAW-SET-FILL-PATTERN-URL" "DRAW-SET-FONT" "DRAW-SET-FONT-FAMILY"
             "DRAW-SET-STROKE-DASH-ARRAY" "DRAW-SET-STROKE-PATTERN-URL" "DRAW-SET-VECTOR-GRAPHICS"
             "IS-DRAWING-WAND" "POP-DRAWING-WAND" "PUSH-DRAWING-WAND" "DRAW-GET-FONT-STRETCH"
             "DRAW-GET-FONT-STYLE" "DRAW-GET-FONT-WEIGHT" "DRAW-GET-STROKE-MITER-LIMIT"
             "CLEAR-DRAWING-WAND" "DRAW-AFFINE" "DRAW-ANNOTATION" "DRAW-ARC" "DRAW-BEZIER"
             "DRAW-CIRCLE" "DRAW-COLOR" "DRAW-COMMENT" "DRAW-ELLIPSE" "DRAW-GET-FILL-COLOR"
             "DRAW-GET-STROKE-COLOR" "DRAW-GET-TEXT-UNDER-COLOR" "DRAW-LINE" "DRAW-MATTE"
             "DRAW-PATH-CLOSE" "DRAW-PATH-CURVE-TO-ABSOLUTE" "DRAW-PATH-CURVE-TO-RELATIVE"
             "DRAW-PATH-CURVE-TO-QUADRATIC-BEZIER-ABSOLUTE"
             "DRAW-PATH-CURVE-TO-QUADRATIC-BEZIER-RELATIVE"
             "DRAW-PATH-CURVE-TO-QUADRATIC-BEZIER-SMOOTH-ABSOLUTE"
             "DRAW-PATH-CURVE-TO-QUADRATIC-BEZIER-SMOOTH-RELATIVE"
             "DRAW-PATH-CURVE-TO-SMOOTH-ABSOLUTE" "DRAW-PATH-CURVE-TO-SMOOTH-RELATIVE"
             "DRAW-PATH-ELLIPTIC-ARC-ABSOLUTE" "DRAW-PATH-ELLIPTIC-ARC-RELATIVE" "DRAW-PATH-FINISH"
             "DRAW-PATH-LINE-TO-ABSOLUTE" "DRAW-PATH-LINE-TO-RELATIVE"
             "DRAW-PATH-LINE-TO-HORIZONTAL-ABSOLUTE" "DRAW-PATH-LINE-TO-HORIZONTAL-RELATIVE"
             "DRAW-PATH-LINE-TO-VERTICAL-ABSOLUTE" "DRAW-PATH-LINE-TO-VERTICAL-RELATIVE"
             "DRAW-PATH-MOVE-TO-ABSOLUTE" "DRAW-PATH-MOVE-TO-RELATIVE" "DRAW-PATH-START"
             "DRAW-POINT" "DRAW-POLYGON" "DRAW-POLYLINE" "DRAW-POP-CLIP-PATH" "DRAW-POP-DEFS"
             "DRAW-PUSH-CLIP-PATH" "DRAW-PUSH-DEFS" "DRAW-RECTANGLE" "DRAW-ROTATE"
             "DRAW-ROUND-RECTANGLE" "DRAW-SCALE" "DRAW-SET-CLIP-RULE" "DRAW-SET-CLIP-UNITS"
             "DRAW-SET-FILL-COLOR" "DRAW-SET-FILL-ALPHA" "DRAW-SET-FILL-RULE" "DRAW-SET-FONT-SIZE"
             "DRAW-SET-FONT-STRETCH" "DRAW-SET-FONT-STYLE" "DRAW-SET-FONT-WEIGHT"
             "DRAW-SET-GRAVITY" "DRAW-SKEW-X" "DRAW-SKEW-Y" "DRAW-SET-STROKE-ANTIALIAS"
             "DRAW-SET-STROKE-COLOR" "DRAW-SET-STROKE-DASH-OFFSET" "DRAW-SET-STROKE-LINE-CAP"
             "DRAW-SET-STROKE-LINE-JOIN" "DRAW-SET-STROKE-MITER-LIMIT" "DRAW-SET-STROKE-ALPHA"
             "DRAW-SET-STROKE-WIDTH" "DRAW-SET-TEXT-ALIGNMENT" "DRAW-SET-TEXT-ANTIALIAS"
             "DRAW-SET-TEXT-DECORATION" "DRAW-SET-TEXT-ENCODING" "DRAW-SET-TEXT-UNDER-COLOR"
             "DRAW-SET-VIEWBOX" "DRAW-TRANSLATE" "DRAW-GET-FILL-OPACITY" "DRAW-GET-STROKE-OPACITY"
             "DRAW-PEEK-GRAPHIC-WAND" "DRAW-POP-GRAPHIC-CONTEXT" "DRAW-PUSH-GRAPHIC-CONTEXT"
             "DRAW-SET-FILL-OPACITY" "DRAW-SET-STROKE-OPACITY" "MAGICK-GET-EXCEPTION"
             "MAGICK-GET-FILENAME" "MAGICK-GET-FORMAT" "MAGICK-GET-HOME-URL" "MAGICK-GET-OPTION"
             "MAGICK-QUERY-CONFIGURE-OPTION" "MAGICK-QUERY-CONFIGURE-OPTIONS" "MAGICK-QUERY-FONTS"
             "MAGICK-QUERY-FORMATS" "MAGICK-GET-COMPRESSION" "MAGICK-GET-COPYRIGHT"
             "MAGICK-GET-PACKAGE-NAME" "MAGICK-GET-QUANTUM-DEPTH" "MAGICK-GET-QUANTUM-RANGE"
             "MAGICK-GET-RELEASE-DATE" "MAGICK-GET-VERSION" "MAGICK-GET-SAMPLING-FACTORS"
             "MAGICK-QUERY-FONT-METRICS" "MAGICK-QUERY-MULTILINE-FONT-METRICS"
             "MAGICK-GET-INTERLACE-SCHEME" "MAGICK-GET-PAGE" "MAGICK-GET-SIZE"
             "MAGICK-SET-BACKGROUND-COLOR" "MAGICK-SET-COMPRESSION"
             "MAGICK-SET-COMPRESSION-QUALITY" "MAGICK-SET-FILENAME" "MAGICK-SET-FORMAT"
             "MAGICK-SET-INTERLACE-SCHEME" "MAGICK-SET-OPTION" "MAGICK-SET-PAGE"
             "MAGICK-SET-PASSPHRASE" "MAGICK-SET-RESOLUTION" "MAGICK-SET-RESOURCE-LIMIT"
             "MAGICK-SET-SAMPLING-FACTORS" "MAGICK-SET-SIZE" "MAGICK-SET-TYPE"
             "MAGICK-SET-PROGRESS-MONITOR" "MAGICK-GET-COMPRESSION-QUALITY" "MAGICK-GET-RESOURCE"
             "MAGICK-GET-RESOURCE-LIMIT" "MAGICK-GET-IMAGE-CHANNEL-STATISTICS"
             "MAGICK-GET-IMAGE-ATTRIBUTE" "MAGICK-GET-IMAGE-FILENAME" "MAGICK-GET-IMAGE-FORMAT"
             "MAGICK-GET-IMAGE-SIGNATURE" "MAGICK-IDENTIFY-IMAGE" "MAGICK-GET-IMAGE-COMPOSE"
             "MAGICK-GET-IMAGE-COLORSPACE" "MAGICK-GET-IMAGE-COMPRESSION"
             "MAGICK-GET-IMAGE-DISPOSE" "MAGICK-GET-IMAGE-GAMMA"
             "MAGICK-GET-IMAGE-TOTAL-INK-DENSITY" "GET-IMAGE-FROM-MAGICK-WAND"
             "MAGICK-GET-IMAGE-TYPE" "MAGICK-GET-IMAGE-INTERLACE-SCHEME" "MAGICK-GET-IMAGE-INDEX"
             "MAGICK-ADAPTIVE-THRESHOLD-IMAGE" "MAGICK-ADD-IMAGE" "MAGICK-ADD-NOISE-IMAGE"
             "MAGICK-AFFINE-TRANSFORM-IMAGE" "MAGICK-ANNOTATE-IMAGE" "MAGICK-ANIMATE-IMAGES"
             "MAGICK-BLACK-THRESHOLD-IMAGE" "MAGICK-BLUR-IMAGE" "MAGICK-BLUR-IMAGE-CHANNEL"
             "MAGICK-BORDER-IMAGE" "MAGICK-CHARCOAL-IMAGE" "MAGICK-CHOP-IMAGE" "MAGICK-CLIP-IMAGE"
             "MAGICK-CLIP-PATH-IMAGE" "MAGICK-COLOR-FLOODFILL-IMAGE" "MAGICK-COLORIZE-IMAGE"
             "MAGICK-COMMENT-IMAGE" "MAGICK-COMPOSITE-IMAGE" "MAGICK-CONSTITUTE-IMAGE"
             "MAGICK-CONTRAST-IMAGE" "MAGICK-CONVOLVE-IMAGE" "MAGICK-CONVOLVE-IMAGE-CHANNEL"
             "MAGICK-CROP-IMAGE" "MAGICK-CYCLE-COLORMAP-IMAGE" "MAGICK-DESPECKLE-IMAGE"
             "MAGICK-DISPLAY-IMAGE" "MAGICK-DISPLAY-IMAGES" "MAGICK-DRAW-IMAGE" "MAGICK-EDGE-IMAGE"
             "MAGICK-EMBOSS-IMAGE" "MAGICK-ENHANCE-IMAGE" "MAGICK-EQUALIZE-IMAGE"
             "MAGICK-EVALUATE-IMAGE" "MAGICK-EVALUATE-IMAGE-CHANNEL" "MAGICK-FLIP-IMAGE"
             "MAGICK-FLOP-IMAGE" "MAGICK-FRAME-IMAGE" "MAGICK-GAMMA-IMAGE"
             "MAGICK-GAMMA-IMAGE-CHANNEL" "MAGICK-GAUSSIAN-BLUR-IMAGE"
             "MAGICK-GAUSSIAN-BLUR-IMAGE-CHANNEL" "MAGICK-GET-IMAGE-BACKGROUND-COLOR"
             "MAGICK-GET-IMAGE-BLUE-PRIMARY" "MAGICK-GET-IMAGE-BORDER-COLOR"
             "MAGICK-GET-IMAGE-CHANNEL-DISTORTION" "MAGICK-GET-IMAGE-DISTORTION"
             "MAGICK-GET-IMAGE-CHANNEL-EXTREMA" "MAGICK-GET-IMAGE-CHANNEL-MEAN"
             "MAGICK-GET-IMAGE-COLORMAP-COLOR" "MAGICK-GET-IMAGE-EXTREMA"
             "MAGICK-GET-IMAGE-GREEN-PRIMARY" "MAGICK-GET-IMAGE-MATTE-COLOR"
             "MAGICK-GET-IMAGE-PAGE" "MAGICK-GET-IMAGE-PIXEL-COLOR" "MAGICK-GET-IMAGE-PIXELS"
             "MAGICK-GET-IMAGE-RED-PRIMARY" "MAGICK-GET-IMAGE-RESOLUTION"
             "MAGICK-GET-IMAGE-WHITE-POINT" "MAGICK-HAS-NEXT-IMAGE" "MAGICK-HAS-PREVIOUS-IMAGE"
             "MAGICK-IMPLODE-IMAGE" "MAGICK-LABEL-IMAGE" "MAGICK-LEVEL-IMAGE"
             "MAGICK-LEVEL-IMAGE-CHANNEL" "MAGICK-MAGNIFY-IMAGE" "MAGICK-MAP-IMAGE"
             "MAGICK-MATTE-FLOODFILL-IMAGE" "MAGICK-MEDIAN-FILTER-IMAGE" "MAGICK-MINIFY-IMAGE"
             "MAGICK-MODULATE-IMAGE" "MAGICK-MOTION-BLUR-IMAGE" "MAGICK-NEGATE-IMAGE"
             "MAGICK-NEGATE-IMAGE-CHANNEL" "MAGICK-NEW-IMAGE" "MAGICK-NEXT-IMAGE"
             "MAGICK-NORMALIZE-IMAGE" "MAGICK-OIL-PAINT-IMAGE" "MAGICK-PAINT-OPAQUE-IMAGE"
             "MAGICK-PAINT-TRANSPARENT-IMAGE" "MAGICK-PING-IMAGE" "MAGICK-POSTERIZE-IMAGE"
             "MAGICK-PREVIOUS-IMAGE" "MAGICK-PROFILE-IMAGE" "MAGICK-QUANTIZE-IMAGE"
             "MAGICK-QUANTIZE-IMAGES" "MAGICK-RADIAL-BLUR-IMAGE" "MAGICK-RADIAL-BLUR-IMAGE-CHANNEL"
             "MAGICK-RAISE-IMAGE" "MAGICK-READ-IMAGE" "MAGICK-READ-IMAGE-BLOB"
             "MAGICK-READ-IMAGE-FILE" "MAGICK-REDUCE-NOISE-IMAGE" "MAGICK-REMOVE-IMAGE"
             "MAGICK-RESAMPLE-IMAGE" "MAGICK-RESIZE-IMAGE" "MAGICK-ROLL-IMAGE"
             "MAGICK-ROTATE-IMAGE" "MAGICK-SAMPLE-IMAGE" "MAGICK-SCALE-IMAGE"
             "MAGICK-SEPARATE-IMAGE-CHANNEL" "MAGICK-SEPIA-TONE-IMAGE" "MAGICK-SET-IMAGE"
             "MAGICK-SET-IMAGE-ATTRIBUTE" "MAGICK-SET-IMAGE-BACKGROUND-COLOR"
             "MAGICK-SET-IMAGE-BIAS" "MAGICK-SET-IMAGE-BLUE-PRIMARY"
             "MAGICK-SET-IMAGE-BORDER-COLOR" "MAGICK-SET-IMAGE-CHANNEL-DEPTH"
             "MAGICK-SET-IMAGE-COLORMAP-COLOR" "MAGICK-SET-IMAGE-COMPOSE"
             "MAGICK-SET-IMAGE-COMPRESSION" "MAGICK-SET-IMAGE-DELAY" "MAGICK-SET-IMAGE-DEPTH"
             "MAGICK-SET-IMAGE-DISPOSE" "MAGICK-SET-IMAGE-COLORSPACE"
             "MAGICK-SET-IMAGE-COMPRESSION-QUALITY" "MAGICK-SET-IMAGE-GREEN-PRIMARY"
             "MAGICK-SET-IMAGE-GAMMA" "MAGICK-SET-IMAGE-EXTENT" "MAGICK-SET-IMAGE-FILENAME"
             "MAGICK-SET-IMAGE-FORMAT" "MAGICK-SET-IMAGE-INDEX" "MAGICK-SET-IMAGE-INTERLACE-SCHEME"
             "MAGICK-SET-IMAGE-ITERATIONS" "MAGICK-SET-IMAGE-MATTE-COLOR" "MAGICK-SET-IMAGE-PAGE"
             "MAGICK-SET-IMAGE-PIXELS" "MAGICK-SET-IMAGE-PROFILE" "MAGICK-SET-IMAGE-RED-PRIMARY"
             "MAGICK-SET-IMAGE-RENDERING-INTENT" "MAGICK-SET-IMAGE-RESOLUTION"
             "MAGICK-SET-IMAGE-SCENE" "MAGICK-SET-IMAGE-TICKS-PER-SECOND" "MAGICK-SET-IMAGE-TYPE"
             "MAGICK-SET-IMAGE-UNITS" "MAGICK-SET-IMAGE-VIRTUAL-PIXEL-METHOD"
             "MAGICK-SET-IMAGE-WHITE-POINT" "MAGICK-SHADOW-IMAGE" "MAGICK-SHARPEN-IMAGE"
             "MAGICK-SHARPEN-IMAGE-CHANNEL" "MAGICK-SHAVE-IMAGE" "MAGICK-SHEAR-IMAGE"
             "MAGICK-SIGMOIDAL-CONTRAST-IMAGE" "MAGICK-SIGMOIDAL-CONTRAST-IMAGE-CHANNEL"
             "MAGICK-SOLARIZE-IMAGE" "MAGICK-SPLICE-IMAGE" "MAGICK-SPREAD-IMAGE"
             "MAGICK-STRIP-IMAGE" "MAGICK-SWIRL-IMAGE" "MAGICK-TINT-IMAGE" "MAGICK-THRESHOLD-IMAGE"
             "MAGICK-THRESHOLD-IMAGE-CHANNEL" "MAGICK-THUMBNAIL-IMAGE" "MAGICK-TRIM-IMAGE"
             "MAGICK-UNSHARP-MASK-IMAGE" "MAGICK-UNSHARP-MASK-IMAGE-CHANNEL" "MAGICK-WAVE-IMAGE"
             "MAGICK-WHITE-THRESHOLD-IMAGE" "MAGICK-WRITE-IMAGE" "MAGICK-WRITE-IMAGE-FILE"
             "MAGICK-WRITE-IMAGES" "MAGICK-WRITE-IMAGES-FILE" "MAGICK-SET-IMAGE-PROGRESS-MONITOR"
             "MAGICK-GET-IMAGE-SIZE" "MAGICK-APPEND-IMAGES" "MAGICK-AVERAGE-IMAGES"
             "MAGICK-COALESCE-IMAGES" "MAGICK-COMBINE-IMAGES" "MAGICK-COMPARE-IMAGE-CHANNELS"
             "MAGICK-COMPARE-IMAGES" "MAGICK-DECONSTRUCT-IMAGES" "MAGICK-FLATTEN-IMAGES"
             "MAGICK-FX-IMAGE" "MAGICK-FX-IMAGE-CHANNEL" "MAGICK-GET-IMAGE"
             "MAGICK-GET-IMAGE-REGION" "MAGICK-MORPH-IMAGES" "MAGICK-MOSAIC-IMAGES"
             "MAGICK-MONTAGE-IMAGE" "MAGICK-PREVIEW-IMAGES" "MAGICK-STEGANO-IMAGE"
             "MAGICK-STEREO-IMAGE" "MAGICK-TEXTURE-IMAGE" "MAGICK-TRANSFORM-IMAGE"
             "NEW-MAGICK-WAND-FROM-IMAGE" "MAGICK-GET-IMAGE-HISTOGRAM"
             "MAGICK-GET-IMAGE-RENDERING-INTENT" "MAGICK-GET-IMAGE-UNITS" "MAGICK-GET-IMAGE-BLOB"
             "MAGICK-GET-IMAGES-BLOB" "MAGICK-GET-IMAGE-PROFILE" "MAGICK-REMOVE-IMAGE-PROFILE"
             "MAGICK-GET-IMAGE-COLORS" "MAGICK-GET-IMAGE-COMPRESSION-QUALITY"
             "MAGICK-GET-IMAGE-DELAY" "MAGICK-GET-IMAGE-CHANNEL-DEPTH" "MAGICK-GET-IMAGE-DEPTH"
             "MAGICK-GET-IMAGE-HEIGHT" "MAGICK-GET-IMAGE-ITERATIONS" "MAGICK-GET-IMAGE-SCENE"
             "MAGICK-GET-IMAGE-TICKS-PER-SECOND" "MAGICK-GET-IMAGE-WIDTH"
             "MAGICK-GET-NUMBER-IMAGES" "MAGICK-GET-IMAGE-VIRTUAL-PIXEL-METHOD"
             "MAGICK-DESCRIBE-IMAGE" "MAGICK-OPAQUE-IMAGE" "MAGICK-SET-IMAGE-OPTION"
             "MAGICK-TRANSPARENT-IMAGE" "MAGICK-REGION-OF-INTEREST-IMAGE" "MAGICK-WRITE-IMAGE-BLOB"
             "PIXEL-GET-ITERATOR-EXCEPTION" "IS-PIXEL-ITERATOR" "PIXEL-CLEAR-ITERATOR-EXCEPTION"
             "PIXEL-SET-ITERATOR-ROW" "PIXEL-SYNC-ITERATOR" "DESTROY-PIXEL-ITERATOR"
             "NEW-PIXEL-ITERATOR" "NEW-PIXEL-REGION-ITERATOR" "PIXEL-GET-NEXT-ITERATOR-ROW"
             "PIXEL-GET-PREVIOUS-ITERATOR-ROW" "CLEAR-PIXEL-ITERATOR" "PIXEL-RESET-ITERATOR"
             "PIXEL-SET-FIRST-ITERATOR-ROW" "PIXEL-SET-LAST-ITERATOR-ROW"
             "PIXEL-ITERATOR-GET-EXCEPTION" "PIXEL-GET-NEXT-ROW" "IS-MAGICK-WAND"
             "MAGICK-CLEAR-EXCEPTION" "CLONE-MAGICK-WAND" "DESTROY-MAGICK-WAND" "NEW-MAGICK-WAND"
             "CLEAR-MAGICK-WAND" "MAGICK-WAND-GENESIS" "MAGICK-WAND-TERMINUS"
             "MAGICK-RELINQUISH-MEMORY" "MAGICK-RESET-ITERATOR" "MAGICK-SET-FIRST-ITERATOR"
             "MAGICK-SET-LAST-ITERATOR" "TRANSMIT-TYPE" "RESOURCE-TYPE" "NOISE-TYPE"
             "MAGICK-EVALUATE-OPERATOR" "STORAGE-TYPE" "METRIC-TYPE" "MONTAGE-MODE"
             "VIRTUAL-PIXEL-METHOD" "PAINT-METHOD" "PRIMITIVE-TYPE" "CLIP-PATH-UNITS" "ALIGN-TYPE"
             "STRETCH-TYPE" "STYLE-TYPE" "DECORATION-TYPE" "LINE-JOIN" "LINE-CAP" "FILL-RULE"
             "REFERENCE-TYPE" "SPREAD-METHOD" "GRADIENT-TYPE" "CHANNEL-TYPE" "PREVIEW-TYPE"
             "IMAGE-TYPE" "DISPOSE-TYPE" "COMPOSITE-OPERATOR" "GRAVITY-TYPE" "ENDIAN-TYPE"
             "INTERLACE-TYPE" "FILTER-TYPES" "RESOLUTION-TYPE" "RENDERING-INTENT"
             "MAGICK-BOOLEAN-TYPE" "ORIENTATION-TYPE" "COMPRESSION-TYPE" "COLORSPACE-TYPE"
             "CLASS-TYPE" "EXCEPTION-TYPE" "TIMER-STATE" "TYPE-METRIC" "PRIMITIVE-INFO"
             "IMAGE-INFO" "MAGICK-PIXEL-PACKET" "INDEX-PACKET" "DRAW-CONTEXT" "DRAW-INFO"
             "CHANNEL-STATISTICS" "MAGICK-SIZE-TYPE" "DRAWING-WAND" "PIXEL-ITERATOR" "PIXEL-WAND"
             "MAGICK-WAND" "MAGICK-REAL-TYPE" "POINT-INFO" "ELEMENT-REFERENCE" "AFFINE-MATRIX"
             "GRADIENT-INFO" "SEGMENT-INFO" "FILE" "STREAM-HANDLER" "IMAGE" "PROFILE-INFO"
             "SEMAPHORE-INFO" "EXCEPTION-INFO" "MAGICK-PROGRESS-MONITOR" "TIMER-INFO" "ERROR-INFO"
             "RECTANGLE-INFO" "CHROMATICITY-INFO" "PIXEL-PACKET" "PRIMARY-INFO" "TIMER" "QUANTUM"
             "SIZE-T" "SEMAPHORE-INFO"))

(in-package :IMAGEMAGICK-CFFI-BINDINGS)
(cffi:defcstruct _io-marker (_next :pointer) (_sbuf :pointer) (_pos :int))
(cffi::defctype* _-off-t :long)
(cffi::defctype* _io-lock-t :void)
(cffi::defctype* _-off-64-t _-quad-t)
(cffi::defctype* _-quad-t :long-long)
(cffi::defctype* size-t :unsigned-int)
(cffi:defcstruct _io-file (_flags :int) (_io-read-ptr :pointer) (_io-read-end :pointer)
 (_io-read-base :pointer) (_io-write-base :pointer) (_io-write-ptr :pointer)
 (_io-write-end :pointer) (_io-buf-base :pointer) (_io-buf-end :pointer) (_io-save-base :pointer)
 (_io-backup-base :pointer) (_io-save-end :pointer) (_markers :pointer) (_chain :pointer)
 (_fileno :int) (_flags-2 :int) (_old-offset _-off-t) (_cur-column :short) (_vtable-offset :char)
 (_shortbuf :char :count 0) (_lock :pointer) (_offset _-off-64-t) (_-pad-1 :pointer)
 (_-pad-2 :pointer) (_-pad-3 :pointer) (_-pad-4 :pointer) (_-pad-5 size-t) (_mode :int)
 (_unused-2 :char :count 39))
(cffi:defcstruct _a-ffine-matrix (sx :double) (rx :double) (ry :double) (sy :double) (tx :double)
 (ty :double))
(cffi::defctype* quantum :short)
(cffi:defcstruct _p-ixel-packet (blue quantum) (green quantum) (red quantum) (opacity quantum))
(cffi:defcstruct _e-rror-info (mean-error-per-pixel :double) (normalized-mean-error :double)
 (normalized-maximum-error :double))
(cffi:defcstruct _p-rimary-info (x :double) (y :double) (z :double))
(cffi:defcstruct _p-rofile-info (name :pointer) (length size-t) (info :pointer)
 (signature :unsigned-long))
(cffi:defcstruct _r-ectangle-info (width :unsigned-long) (height :unsigned-long) (x :long)
 (y :long))
(cffi:defcstruct _s-egment-info (x1 :double) (y1 :double) (x2 :double) (y2 :double))
(cffi:defcstruct _t-imer (start :double) (stop :double) (total :double))
(cffi::defctype* timer _t-imer)
(cffi:defcenum timer-state (:undefined-timer-state 0) (:stopped-timer-state 1)
 (:running-timer-state 2))
(cffi:defcstruct _t-imer-info (user timer) (elapsed timer) (state timer-state)
 (signature :unsigned-long))
(cffi::defctype* primary-info _p-rimary-info)
(cffi:defcstruct _c-hromaticity-info (red-primary primary-info) (green-primary primary-info)
 (blue-primary primary-info) (white-point primary-info))
(cffi:defcenum exception-type (:undefined-exception 0) (:resource-limit-warning 300)
 (:type-warning 305) (:option-warning 310) (:delegate-warning 315) (:missing-delegate-warning 320)
 (:corrupt-image-warning 325) (:file-open-warning 330) (:blob-warning 335) (:stream-warning 340)
 (:cache-warning 345) (:coder-warning 350) (:module-warning 355) (:draw-warning 360)
 (:image-warning 365) (:wand-warning 370) (:xs-erver-warning 380) (:monitor-warning 385)
 (:registry-warning 390) (:configure-warning 395) (:resource-limit-error 400) (:type-error 405)
 (:option-error 410) (:delegate-error 415) (:missing-delegate-error 420) (:corrupt-image-error 425)
 (:file-open-error 430) (:blob-error 435) (:stream-error 440) (:cache-error 445) (:coder-error 450)
 (:module-error 455) (:draw-error 460) (:image-error 465) (:wand-error 470) (:xs-erver-error 480)
 (:monitor-error 485) (:registry-error 490) (:configure-error 495)
 (:resource-limit-fatal-error 700) (:type-fatal-error 705) (:option-fatal-error 710)
 (:delegate-fatal-error 715) (:missing-delegate-fatal-error 720) (:corrupt-image-fatal-error 725)
 (:file-open-fatal-error 730) (:blob-fatal-error 735) (:stream-fatal-error 740)
 (:cache-fatal-error 745) (:coder-fatal-error 750) (:module-fatal-error 755)
 (:draw-fatal-error 760) (:image-fatal-error 765) (:wand-fatal-error 770)
 (:xs-erver-fatal-error 780) (:monitor-fatal-error 785) (:registry-fatal-error 790)
 (:configure-fatal-error 795))
(cffi:defcstruct _e-xception-info (severity exception-type) (error-number :int) (reason :pointer)
 (description :pointer) (signature :unsigned-long))
(cffi:defcenum class-type (:undefined-class 0) (:direct-class 1) (:pseudo-class 2))
(cffi:defcenum colorspace-type (:undefined-colorspace 0) (:rgbc-olorspace 1) (:grayc-olorspace 2)
 (:transparent-colorspace 3) (:ohtac-olorspace 4) (:labc-olorspace 5) (:xyzc-olorspace 6)
 (:yc-bc-rc-olorspace 7) (:yccc-olorspace 8) (:yiqc-olorspace 9) (:yp-bp-rc-olorspace 10)
 (:yuvc-olorspace 11) (:cmykc-olorspace 12) (:srgbc-olorspace 13) (:hsbc-olorspace 14)
 (:hslc-olorspace 15) (:hwbc-olorspace 16) (:rec-601-l-uma-colorspace 17)
 (:rec-709-l-uma-colorspace 18) (:log-colorspace 19))
(cffi:defcenum compression-type (:undefined-compression 0) (:no-compression 1)
 (:bz-ip-compression 2) (:fax-compression 3) (:group-4-c-ompression 4) (:jpegc-ompression 5)
 (:jpeg-2000-compression 6) (:lossless-jpegc-ompression 7) (:lzwc-ompression 8)
 (:rlec-ompression 9) (:zip-compression 10))
(cffi:defcenum orientation-type (:undefined-orientation 0) (:top-left-orientation 1)
 (:top-right-orientation 2) (:bottom-right-orientation 3) (:bottom-left-orientation 4)
 (:left-top-orientation 5) (:right-top-orientation 6) (:right-bottom-orientation 7)
 (:left-bottom-orientation 8))
(cffi:defcenum magick-boolean-type (:magick-false 0) (:magick-true 1))
(cffi::defctype* pixel-packet _p-ixel-packet)
(cffi::defctype* chromaticity-info _c-hromaticity-info)
(cffi:defcenum rendering-intent (:undefined-intent 0) (:saturation-intent 1) (:perceptual-intent 2)
 (:absolute-intent 3) (:relative-intent 4))
(cffi:defcenum resolution-type (:undefined-resolution 0) (:pixels-per-inch-resolution 1)
 (:pixels-per-centimeter-resolution 2))
(cffi::defctype* rectangle-info _r-ectangle-info)
(cffi:defcenum filter-types (:undefined-filter 0) (:point-filter 1) (:box-filter 2)
 (:triangle-filter 3) (:hermite-filter 4) (:hanning-filter 5) (:hamming-filter 6)
 (:blackman-filter 7) (:gaussian-filter 8) (:quadratic-filter 9) (:cubic-filter 10)
 (:catrom-filter 11) (:mitchell-filter 12) (:lanczos-filter 13) (:bessel-filter 14)
 (:sinc-filter 15))
(cffi:defcenum interlace-type (:undefined-interlace 0) (:no-interlace 1) (:line-interlace 2)
 (:plane-interlace 3) (:partition-interlace 4))
(cffi:defcenum endian-type (:undefined-endian 0) (:lsbe-ndian 1) (:msbe-ndian 2))
(cffi:defcenum gravity-type (:forget-gravity 0) (:north-west-gravity 1) (:north-gravity 2)
 (:north-east-gravity 3) (:west-gravity 4) (:center-gravity 5) (:east-gravity 6)
 (:south-west-gravity 7) (:south-gravity 8) (:south-east-gravity 9) (:static-gravity 10))
(cffi:defcenum composite-operator (:undefined-composite-op 0) (:no-composite-op 1)
 (:add-composite-op 2) (:atop-composite-op 3) (:blend-composite-op 4) (:bumpmap-composite-op 5)
 (:clear-composite-op 6) (:color-burn-composite-op 7) (:color-dodge-composite-op 8)
 (:colorize-composite-op 9) (:copy-black-composite-op 10) (:copy-blue-composite-op 11)
 (:copy-composite-op 12) (:copy-cyan-composite-op 13) (:copy-green-composite-op 14)
 (:copy-magenta-composite-op 15) (:copy-opacity-composite-op 16) (:copy-red-composite-op 17)
 (:copy-yellow-composite-op 18) (:darken-composite-op 19) (:dst-atop-composite-op 20)
 (:dst-composite-op 21) (:dst-in-composite-op 22) (:dst-out-composite-op 23)
 (:dst-over-composite-op 24) (:difference-composite-op 25) (:displace-composite-op 26)
 (:dissolve-composite-op 27) (:exclusion-composite-op 28) (:hard-light-composite-op 29)
 (:hue-composite-op 30) (:in-composite-op 31) (:lighten-composite-op 32)
 (:luminize-composite-op 33) (:minus-composite-op 34) (:modulate-composite-op 35)
 (:multiply-composite-op 36) (:out-composite-op 37) (:over-composite-op 38)
 (:overlay-composite-op 39) (:plus-composite-op 40) (:replace-composite-op 41)
 (:saturate-composite-op 42) (:screen-composite-op 43) (:soft-light-composite-op 44)
 (:src-atop-composite-op 45) (:src-composite-op 46) (:src-in-composite-op 47)
 (:src-out-composite-op 48) (:src-over-composite-op 49) (:subtract-composite-op 50)
 (:threshold-composite-op 51) (:xor-composite-op 52))
(cffi:defcenum dispose-type (:undefined-dispose 0) (:none-dispose 1) (:background-dispose 2)
 (:previous-dispose 3))
(cffi::defctype* error-info _e-rror-info)
(cffi::defctype* timer-info _t-imer-info)
(cffi::defctype* magick-progress-monitor :pointer)
(cffi::defctype* _a-scii-85-i-nfo- _a-scii-85-i-nfo)
(cffi:defcstruct _a-scii-85-i-nfo)
(cffi::defctype* _b-lob-info- _b-lob-info)
(cffi:defcstruct _b-lob-info)
(cffi::defctype* exception-info _e-xception-info)
(cffi::defctype* semaphore-info semaphore-info)
(cffi:defcstruct semaphore-info)
(cffi::defctype* profile-info _p-rofile-info)
(cffi:defcstruct _i-mage (storage-class class-type) (colorspace colorspace-type)
 (compression compression-type) (quality :unsigned-long) (orientation orientation-type)
 (taint magick-boolean-type) (matte magick-boolean-type) (columns :unsigned-long)
 (rows :unsigned-long) (depth :unsigned-long) (colors :unsigned-long) (colormap :pointer)
 (background-color pixel-packet) (border-color pixel-packet) (matte-color pixel-packet)
 (gamma :double) (chromaticity chromaticity-info) (rendering-intent rendering-intent)
 (profiles :pointer) (units resolution-type) (montage :pointer) (directory :pointer)
 (geometry :pointer) (offset :long) (x-resolution :double) (y-resolution :double)
 (page rectangle-info) (extract-info rectangle-info) (tile-info rectangle-info) (bias :double)
 (blur :double) (fuzz :double) (filter filter-types) (interlace interlace-type)
 (endian endian-type) (gravity gravity-type) (compose composite-operator) (dispose dispose-type)
 (clip-mask :pointer) (scene :unsigned-long) (delay :unsigned-long)
 (ticks-per-second :unsigned-long) (iterations :unsigned-long) (total-colors :unsigned-long)
 (start-loop :long) (error error-info) (timer timer-info)
 (progress-monitor magick-progress-monitor) (client-data :pointer) (cache :pointer)
 (attributes :pointer) (ascii-85 :pointer) (blob :pointer) (filename :char :count 4095)
 (magick-filename :char :count 4095) (magick :char :count 4095) (magick-columns :unsigned-long)
 (magick-rows :unsigned-long) (exception exception-info) (debug magick-boolean-type)
 (reference-count :long) (semaphore :pointer) (color-profile profile-info)
 (iptc-profile profile-info) (generic-profile :pointer) (generic-profiles :unsigned-long)
 (signature :unsigned-long) (previous :pointer) (list :pointer) (next :pointer))
(cffi:defcenum image-type (:undefined-type 0) (:bilevel-type 1) (:grayscale-type 2)
 (:grayscale-matte-type 3) (:palette-type 4) (:palette-matte-type 5) (:true-color-type 6)
 (:true-color-matte-type 7) (:color-separation-type 8) (:color-separation-matte-type 9)
 (:optimize-type 10))
(cffi:defcenum preview-type (:undefined-preview 0) (:rotate-preview 1) (:shear-preview 2)
 (:roll-preview 3) (:hue-preview 4) (:saturation-preview 5) (:brightness-preview 6)
 (:gamma-preview 7) (:spiff-preview 8) (:dull-preview 9) (:grayscale-preview 10)
 (:quantize-preview 11) (:despeckle-preview 12) (:reduce-noise-preview 13) (:add-noise-preview 14)
 (:sharpen-preview 15) (:blur-preview 16) (:threshold-preview 17) (:edge-detect-preview 18)
 (:spread-preview 19) (:solarize-preview 20) (:shade-preview 21) (:raise-preview 22)
 (:segment-preview 23) (:swirl-preview 24) (:implode-preview 25) (:wave-preview 26)
 (:oil-paint-preview 27) (:charcoal-drawing-preview 28) (:jpegp-review 29))
(cffi:defcenum channel-type (:undefined-channel 0) (:cyan-channel 1) (:magenta-channel 2)
 (:yellow-channel 4) (:matte-channel 8) (:index-channel 32) (:all-channels 255))
(cffi::defctype* image _i-mage)
(cffi::defctype* stream-handler :pointer)
(cffi::defctype* file _io-file)
(cffi:defcstruct _i-mage-info (compression compression-type) (orientation orientation-type)
 (temporary magick-boolean-type) (adjoin magick-boolean-type) (affirm magick-boolean-type)
 (antialias magick-boolean-type) (size :pointer) (extract :pointer) (page :pointer)
 (scenes :pointer) (scene :unsigned-long) (number-scenes :unsigned-long) (depth :unsigned-long)
 (interlace interlace-type) (endian endian-type) (units resolution-type) (quality :unsigned-long)
 (sampling-factor :pointer) (server-name :pointer) (font :pointer) (texture :pointer)
 (density :pointer) (pointsize :double) (fuzz :double) (background-color pixel-packet)
 (border-color pixel-packet) (matte-color pixel-packet) (dither magick-boolean-type)
 (monochrome magick-boolean-type) (colors :unsigned-long) (colorspace colorspace-type)
 (type image-type) (preview-type preview-type) (group :long) (ping magick-boolean-type)
 (verbose magick-boolean-type) (view :pointer) (authenticate :pointer) (channel channel-type)
 (attributes :pointer) (options :pointer) (progress-monitor magick-progress-monitor)
 (client-data :pointer) (cache :pointer) (stream stream-handler) (file :pointer) (blob :pointer)
 (length size-t) (magick :char :count 4095) (unique :char :count 4095) (zero :char :count 4095)
 (filename :char :count 4095) (debug magick-boolean-type) (tile :pointer) (subimage :unsigned-long)
 (subrange :unsigned-long) (pen pixel-packet) (signature :unsigned-long))
(cffi:defcenum gradient-type (:undefined-gradient 0) (:linear-gradient 1) (:radial-gradient 2))
(cffi::defctype* segment-info _s-egment-info)
(cffi:defcenum spread-method (:undefined-spread 0) (:pad-spread 1) (:reflect-spead 2)
 (:repeat-spread 3))
(cffi:defcstruct _g-radient-info (type gradient-type) (color pixel-packet) (stop segment-info)
 (length :unsigned-long) (spread spread-method) (debug magick-boolean-type)
 (signature :unsigned-long) (previous :pointer) (next :pointer))
(cffi:defcenum reference-type (:undefined-reference 0) (:gradient-reference 1))
(cffi::defctype* gradient-info _g-radient-info)
(cffi:defcstruct _e-lement-reference (id :pointer) (type reference-type) (gradient gradient-info)
 (signature :unsigned-long) (previous :pointer) (next :pointer))
(cffi::defctype* affine-matrix _a-ffine-matrix)
(cffi:defcenum fill-rule (:undefined-rule 0) (:even-odd-rule 1) (:non-zero-rule 2))
(cffi:defcenum line-cap (:undefined-cap 0) (:butt-cap 1) (:round-cap 2) (:square-cap 3))
(cffi:defcenum line-join (:undefined-join 0) (:miter-join 1) (:round-join 2) (:bevel-join 3))
(cffi:defcenum decoration-type (:undefined-decoration 0) (:no-decoration 1)
 (:underline-decoration 2) (:overline-decoration 3) (:line-through-decoration 4))
(cffi:defcenum style-type (:undefined-style 0) (:normal-style 1) (:italic-style 2)
 (:oblique-style 3) (:any-style 4))
(cffi:defcenum stretch-type (:undefined-stretch 0) (:normal-stretch 1) (:ultra-condensed-stretch 2)
 (:extra-condensed-stretch 3) (:condensed-stretch 4) (:semi-condensed-stretch 5)
 (:semi-expanded-stretch 6) (:expanded-stretch 7) (:extra-expanded-stretch 8)
 (:ultra-expanded-stretch 9) (:any-stretch 10))
(cffi:defcenum align-type (:undefined-align 0) (:left-align 1) (:center-align 2) (:right-align 3))
(cffi:defcenum clip-path-units (:undefined-path-units 0) (:user-space 1) (:user-space-on-use 2)
 (:object-bounding-box 3))
(cffi::defctype* element-reference _e-lement-reference)
(cffi:defcstruct _d-raw-info (primitive :pointer) (geometry :pointer) (viewbox rectangle-info)
 (affine affine-matrix) (gravity gravity-type) (fill pixel-packet) (stroke pixel-packet)
 (stroke-width :double) (gradient gradient-info) (fill-pattern :pointer) (tile :pointer)
 (stroke-pattern :pointer) (stroke-antialias magick-boolean-type)
 (text-antialias magick-boolean-type) (fill-rule fill-rule) (linecap line-cap) (linejoin line-join)
 (miterlimit :unsigned-long) (dash-offset :double) (decorate decoration-type)
 (compose composite-operator) (text :pointer) (face :unsigned-long) (font :pointer)
 (metrics :pointer) (family :pointer) (style style-type) (stretch stretch-type)
 (weight :unsigned-long) (encoding :pointer) (pointsize :double) (density :pointer)
 (align align-type) (undercolor pixel-packet) (border-color pixel-packet) (server-name :pointer)
 (dash-pattern :pointer) (clip-path :pointer) (bounds segment-info) (clip-units clip-path-units)
 (opacity quantum) (render magick-boolean-type) (element-reference element-reference)
 (debug magick-boolean-type) (signature :unsigned-long))
(cffi:defcstruct _p-oint-info (x :double) (y :double))
(cffi::defctype* point-info _p-oint-info)
(cffi:defcenum primitive-type (:undefined-primitive 0) (:point-primitive 1) (:line-primitive 2)
 (:rectangle-primitive 3) (:round-rectangle-primitive 4) (:arc-primitive 5) (:ellipse-primitive 6)
 (:circle-primitive 7) (:polyline-primitive 8) (:polygon-primitive 9) (:bezier-primitive 10)
 (:color-primitive 11) (:matte-primitive 12) (:text-primitive 13) (:image-primitive 14)
 (:path-primitive 15))
(cffi:defcenum paint-method (:undefined-method 0) (:point-method 1) (:replace-method 2)
 (:floodfill-method 3) (:fill-to-border-method 4) (:reset-method 5))
(cffi:defcstruct _p-rimitive-info (point point-info) (coordinates :unsigned-long)
 (primitive primitive-type) (method paint-method) (text :pointer))
(cffi:defcstruct _t-ype-metric (pixels-per-em point-info) (ascent :double) (descent :double)
 (width :double) (height :double) (max-advance :double) (underline-position :double)
 (underline-thickness :double) (bounds segment-info))
(cffi::defctype* magick-real-type :double)
(cffi:defcstruct _m-agick-pixel-packet (colorspace colorspace-type) (matte magick-boolean-type)
 (fuzz :double) (depth :unsigned-long) (red magick-real-type) (green magick-real-type)
 (blue magick-real-type) (opacity magick-real-type) (index magick-real-type))
(cffi:defcstruct _c-hannel-statistics (depth :unsigned-long) (minima quantum) (maxima quantum)
 (mean :double) (standard-deviation :double) (scale :unsigned-long))
(cffi::defctype* magick-wand _m-agick-wand)
(cffi:defcstruct _m-agick-wand)
(cffi::defctype* pixel-wand _p-ixel-wand)
(cffi:defcstruct _p-ixel-wand)
(cffi::defctype* pixel-iterator _p-ixel-iterator)
(cffi:defcstruct _p-ixel-iterator)
(cffi:defcenum virtual-pixel-method (:undefined-virtual-pixel-method 0)
 (:background-virtual-pixel-method 1) (:constant-virtual-pixel-method 2)
 (:edge-virtual-pixel-method 3) (:mirror-virtual-pixel-method 4) (:tile-virtual-pixel-method 5)
 (:transparent-virtual-pixel-method 6))
(cffi::defctype* drawing-wand _d-rawing-wand)
(cffi:defcstruct _d-rawing-wand)
(cffi:defcenum montage-mode (:undefined-mode 0) (:frame-mode 1) (:unframe-mode 2)
 (:concatenate-mode 3))
(cffi:defcenum metric-type (:undefined-metric 0) (:mean-absolute-error-metric 1)
 (:mean-squared-error-metric 2) (:peak-absolute-error-metric 3)
 (:peak-signal-to-noise-ratio-metric 4) (:root-mean-squared-error-metric 5))
(cffi::defctype* magick-size-type :unsigned-long-long)
(cffi:defcenum storage-type (:undefined-pixel 0) (:char-pixel 1) (:double-pixel 2) (:float-pixel 3)
 (:integer-pixel 4) (:long-pixel 5) (:quantum-pixel 6) (:short-pixel 7))
(cffi:defcenum magick-evaluate-operator (:undefined-evaluate-operator 0) (:add-evaluate-operator 1)
 (:and-evaluate-operator 2) (:divide-evaluate-operator 3) (:left-shift-evaluate-operator 4)
 (:max-evaluate-operator 5) (:min-evaluate-operator 6) (:multiply-evaluate-operator 7)
 (:or-evaluate-operator 8) (:right-shift-evaluate-operator 9) (:set-evaluate-operator 10)
 (:subtract-evaluate-operator 11) (:xor-evaluate-operator 12))
(cffi:defcenum noise-type (:undefined-noise 0) (:uniform-noise 1) (:gaussian-noise 2)
 (:multiplicative-gaussian-noise 3) (:impulse-noise 4) (:laplacian-noise 5) (:poisson-noise 6))
(cffi::defctype* channel-statistics _c-hannel-statistics)
(cffi:defcenum resource-type (:undefined-resource 0) (:area-resource 1) (:disk-resource 2)
 (:file-resource 3) (:map-resource 4) (:memory-resource 5))
(cffi::defctype* draw-info _d-raw-info)
(cffi::defctype* draw-context :pointer)
(cffi::defctype* index-packet quantum)
(cffi::defctype* magick-pixel-packet _m-agick-pixel-packet)
(cffi::defctype* image-info _i-mage-info)
(cffi:defcenum transmit-type (:undefined-transmit-type 0) (:file-transmit-type 1)
 (:blob-transmit-type 2) (:stream-transmit-type 3) (:image-transmit-type 4))
(cffi::defctype* primitive-info _p-rimitive-info)
(cffi::defctype* type-metric _t-ype-metric)
(cl:progn (cffi:defcfun ("MagickSetLastIterator" magick-set-last-iterator) :void (arg1 :pointer))
 (cffi:defcfun ("MagickSetFirstIterator" magick-set-first-iterator) :void (arg1 :pointer))
 (cffi:defcfun ("MagickResetIterator" magick-reset-iterator) :void (arg1 :pointer))
 (cffi:defcfun ("MagickRelinquishMemory" magick-relinquish-memory) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickWandTerminus" magick-wand-terminus) :void)
 (cffi:defcfun ("MagickWandGenesis" magick-wand-genesis) :void)
 (cffi:defcfun ("ClearMagickWand" clear-magick-wand) :void (arg1 :pointer))
 (cffi:defcfun ("NewMagickWand" new-magick-wand) :pointer)
 (cffi:defcfun ("DestroyMagickWand" destroy-magick-wand) :pointer (arg1 :pointer))
 (cffi:defcfun ("CloneMagickWand" clone-magick-wand) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickClearException" magick-clear-exception) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("IsMagickWand" is-magick-wand) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("PixelGetNextRow" pixel-get-next-row) :pointer (arg1 :pointer))
 (cffi:defcfun ("PixelIteratorGetException" pixel-iterator-get-exception) :pointer (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("PixelSetLastIteratorRow" pixel-set-last-iterator-row) :void (arg1 :pointer))
 (cffi:defcfun ("PixelSetFirstIteratorRow" pixel-set-first-iterator-row) :void (arg1 :pointer))
 (cffi:defcfun ("PixelResetIterator" pixel-reset-iterator) :void (arg1 :pointer))
 (cffi:defcfun ("ClearPixelIterator" clear-pixel-iterator) :void (arg1 :pointer))
 (cffi:defcfun ("PixelGetPreviousIteratorRow" pixel-get-previous-iterator-row) :pointer
  (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("PixelGetNextIteratorRow" pixel-get-next-iterator-row) :pointer (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("NewPixelRegionIterator" new-pixel-region-iterator) :pointer (arg1 :pointer)
  (arg2 :long) (arg3 :long) (arg4 :unsigned-long) (arg5 :unsigned-long))
 (cffi:defcfun ("NewPixelIterator" new-pixel-iterator) :pointer (arg1 :pointer))
 (cffi:defcfun ("DestroyPixelIterator" destroy-pixel-iterator) :pointer (arg1 :pointer))
 (cffi:defcfun ("PixelSyncIterator" pixel-sync-iterator) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("PixelSetIteratorRow" pixel-set-iterator-row) magick-boolean-type (arg1 :pointer)
  (arg2 :long))
 (cffi:defcfun ("PixelClearIteratorException" pixel-clear-iterator-exception) magick-boolean-type
  (arg1 :pointer))
 (cffi:defcfun ("IsPixelIterator" is-pixel-iterator) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("PixelGetIteratorException" pixel-get-iterator-exception) :pointer (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("MagickWriteImageBlob" magick-write-image-blob) :pointer (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("MagickRegionOfInterestImage" magick-region-of-interest-image) :pointer
  (arg1 :pointer) (arg2 :unsigned-long) (arg3 :unsigned-long) (arg4 :long) (arg5 :long))
 (cffi:defcfun ("MagickTransparentImage" magick-transparent-image) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer) (arg3 quantum) (arg4 :double))
 (cffi:defcfun ("MagickSetImageOption" magick-set-image-option) magick-boolean-type (arg1 :pointer)
  (arg2 :string) (arg3 :string) (arg4 :string))
 (cffi:defcfun ("MagickOpaqueImage" magick-opaque-image) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 :pointer) (arg4 :double))
 (cffi:defcfun ("MagickDescribeImage" magick-describe-image) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageVirtualPixelMethod" magick-get-image-virtual-pixel-method)
  virtual-pixel-method (arg1 :pointer))
 (cffi:defcfun ("MagickGetNumberImages" magick-get-number-images) :unsigned-long (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageWidth" magick-get-image-width) :unsigned-long (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageTicksPerSecond" magick-get-image-ticks-per-second) :unsigned-long
  (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageScene" magick-get-image-scene) :unsigned-long (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageIterations" magick-get-image-iterations) :unsigned-long
  (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageHeight" magick-get-image-height) :unsigned-long (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageDepth" magick-get-image-depth) :unsigned-long (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageChannelDepth" magick-get-image-channel-depth) :unsigned-long
  (arg1 :pointer) (arg2 channel-type))
 (cffi:defcfun ("MagickGetImageDelay" magick-get-image-delay) :unsigned-long (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageCompressionQuality" magick-get-image-compression-quality)
  :unsigned-long (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageColors" magick-get-image-colors) :unsigned-long (arg1 :pointer))
 (cffi:defcfun ("MagickRemoveImageProfile" magick-remove-image-profile) :pointer (arg1 :pointer)
  (arg2 :string) (arg3 :pointer))
 (cffi:defcfun ("MagickGetImageProfile" magick-get-image-profile) :pointer (arg1 :pointer)
  (arg2 :string) (arg3 :pointer))
 (cffi:defcfun ("MagickGetImagesBlob" magick-get-images-blob) :pointer (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("MagickGetImageBlob" magick-get-image-blob) :pointer (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("MagickGetImageUnits" magick-get-image-units) resolution-type (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageRenderingIntent" magick-get-image-rendering-intent) rendering-intent
  (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageHistogram" magick-get-image-histogram) :pointer (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("NewMagickWandFromImage" new-magick-wand-from-image) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickTransformImage" magick-transform-image) :pointer (arg1 :pointer)
  (arg2 :string) (arg3 :string))
 (cffi:defcfun ("MagickTextureImage" magick-texture-image) :pointer (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("MagickStereoImage" magick-stereo-image) :pointer (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("MagickSteganoImage" magick-stegano-image) :pointer (arg1 :pointer) (arg2 :pointer)
  (arg3 :long))
 (cffi:defcfun ("MagickPreviewImages" magick-preview-images) :pointer (wand :pointer)
  (arg2 preview-type))
 (cffi:defcfun ("MagickMontageImage" magick-montage-image) :pointer (arg1 :pointer) (arg2 :pointer)
  (arg3 :string) (arg4 :string) (arg5 montage-mode) (arg6 :string))
 (cffi:defcfun ("MagickMosaicImages" magick-mosaic-images) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickMorphImages" magick-morph-images) :pointer (arg1 :pointer)
  (arg2 :unsigned-long))
 (cffi:defcfun ("MagickGetImageRegion" magick-get-image-region) :pointer (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long) (arg4 :long) (arg5 :long))
 (cffi:defcfun ("MagickGetImage" magick-get-image) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickFxImageChannel" magick-fx-image-channel) :pointer (arg1 :pointer)
  (arg2 channel-type) (arg3 :string))
 (cffi:defcfun ("MagickFxImage" magick-fx-image) :pointer (arg1 :pointer) (arg2 :string))
 (cffi:defcfun ("MagickFlattenImages" magick-flatten-images) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickDeconstructImages" magick-deconstruct-images) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickCompareImages" magick-compare-images) :pointer (arg1 :pointer)
  (arg2 :pointer) (arg3 metric-type) (arg4 :pointer))
 (cffi:defcfun ("MagickCompareImageChannels" magick-compare-image-channels) :pointer
  (arg1 :pointer) (arg2 :pointer) (arg3 channel-type) (arg4 metric-type) (arg5 :pointer))
 (cffi:defcfun ("MagickCombineImages" magick-combine-images) :pointer (arg1 :pointer)
  (arg2 channel-type))
 (cffi:defcfun ("MagickCoalesceImages" magick-coalesce-images) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickAverageImages" magick-average-images) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickAppendImages" magick-append-images) :pointer (arg1 :pointer)
  (arg2 magick-boolean-type))
 (cffi:defcfun ("MagickGetImageSize" magick-get-image-size) magick-size-type (arg1 :pointer))
 (cffi:defcfun ("MagickSetImageProgressMonitor" magick-set-image-progress-monitor)
  magick-progress-monitor (arg1 :pointer) (arg2 magick-progress-monitor) (arg3 :pointer))
 (cffi:defcfun ("MagickWriteImagesFile" magick-write-images-file) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("MagickWriteImages" magick-write-images) magick-boolean-type (arg1 :pointer)
  (arg2 :string) (arg3 magick-boolean-type))
 (cffi:defcfun ("MagickWriteImageFile" magick-write-image-file) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("MagickWriteImage" magick-write-image) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("MagickWhiteThresholdImage" magick-white-threshold-image) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("MagickWaveImage" magick-wave-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double) (arg3 :double))
 (cffi:defcfun ("MagickUnsharpMaskImageChannel" magick-unsharp-mask-image-channel)
  magick-boolean-type (arg1 :pointer) (arg2 channel-type) (arg3 :double) (arg4 :double)
  (arg5 :double) (arg6 :double))
 (cffi:defcfun ("MagickUnsharpMaskImage" magick-unsharp-mask-image) magick-boolean-type
  (arg1 :pointer) (arg2 :double) (arg3 :double) (arg4 :double) (arg5 :double))
 (cffi:defcfun ("MagickTrimImage" magick-trim-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double))
 (cffi:defcfun ("MagickThumbnailImage" magick-thumbnail-image) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long))
 (cffi:defcfun ("MagickThresholdImageChannel" magick-threshold-image-channel) magick-boolean-type
  (arg1 :pointer) (arg2 channel-type) (arg3 :double))
 (cffi:defcfun ("MagickThresholdImage" magick-threshold-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double))
 (cffi:defcfun ("MagickTintImage" magick-tint-image) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 :pointer))
 (cffi:defcfun ("MagickSwirlImage" magick-swirl-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double))
 (cffi:defcfun ("MagickStripImage" magick-strip-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("MagickSpreadImage" magick-spread-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double))
 (cffi:defcfun ("MagickSpliceImage" magick-splice-image) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long) (arg4 :long) (arg5 :long))
 (cffi:defcfun ("MagickSolarizeImage" magick-solarize-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double))
 (cffi:defcfun ("MagickSigmoidalContrastImageChannel" magick-sigmoidal-contrast-image-channel)
  magick-boolean-type (arg1 :pointer) (arg2 channel-type) (arg3 magick-boolean-type) (arg4 :double)
  (arg5 :double))
 (cffi:defcfun ("MagickSigmoidalContrastImage" magick-sigmoidal-contrast-image) magick-boolean-type
  (arg1 :pointer) (arg2 magick-boolean-type) (arg3 :double) (arg4 :double))
 (cffi:defcfun ("MagickShearImage" magick-shear-image) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 :double) (arg4 :double))
 (cffi:defcfun ("MagickShaveImage" magick-shave-image) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long))
 (cffi:defcfun ("MagickSharpenImageChannel" magick-sharpen-image-channel) magick-boolean-type
  (arg1 :pointer) (arg2 channel-type) (arg3 :double) (arg4 :double))
 (cffi:defcfun ("MagickSharpenImage" magick-sharpen-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double) (arg3 :double))
 (cffi:defcfun ("MagickShadowImage" magick-shadow-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double) (arg3 :double) (arg4 :long) (arg5 :long))
 (cffi:defcfun ("MagickSetImageWhitePoint" magick-set-image-white-point) magick-boolean-type
  (arg1 :pointer) (arg2 :double) (arg3 :double))
 (cffi:defcfun ("MagickSetImageVirtualPixelMethod" magick-set-image-virtual-pixel-method)
  magick-boolean-type (arg1 :pointer) (arg2 virtual-pixel-method))
 (cffi:defcfun ("MagickSetImageUnits" magick-set-image-units) magick-boolean-type (arg1 :pointer)
  (arg2 resolution-type))
 (cffi:defcfun ("MagickSetImageType" magick-set-image-type) magick-boolean-type (arg1 :pointer)
  (arg2 image-type))
 (cffi:defcfun ("MagickSetImageTicksPerSecond" magick-set-image-ticks-per-second)
  magick-boolean-type (arg1 :pointer) (arg2 :unsigned-long))
 (cffi:defcfun ("MagickSetImageScene" magick-set-image-scene) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long))
 (cffi:defcfun ("MagickSetImageResolution" magick-set-image-resolution) magick-boolean-type
  (arg1 :pointer) (arg2 :double) (arg3 :double))
 (cffi:defcfun ("MagickSetImageRenderingIntent" magick-set-image-rendering-intent)
  magick-boolean-type (arg1 :pointer) (arg2 rendering-intent))
 (cffi:defcfun ("MagickSetImageRedPrimary" magick-set-image-red-primary) magick-boolean-type
  (arg1 :pointer) (arg2 :double) (arg3 :double))
 (cffi:defcfun ("MagickSetImageProfile" magick-set-image-profile) magick-boolean-type
  (arg1 :pointer) (arg2 :string) (arg3 :pointer) (arg4 :unsigned-long))
 (cffi:defcfun ("MagickSetImagePixels" magick-set-image-pixels) magick-boolean-type (arg1 :pointer)
  (arg2 :long) (arg3 :long) (arg4 :unsigned-long) (arg5 :unsigned-long) (arg6 :string)
  (arg7 storage-type) (arg8 :pointer))
 (cffi:defcfun ("MagickSetImagePage" magick-set-image-page) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long) (arg4 :long) (arg5 :long))
 (cffi:defcfun ("MagickSetImageMatteColor" magick-set-image-matte-color) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("MagickSetImageIterations" magick-set-image-iterations) magick-boolean-type
  (arg1 :pointer) (arg2 :unsigned-long))
 (cffi:defcfun ("MagickSetImageInterlaceScheme" magick-set-image-interlace-scheme)
  magick-boolean-type (arg1 :pointer) (arg2 interlace-type))
 (cffi:defcfun ("MagickSetImageIndex" magick-set-image-index) magick-boolean-type (arg1 :pointer)
  (arg2 :long))
 (cffi:defcfun ("MagickSetImageFormat" magick-set-image-format) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("MagickSetImageFilename" magick-set-image-filename) magick-boolean-type
  (arg1 :pointer) (arg2 :string))
 (cffi:defcfun ("MagickSetImageExtent" magick-set-image-extent) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long))
 (cffi:defcfun ("MagickSetImageGamma" magick-set-image-gamma) magick-boolean-type (arg1 :pointer)
  (arg2 :double))
 (cffi:defcfun ("MagickSetImageGreenPrimary" magick-set-image-green-primary) magick-boolean-type
  (arg1 :pointer) (arg2 :double) (arg3 :double))
 (cffi:defcfun ("MagickSetImageCompressionQuality" magick-set-image-compression-quality)
  magick-boolean-type (arg1 :pointer) (arg2 :unsigned-long))
 (cffi:defcfun ("MagickSetImageColorspace" magick-set-image-colorspace) magick-boolean-type
  (arg1 :pointer) (arg2 colorspace-type))
 (cffi:defcfun ("MagickSetImageDispose" magick-set-image-dispose) magick-boolean-type
  (arg1 :pointer) (arg2 dispose-type))
 (cffi:defcfun ("MagickSetImageDepth" magick-set-image-depth) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long))
 (cffi:defcfun ("MagickSetImageDelay" magick-set-image-delay) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long))
 (cffi:defcfun ("MagickSetImageCompression" magick-set-image-compression) magick-boolean-type
  (arg1 :pointer) (arg2 compression-type))
 (cffi:defcfun ("MagickSetImageCompose" magick-set-image-compose) magick-boolean-type
  (arg1 :pointer) (arg2 composite-operator))
 (cffi:defcfun ("MagickSetImageColormapColor" magick-set-image-colormap-color) magick-boolean-type
  (arg1 :pointer) (arg2 :unsigned-long) (arg3 :pointer))
 (cffi:defcfun ("MagickSetImageChannelDepth" magick-set-image-channel-depth) magick-boolean-type
  (arg1 :pointer) (arg2 channel-type) (arg3 :unsigned-long))
 (cffi:defcfun ("MagickSetImageBorderColor" magick-set-image-border-color) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("MagickSetImageBluePrimary" magick-set-image-blue-primary) magick-boolean-type
  (arg1 :pointer) (arg2 :double) (arg3 :double))
 (cffi:defcfun ("MagickSetImageBias" magick-set-image-bias) magick-boolean-type (arg1 :pointer)
  (arg2 :double))
 (cffi:defcfun ("MagickSetImageBackgroundColor" magick-set-image-background-color)
  magick-boolean-type (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("MagickSetImageAttribute" magick-set-image-attribute) magick-boolean-type
  (arg1 :pointer) (arg2 :string) (arg3 :string))
 (cffi:defcfun ("MagickSetImage" magick-set-image) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("MagickSepiaToneImage" magick-sepia-tone-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double))
 (cffi:defcfun ("MagickSeparateImageChannel" magick-separate-image-channel) magick-boolean-type
  (arg1 :pointer) (arg2 channel-type))
 (cffi:defcfun ("MagickScaleImage" magick-scale-image) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long))
 (cffi:defcfun ("MagickSampleImage" magick-sample-image) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long))
 (cffi:defcfun ("MagickRotateImage" magick-rotate-image) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 :double))
 (cffi:defcfun ("MagickRollImage" magick-roll-image) magick-boolean-type (arg1 :pointer)
  (arg2 :long) (arg3 :long))
 (cffi:defcfun ("MagickResizeImage" magick-resize-image) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long) (arg4 filter-types) (arg5 :double))
 (cffi:defcfun ("MagickResampleImage" magick-resample-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double) (arg3 :double) (arg4 filter-types) (arg5 :double))
 (cffi:defcfun ("MagickRemoveImage" magick-remove-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("MagickReduceNoiseImage" magick-reduce-noise-image) magick-boolean-type
  (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("MagickReadImageFile" magick-read-image-file) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("MagickReadImageBlob" magick-read-image-blob) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (length size-t))
 (cffi:defcfun ("MagickReadImage" magick-read-image) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("MagickRaiseImage" magick-raise-image) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long) (arg4 :long) (arg5 :long) (arg6 magick-boolean-type))
 (cffi:defcfun ("MagickRadialBlurImageChannel" magick-radial-blur-image-channel)
  magick-boolean-type (arg1 :pointer) (arg2 channel-type) (arg3 :double))
 (cffi:defcfun ("MagickRadialBlurImage" magick-radial-blur-image) magick-boolean-type
  (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("MagickQuantizeImages" magick-quantize-images) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 colorspace-type) (arg4 :unsigned-long) (arg5 magick-boolean-type)
  (arg6 magick-boolean-type))
 (cffi:defcfun ("MagickQuantizeImage" magick-quantize-image) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 colorspace-type) (arg4 :unsigned-long) (arg5 magick-boolean-type)
  (arg6 magick-boolean-type))
 (cffi:defcfun ("MagickProfileImage" magick-profile-image) magick-boolean-type (arg1 :pointer)
  (arg2 :string) (arg3 :pointer) (arg4 :unsigned-long))
 (cffi:defcfun ("MagickPreviousImage" magick-previous-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("MagickPosterizeImage" magick-posterize-image) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 magick-boolean-type))
 (cffi:defcfun ("MagickPingImage" magick-ping-image) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("MagickPaintTransparentImage" magick-paint-transparent-image) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer) (arg3 quantum) (arg4 :double))
 (cffi:defcfun ("MagickPaintOpaqueImage" magick-paint-opaque-image) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer) (arg3 :pointer) (arg4 :double))
 (cffi:defcfun ("MagickOilPaintImage" magick-oil-paint-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double))
 (cffi:defcfun ("MagickNormalizeImage" magick-normalize-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("MagickNextImage" magick-next-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("MagickNewImage" magick-new-image) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long) (arg4 :pointer))
 (cffi:defcfun ("MagickNegateImageChannel" magick-negate-image-channel) magick-boolean-type
  (arg1 :pointer) (arg2 channel-type) (arg3 magick-boolean-type))
 (cffi:defcfun ("MagickNegateImage" magick-negate-image) magick-boolean-type (arg1 :pointer)
  (arg2 magick-boolean-type))
 (cffi:defcfun ("MagickMotionBlurImage" magick-motion-blur-image) magick-boolean-type
  (arg1 :pointer) (arg2 :double) (arg3 :double) (arg4 :double))
 (cffi:defcfun ("MagickModulateImage" magick-modulate-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double) (arg3 :double) (arg4 :double))
 (cffi:defcfun ("MagickMinifyImage" magick-minify-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("MagickMedianFilterImage" magick-median-filter-image) magick-boolean-type
  (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("MagickMatteFloodfillImage" magick-matte-floodfill-image) magick-boolean-type
  (arg1 :pointer) (arg2 quantum) (arg3 :double) (arg4 :pointer) (arg5 :long) (arg6 :long))
 (cffi:defcfun ("MagickMapImage" magick-map-image) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 magick-boolean-type))
 (cffi:defcfun ("MagickMagnifyImage" magick-magnify-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("MagickLevelImageChannel" magick-level-image-channel) magick-boolean-type
  (arg1 :pointer) (arg2 channel-type) (arg3 :double) (arg4 :double) (arg5 :double))
 (cffi:defcfun ("MagickLevelImage" magick-level-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double) (arg3 :double) (arg4 :double))
 (cffi:defcfun ("MagickLabelImage" magick-label-image) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("MagickImplodeImage" magick-implode-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double))
 (cffi:defcfun ("MagickHasPreviousImage" magick-has-previous-image) magick-boolean-type
  (arg1 :pointer))
 (cffi:defcfun ("MagickHasNextImage" magick-has-next-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageWhitePoint" magick-get-image-white-point) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer) (arg3 :pointer))
 (cffi:defcfun ("MagickGetImageResolution" magick-get-image-resolution) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer) (arg3 :pointer))
 (cffi:defcfun ("MagickGetImageRedPrimary" magick-get-image-red-primary) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer) (arg3 :pointer))
 (cffi:defcfun ("MagickGetImagePixels" magick-get-image-pixels) magick-boolean-type (arg1 :pointer)
  (arg2 :long) (arg3 :long) (arg4 :unsigned-long) (arg5 :unsigned-long) (arg6 :string)
  (arg7 storage-type) (arg8 :pointer))
 (cffi:defcfun ("MagickGetImagePixelColor" magick-get-image-pixel-color) magick-boolean-type
  (arg1 :pointer) (arg2 :long) (arg3 :long) (arg4 :pointer))
 (cffi:defcfun ("MagickGetImagePage" magick-get-image-page) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 :pointer) (arg4 :pointer) (arg5 :pointer))
 (cffi:defcfun ("MagickGetImageMatteColor" magick-get-image-matte-color) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("MagickGetImageGreenPrimary" magick-get-image-green-primary) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer) (arg3 :pointer))
 (cffi:defcfun ("MagickGetImageExtrema" magick-get-image-extrema) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer) (arg3 :pointer))
 (cffi:defcfun ("MagickGetImageColormapColor" magick-get-image-colormap-color) magick-boolean-type
  (arg1 :pointer) (arg2 :unsigned-long) (arg3 :pointer))
 (cffi:defcfun ("MagickGetImageChannelMean" magick-get-image-channel-mean) magick-boolean-type
  (arg1 :pointer) (arg2 channel-type) (arg3 :pointer) (arg4 :pointer))
 (cffi:defcfun ("MagickGetImageChannelExtrema" magick-get-image-channel-extrema)
  magick-boolean-type (arg1 :pointer) (arg2 channel-type) (arg3 :pointer) (arg4 :pointer))
 (cffi:defcfun ("MagickGetImageDistortion" magick-get-image-distortion) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer) (arg3 metric-type) (arg4 :pointer))
 (cffi:defcfun ("MagickGetImageChannelDistortion" magick-get-image-channel-distortion)
  magick-boolean-type (arg1 :pointer) (arg2 :pointer) (arg3 channel-type) (arg4 metric-type)
  (arg5 :pointer))
 (cffi:defcfun ("MagickGetImageBorderColor" magick-get-image-border-color) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("MagickGetImageBluePrimary" magick-get-image-blue-primary) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer) (arg3 :pointer))
 (cffi:defcfun ("MagickGetImageBackgroundColor" magick-get-image-background-color)
  magick-boolean-type (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("MagickGaussianBlurImageChannel" magick-gaussian-blur-image-channel)
  magick-boolean-type (arg1 :pointer) (arg2 channel-type) (arg3 :double) (arg4 :double))
 (cffi:defcfun ("MagickGaussianBlurImage" magick-gaussian-blur-image) magick-boolean-type
  (arg1 :pointer) (arg2 :double) (arg3 :double))
 (cffi:defcfun ("MagickGammaImageChannel" magick-gamma-image-channel) magick-boolean-type
  (arg1 :pointer) (arg2 channel-type) (arg3 :double))
 (cffi:defcfun ("MagickGammaImage" magick-gamma-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double))
 (cffi:defcfun ("MagickFrameImage" magick-frame-image) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 :unsigned-long) (arg4 :unsigned-long) (arg5 :long) (arg6 :long))
 (cffi:defcfun ("MagickFlopImage" magick-flop-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("MagickFlipImage" magick-flip-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("MagickEvaluateImageChannel" magick-evaluate-image-channel) magick-boolean-type
  (arg1 :pointer) (arg2 channel-type) (arg3 magick-evaluate-operator) (arg4 :double))
 (cffi:defcfun ("MagickEvaluateImage" magick-evaluate-image) magick-boolean-type (arg1 :pointer)
  (arg2 magick-evaluate-operator) (arg3 :double))
 (cffi:defcfun ("MagickEqualizeImage" magick-equalize-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("MagickEnhanceImage" magick-enhance-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("MagickEmbossImage" magick-emboss-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double) (arg3 :double))
 (cffi:defcfun ("MagickEdgeImage" magick-edge-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double))
 (cffi:defcfun ("MagickDrawImage" magick-draw-image) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("MagickDisplayImages" magick-display-images) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("MagickDisplayImage" magick-display-image) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("MagickDespeckleImage" magick-despeckle-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("MagickCycleColormapImage" magick-cycle-colormap-image) magick-boolean-type
  (arg1 :pointer) (arg2 :long))
 (cffi:defcfun ("MagickCropImage" magick-crop-image) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long) (arg4 :long) (arg5 :long))
 (cffi:defcfun ("MagickConvolveImageChannel" magick-convolve-image-channel) magick-boolean-type
  (arg1 :pointer) (arg2 channel-type) (arg3 :unsigned-long) (arg4 :pointer))
 (cffi:defcfun ("MagickConvolveImage" magick-convolve-image) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :pointer))
 (cffi:defcfun ("MagickContrastImage" magick-contrast-image) magick-boolean-type (arg1 :pointer)
  (arg2 magick-boolean-type))
 (cffi:defcfun ("MagickConstituteImage" magick-constitute-image) magick-boolean-type
  (arg1 :pointer) (arg2 :unsigned-long) (arg3 :unsigned-long) (arg4 :string) (arg5 storage-type)
  (arg6 :pointer))
 (cffi:defcfun ("MagickCompositeImage" magick-composite-image) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 composite-operator) (arg4 :long) (arg5 :long))
 (cffi:defcfun ("MagickCommentImage" magick-comment-image) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("MagickColorizeImage" magick-colorize-image) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 :pointer))
 (cffi:defcfun ("MagickColorFloodfillImage" magick-color-floodfill-image) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer) (arg3 :double) (arg4 :pointer) (arg5 :long) (arg6 :long))
 (cffi:defcfun ("MagickClipPathImage" magick-clip-path-image) magick-boolean-type (arg1 :pointer)
  (arg2 :string) (arg3 magick-boolean-type))
 (cffi:defcfun ("MagickClipImage" magick-clip-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("MagickChopImage" magick-chop-image) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long) (arg4 :long) (arg5 :long))
 (cffi:defcfun ("MagickCharcoalImage" magick-charcoal-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double) (arg3 :double))
 (cffi:defcfun ("MagickBorderImage" magick-border-image) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 :unsigned-long) (arg4 :unsigned-long))
 (cffi:defcfun ("MagickBlurImageChannel" magick-blur-image-channel) magick-boolean-type
  (arg1 :pointer) (arg2 channel-type) (arg3 :double) (arg4 :double))
 (cffi:defcfun ("MagickBlurImage" magick-blur-image) magick-boolean-type (arg1 :pointer)
  (arg2 :double) (arg3 :double))
 (cffi:defcfun ("MagickBlackThresholdImage" magick-black-threshold-image) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("MagickAnimateImages" magick-animate-images) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("MagickAnnotateImage" magick-annotate-image) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 :double) (arg4 :double) (arg5 :double) (arg6 :string))
 (cffi:defcfun ("MagickAffineTransformImage" magick-affine-transform-image) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("MagickAddNoiseImage" magick-add-noise-image) magick-boolean-type (arg1 :pointer)
  (arg2 noise-type))
 (cffi:defcfun ("MagickAddImage" magick-add-image) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("MagickAdaptiveThresholdImage" magick-adaptive-threshold-image) magick-boolean-type
  (arg1 :pointer) (arg2 :unsigned-long) (arg3 :unsigned-long) (arg4 :long))
 (cffi:defcfun ("MagickGetImageIndex" magick-get-image-index) :long (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageInterlaceScheme" magick-get-image-interlace-scheme) interlace-type
  (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageType" magick-get-image-type) image-type (arg1 :pointer))
 (cffi:defcfun ("GetImageFromMagickWand" get-image-from-magick-wand) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageTotalInkDensity" magick-get-image-total-ink-density) :double
  (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageGamma" magick-get-image-gamma) :double (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageDispose" magick-get-image-dispose) dispose-type (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageCompression" magick-get-image-compression) compression-type
  (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageColorspace" magick-get-image-colorspace) colorspace-type
  (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageCompose" magick-get-image-compose) composite-operator
  (arg1 :pointer))
 (cffi:defcfun ("MagickIdentifyImage" magick-identify-image) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageSignature" magick-get-image-signature) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageFormat" magick-get-image-format) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageFilename" magick-get-image-filename) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickGetImageAttribute" magick-get-image-attribute) :pointer (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("MagickGetImageChannelStatistics" magick-get-image-channel-statistics) :pointer
  (arg1 :pointer))
 (cffi:defcfun ("MagickGetResourceLimit" magick-get-resource-limit) :unsigned-long
  (arg1 resource-type))
 (cffi:defcfun ("MagickGetResource" magick-get-resource) :unsigned-long (arg1 resource-type))
 (cffi:defcfun ("MagickGetCompressionQuality" magick-get-compression-quality) :unsigned-long
  (arg1 :pointer))
 (cffi:defcfun ("MagickSetProgressMonitor" magick-set-progress-monitor) magick-progress-monitor
  (arg1 :pointer) (arg2 magick-progress-monitor) (arg3 :pointer))
 (cffi:defcfun ("MagickSetType" magick-set-type) magick-boolean-type (arg1 :pointer)
  (arg2 image-type))
 (cffi:defcfun ("MagickSetSize" magick-set-size) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long))
 (cffi:defcfun ("MagickSetSamplingFactors" magick-set-sampling-factors) magick-boolean-type
  (arg1 :pointer) (arg2 :unsigned-long) (arg3 :pointer))
 (cffi:defcfun ("MagickSetResourceLimit" magick-set-resource-limit) magick-boolean-type
  (type resource-type) (limit :unsigned-long))
 (cffi:defcfun ("MagickSetResolution" magick-set-resolution) magick-boolean-type (arg1 :pointer)
  (arg2 :double) (arg3 :double))
 (cffi:defcfun ("MagickSetPassphrase" magick-set-passphrase) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("MagickSetPage" magick-set-page) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long) (arg4 :long) (arg5 :long))
 (cffi:defcfun ("MagickSetOption" magick-set-option) magick-boolean-type (arg1 :pointer)
  (arg2 :string) (arg3 :string))
 (cffi:defcfun ("MagickSetInterlaceScheme" magick-set-interlace-scheme) magick-boolean-type
  (arg1 :pointer) (arg2 interlace-type))
 (cffi:defcfun ("MagickSetFormat" magick-set-format) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("MagickSetFilename" magick-set-filename) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("MagickSetCompressionQuality" magick-set-compression-quality) magick-boolean-type
  (arg1 :pointer) (arg2 :unsigned-long))
 (cffi:defcfun ("MagickSetCompression" magick-set-compression) magick-boolean-type (arg1 :pointer)
  (arg2 compression-type))
 (cffi:defcfun ("MagickSetBackgroundColor" magick-set-background-color) magick-boolean-type
  (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("MagickGetSize" magick-get-size) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 :pointer))
 (cffi:defcfun ("MagickGetPage" magick-get-page) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 :pointer) (arg4 :pointer) (arg5 :pointer))
 (cffi:defcfun ("MagickGetInterlaceScheme" magick-get-interlace-scheme) interlace-type
  (arg1 :pointer))
 (cffi:defcfun ("MagickQueryMultilineFontMetrics" magick-query-multiline-font-metrics) :pointer
  (arg1 :pointer) (arg2 :pointer) (arg3 :string))
 (cffi:defcfun ("MagickQueryFontMetrics" magick-query-font-metrics) :pointer (arg1 :pointer)
  (arg2 :pointer) (arg3 :string))
 (cffi:defcfun ("MagickGetSamplingFactors" magick-get-sampling-factors) :pointer (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("MagickGetVersion" magick-get-version) :string (arg1 :pointer))
 (cffi:defcfun ("MagickGetReleaseDate" magick-get-release-date) :string)
 (cffi:defcfun ("MagickGetQuantumRange" magick-get-quantum-range) :string (arg1 :pointer))
 (cffi:defcfun ("MagickGetQuantumDepth" magick-get-quantum-depth) :string (arg1 :pointer))
 (cffi:defcfun ("MagickGetPackageName" magick-get-package-name) :string)
 (cffi:defcfun ("MagickGetCopyright" magick-get-copyright) :string)
 (cffi:defcfun ("MagickGetCompression" magick-get-compression) compression-type (arg1 :pointer))
 (cffi:defcfun ("MagickQueryFormats" magick-query-formats) :pointer (arg1 :string) (arg2 :pointer))
 (cffi:defcfun ("MagickQueryFonts" magick-query-fonts) :pointer (arg1 :string) (arg2 :pointer))
 (cffi:defcfun ("MagickQueryConfigureOptions" magick-query-configure-options) :pointer
  (arg1 :string) (arg2 :pointer))
 (cffi:defcfun ("MagickQueryConfigureOption" magick-query-configure-option) :pointer
  (arg1 :string))
 (cffi:defcfun ("MagickGetOption" magick-get-option) :pointer (arg1 :pointer) (arg2 :string))
 (cffi:defcfun ("MagickGetHomeURL" magick-get-home-url) :pointer)
 (cffi:defcfun ("MagickGetFormat" magick-get-format) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickGetFilename" magick-get-filename) :pointer (arg1 :pointer))
 (cffi:defcfun ("MagickGetException" magick-get-exception) :pointer (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("DrawSetStrokeOpacity" draw-set-stroke-opacity) :void (arg1 :pointer)
  (arg2 :double))
 (cffi:defcfun ("DrawSetFillOpacity" draw-set-fill-opacity) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("DrawPushGraphicContext" draw-push-graphic-context) :void (arg1 :pointer))
 (cffi:defcfun ("DrawPopGraphicContext" draw-pop-graphic-context) :void (arg1 :pointer))
 (cffi:defcfun ("DrawPeekGraphicWand" draw-peek-graphic-wand) :pointer (arg1 :pointer))
 (cffi:defcfun ("DrawGetStrokeOpacity" draw-get-stroke-opacity) :double (arg1 :pointer))
 (cffi:defcfun ("DrawGetFillOpacity" draw-get-fill-opacity) :double (arg1 :pointer))
 (cffi:defcfun ("DrawTranslate" draw-translate) :void (arg1 :pointer) (arg2 :double)
  (arg3 :double))
 (cffi:defcfun ("DrawSetViewbox" draw-set-viewbox) :void (arg1 :pointer) (arg2 :unsigned-long)
  (arg3 :unsigned-long) (arg4 :unsigned-long) (arg5 :unsigned-long))
 (cffi:defcfun ("DrawSetTextUnderColor" draw-set-text-under-color) :void (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("DrawSetTextEncoding" draw-set-text-encoding) :void (arg1 :pointer) (arg2 :string))
 (cffi:defcfun ("DrawSetTextDecoration" draw-set-text-decoration) :void (arg1 :pointer)
  (arg2 decoration-type))
 (cffi:defcfun ("DrawSetTextAntialias" draw-set-text-antialias) :void (arg1 :pointer)
  (arg2 magick-boolean-type))
 (cffi:defcfun ("DrawSetTextAlignment" draw-set-text-alignment) :void (arg1 :pointer)
  (arg2 align-type))
 (cffi:defcfun ("DrawSetStrokeWidth" draw-set-stroke-width) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("DrawSetStrokeAlpha" draw-set-stroke-alpha) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("DrawSetStrokeMiterLimit" draw-set-stroke-miter-limit) :void (arg1 :pointer)
  (arg2 :unsigned-long))
 (cffi:defcfun ("DrawSetStrokeLineJoin" draw-set-stroke-line-join) :void (arg1 :pointer)
  (arg2 line-join))
 (cffi:defcfun ("DrawSetStrokeLineCap" draw-set-stroke-line-cap) :void (arg1 :pointer)
  (arg2 line-cap))
 (cffi:defcfun ("DrawSetStrokeDashOffset" draw-set-stroke-dash-offset) :void (arg1 :pointer)
  (dashoffset :double))
 (cffi:defcfun ("DrawSetStrokeColor" draw-set-stroke-color) :void (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("DrawSetStrokeAntialias" draw-set-stroke-antialias) :void (arg1 :pointer)
  (arg2 magick-boolean-type))
 (cffi:defcfun ("DrawSkewY" draw-skew-y) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("DrawSkewX" draw-skew-x) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("DrawSetGravity" draw-set-gravity) :void (arg1 :pointer) (arg2 gravity-type))
 (cffi:defcfun ("DrawSetFontWeight" draw-set-font-weight) :void (arg1 :pointer)
  (arg2 :unsigned-long))
 (cffi:defcfun ("DrawSetFontStyle" draw-set-font-style) :void (arg1 :pointer) (arg2 style-type))
 (cffi:defcfun ("DrawSetFontStretch" draw-set-font-stretch) :void (arg1 :pointer)
  (arg2 stretch-type))
 (cffi:defcfun ("DrawSetFontSize" draw-set-font-size) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("DrawSetFillRule" draw-set-fill-rule) :void (arg1 :pointer) (arg2 fill-rule))
 (cffi:defcfun ("DrawSetFillAlpha" draw-set-fill-alpha) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("DrawSetFillColor" draw-set-fill-color) :void (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("DrawSetClipUnits" draw-set-clip-units) :void (arg1 :pointer)
  (arg2 clip-path-units))
 (cffi:defcfun ("DrawSetClipRule" draw-set-clip-rule) :void (arg1 :pointer) (arg2 fill-rule))
 (cffi:defcfun ("DrawScale" draw-scale) :void (arg1 :pointer) (arg2 :double) (arg3 :double))
 (cffi:defcfun ("DrawRoundRectangle" draw-round-rectangle) :void (arg1 :pointer) (arg2 :double)
  (arg3 :double) (arg4 :double) (arg5 :double) (arg6 :double) (arg7 :double))
 (cffi:defcfun ("DrawRotate" draw-rotate) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("DrawRectangle" draw-rectangle) :void (arg1 :pointer) (arg2 :double) (arg3 :double)
  (arg4 :double) (arg5 :double))
 (cffi:defcfun ("DrawPushDefs" draw-push-defs) :void (arg1 :pointer))
 (cffi:defcfun ("DrawPushClipPath" draw-push-clip-path) :void (arg1 :pointer) (arg2 :string))
 (cffi:defcfun ("DrawPopDefs" draw-pop-defs) :void (arg1 :pointer))
 (cffi:defcfun ("DrawPopClipPath" draw-pop-clip-path) :void (arg1 :pointer))
 (cffi:defcfun ("DrawPolyline" draw-polyline) :void (arg1 :pointer) (arg2 :unsigned-long)
  (arg3 :pointer))
 (cffi:defcfun ("DrawPolygon" draw-polygon) :void (arg1 :pointer) (arg2 :unsigned-long)
  (arg3 :pointer))
 (cffi:defcfun ("DrawPoint" draw-point) :void (arg1 :pointer) (arg2 :double) (arg3 :double))
 (cffi:defcfun ("DrawPathStart" draw-path-start) :void (arg1 :pointer))
 (cffi:defcfun ("DrawPathMoveToRelative" draw-path-move-to-relative) :void (arg1 :pointer)
  (arg2 :double) (arg3 :double))
 (cffi:defcfun ("DrawPathMoveToAbsolute" draw-path-move-to-absolute) :void (arg1 :pointer)
  (arg2 :double) (arg3 :double))
 (cffi:defcfun ("DrawPathLineToVerticalRelative" draw-path-line-to-vertical-relative) :void
  (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("DrawPathLineToVerticalAbsolute" draw-path-line-to-vertical-absolute) :void
  (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("DrawPathLineToHorizontalRelative" draw-path-line-to-horizontal-relative) :void
  (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("DrawPathLineToHorizontalAbsolute" draw-path-line-to-horizontal-absolute) :void
  (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("DrawPathLineToRelative" draw-path-line-to-relative) :void (arg1 :pointer)
  (arg2 :double) (arg3 :double))
 (cffi:defcfun ("DrawPathLineToAbsolute" draw-path-line-to-absolute) :void (arg1 :pointer)
  (arg2 :double) (arg3 :double))
 (cffi:defcfun ("DrawPathFinish" draw-path-finish) :void (arg1 :pointer))
 (cffi:defcfun ("DrawPathEllipticArcRelative" draw-path-elliptic-arc-relative) :void
  (arg1 :pointer) (arg2 :double) (arg3 :double) (arg4 :double) (arg5 magick-boolean-type)
  (arg6 magick-boolean-type) (arg7 :double) (arg8 :double))
 (cffi:defcfun ("DrawPathEllipticArcAbsolute" draw-path-elliptic-arc-absolute) :void
  (arg1 :pointer) (arg2 :double) (arg3 :double) (arg4 :double) (arg5 magick-boolean-type)
  (arg6 magick-boolean-type) (arg7 :double) (arg8 :double))
 (cffi:defcfun ("DrawPathCurveToSmoothRelative" draw-path-curve-to-smooth-relative) :void
  (arg1 :pointer) (arg2 :double) (arg3 :double) (arg4 :double) (arg5 :double))
 (cffi:defcfun ("DrawPathCurveToSmoothAbsolute" draw-path-curve-to-smooth-absolute) :void
  (arg1 :pointer) (arg2 :double) (arg3 :double) (arg4 :double) (arg5 :double))
 (cffi:defcfun
  ("DrawPathCurveToQuadraticBezierSmoothRelative"
   draw-path-curve-to-quadratic-bezier-smooth-relative)
  :void (arg1 :pointer) (arg2 :double) (arg3 :double))
 (cffi:defcfun
  ("DrawPathCurveToQuadraticBezierSmoothAbsolute"
   draw-path-curve-to-quadratic-bezier-smooth-absolute)
  :void (arg1 :pointer) (arg2 :double) (arg3 :double))
 (cffi:defcfun
  ("DrawPathCurveToQuadraticBezierRelative" draw-path-curve-to-quadratic-bezier-relative) :void
  (arg1 :pointer) (arg2 :double) (arg3 :double) (arg4 :double) (arg5 :double))
 (cffi:defcfun
  ("DrawPathCurveToQuadraticBezierAbsolute" draw-path-curve-to-quadratic-bezier-absolute) :void
  (arg1 :pointer) (arg2 :double) (arg3 :double) (arg4 :double) (arg5 :double))
 (cffi:defcfun ("DrawPathCurveToRelative" draw-path-curve-to-relative) :void (arg1 :pointer)
  (arg2 :double) (arg3 :double) (arg4 :double) (arg5 :double) (arg6 :double) (arg7 :double))
 (cffi:defcfun ("DrawPathCurveToAbsolute" draw-path-curve-to-absolute) :void (arg1 :pointer)
  (arg2 :double) (arg3 :double) (arg4 :double) (arg5 :double) (arg6 :double) (arg7 :double))
 (cffi:defcfun ("DrawPathClose" draw-path-close) :void (arg1 :pointer))
 (cffi:defcfun ("DrawMatte" draw-matte) :void (arg1 :pointer) (arg2 :double) (arg3 :double)
  (arg4 paint-method))
 (cffi:defcfun ("DrawLine" draw-line) :void (arg1 :pointer) (arg2 :double) (arg3 :double)
  (arg4 :double) (arg5 :double))
 (cffi:defcfun ("DrawGetTextUnderColor" draw-get-text-under-color) :void (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("DrawGetStrokeColor" draw-get-stroke-color) :void (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("DrawGetFillColor" draw-get-fill-color) :void (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("DrawEllipse" draw-ellipse) :void (arg1 :pointer) (arg2 :double) (arg3 :double)
  (arg4 :double) (arg5 :double) (arg6 :double) (arg7 :double))
 (cffi:defcfun ("DrawComment" draw-comment) :void (arg1 :pointer) (arg2 :string))
 (cffi:defcfun ("DrawColor" draw-color) :void (arg1 :pointer) (arg2 :double) (arg3 :double)
  (arg4 paint-method))
 (cffi:defcfun ("DrawCircle" draw-circle) :void (arg1 :pointer) (arg2 :double) (arg3 :double)
  (arg4 :double) (arg5 :double))
 (cffi:defcfun ("DrawBezier" draw-bezier) :void (arg1 :pointer) (arg2 :unsigned-long)
  (arg3 :pointer))
 (cffi:defcfun ("DrawArc" draw-arc) :void (arg1 :pointer) (arg2 :double) (arg3 :double)
  (arg4 :double) (arg5 :double) (arg6 :double) (arg7 :double))
 (cffi:defcfun ("DrawAnnotation" draw-annotation) :void (arg1 :pointer) (arg2 :double)
  (arg3 :double) (arg4 :pointer))
 (cffi:defcfun ("DrawAffine" draw-affine) :void (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("ClearDrawingWand" clear-drawing-wand) :void (arg1 :pointer))
 (cffi:defcfun ("DrawGetStrokeMiterLimit" draw-get-stroke-miter-limit) :unsigned-long
  (arg1 :pointer))
 (cffi:defcfun ("DrawGetFontWeight" draw-get-font-weight) :unsigned-long (arg1 :pointer))
 (cffi:defcfun ("DrawGetFontStyle" draw-get-font-style) style-type (arg1 :pointer))
 (cffi:defcfun ("DrawGetFontStretch" draw-get-font-stretch) stretch-type (arg1 :pointer))
 (cffi:defcfun ("PushDrawingWand" push-drawing-wand) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("PopDrawingWand" pop-drawing-wand) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("IsDrawingWand" is-drawing-wand) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("DrawSetVectorGraphics" draw-set-vector-graphics) magick-boolean-type
  (arg1 :pointer) (arg2 :string))
 (cffi:defcfun ("DrawSetStrokePatternURL" draw-set-stroke-pattern-url) magick-boolean-type
  (arg1 :pointer) (arg2 :string))
 (cffi:defcfun ("DrawSetStrokeDashArray" draw-set-stroke-dash-array) magick-boolean-type
  (arg1 :pointer) (arg2 :unsigned-long) (arg3 :pointer))
 (cffi:defcfun ("DrawSetFontFamily" draw-set-font-family) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("DrawSetFont" draw-set-font) magick-boolean-type (arg1 :pointer) (arg2 :string))
 (cffi:defcfun ("DrawSetFillPatternURL" draw-set-fill-pattern-url) magick-boolean-type
  (arg1 :pointer) (arg2 :string))
 (cffi:defcfun ("DrawSetClipPath" draw-set-clip-path) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("DrawRender" draw-render) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("DrawPushPattern" draw-push-pattern) magick-boolean-type (arg1 :pointer)
  (arg2 :string) (arg3 :double) (arg4 :double) (arg5 :double) (arg6 :double))
 (cffi:defcfun ("DrawPopPattern" draw-pop-pattern) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("DrawGetTextAntialias" draw-get-text-antialias) magick-boolean-type
  (arg1 :pointer))
 (cffi:defcfun ("DrawGetStrokeAntialias" draw-get-stroke-antialias) magick-boolean-type
  (arg1 :pointer))
 (cffi:defcfun ("DrawComposite" draw-composite) magick-boolean-type (arg1 :pointer)
  (arg2 composite-operator) (arg3 :double) (arg4 :double) (arg5 :double) (arg6 :double)
  (arg7 :pointer))
 (cffi:defcfun ("DrawClearException" draw-clear-exception) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("DrawGetStrokeLineJoin" draw-get-stroke-line-join) line-join (arg1 :pointer))
 (cffi:defcfun ("DrawGetStrokeLineCap" draw-get-stroke-line-cap) line-cap (arg1 :pointer))
 (cffi:defcfun ("DrawGetGravity" draw-get-gravity) gravity-type (arg1 :pointer))
 (cffi:defcfun ("DrawGetFillRule" draw-get-fill-rule) fill-rule (arg1 :pointer))
 (cffi:defcfun ("DrawGetClipRule" draw-get-clip-rule) fill-rule (arg1 :pointer))
 (cffi:defcfun ("NewDrawingWand" new-drawing-wand) :pointer)
 (cffi:defcfun ("DrawAllocateWand" draw-allocate-wand) :pointer (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("DestroyDrawingWand" destroy-drawing-wand) :pointer (arg1 :pointer))
 (cffi:defcfun ("CloneDrawingWand" clone-drawing-wand) :pointer (arg1 :pointer))
 (cffi:defcfun ("PeekDrawingWand" peek-drawing-wand) :pointer (arg1 :pointer))
 (cffi:defcfun ("DrawGetStrokeWidth" draw-get-stroke-width) :double (arg1 :pointer))
 (cffi:defcfun ("DrawGetStrokeAlpha" draw-get-stroke-alpha) :double (arg1 :pointer))
 (cffi:defcfun ("DrawGetStrokeDashOffset" draw-get-stroke-dash-offset) :double (arg1 :pointer))
 (cffi:defcfun ("DrawGetStrokeDashArray" draw-get-stroke-dash-array) :pointer (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("DrawGetFontSize" draw-get-font-size) :double (arg1 :pointer))
 (cffi:defcfun ("DrawGetFillAlpha" draw-get-fill-alpha) :double (arg1 :pointer))
 (cffi:defcfun ("DrawGetTextDecoration" draw-get-text-decoration) decoration-type (arg1 :pointer))
 (cffi:defcfun ("DrawGetClipUnits" draw-get-clip-units) clip-path-units (arg1 :pointer))
 (cffi:defcfun ("DrawGetVectorGraphics" draw-get-vector-graphics) :pointer (arg1 :pointer))
 (cffi:defcfun ("DrawGetTextEncoding" draw-get-text-encoding) :pointer (arg1 :pointer))
 (cffi:defcfun ("DrawGetFontFamily" draw-get-font-family) :pointer (arg1 :pointer))
 (cffi:defcfun ("DrawGetFont" draw-get-font) :pointer (arg1 :pointer))
 (cffi:defcfun ("DrawGetException" draw-get-exception) :pointer (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("DrawGetClipPath" draw-get-clip-path) :pointer (arg1 :pointer))
 (cffi:defcfun ("DrawGetTextAlignment" draw-get-text-alignment) align-type (arg1 :pointer))
 (cffi:defcfun ("PixelSetYellowQuantum" pixel-set-yellow-quantum) :void (arg1 :pointer)
  (arg2 quantum))
 (cffi:defcfun ("PixelSetYellow" pixel-set-yellow) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("PixelSetRedQuantum" pixel-set-red-quantum) :void (arg1 :pointer) (arg2 quantum))
 (cffi:defcfun ("PixelSetRed" pixel-set-red) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("PixelSetQuantumColor" pixel-set-quantum-color) :void (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("PixelSetOpacityQuantum" pixel-set-opacity-quantum) :void (arg1 :pointer)
  (arg2 quantum))
 (cffi:defcfun ("PixelSetOpacity" pixel-set-opacity) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("PixelSetMagentaQuantum" pixel-set-magenta-quantum) :void (arg1 :pointer)
  (arg2 quantum))
 (cffi:defcfun ("PixelSetMagenta" pixel-set-magenta) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("PixelSetIndex" pixel-set-index) :void (arg1 :pointer) (arg2 index-packet))
 (cffi:defcfun ("PixelSetGreenQuantum" pixel-set-green-quantum) :void (arg1 :pointer)
  (arg2 quantum))
 (cffi:defcfun ("PixelSetGreen" pixel-set-green) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("PixelSetCyanQuantum" pixel-set-cyan-quantum) :void (arg1 :pointer) (arg2 quantum))
 (cffi:defcfun ("PixelSetCyan" pixel-set-cyan) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("PixelSetColorCount" pixel-set-color-count) :void (arg1 :pointer)
  (arg2 :unsigned-long))
 (cffi:defcfun ("PixelSetBlueQuantum" pixel-set-blue-quantum) :void (arg1 :pointer) (arg2 quantum))
 (cffi:defcfun ("PixelSetBlue" pixel-set-blue) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("PixelSetBlackQuantum" pixel-set-black-quantum) :void (arg1 :pointer)
  (arg2 quantum))
 (cffi:defcfun ("PixelSetBlack" pixel-set-black) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("PixelSetAlphaQuantum" pixel-set-alpha-quantum) :void (arg1 :pointer)
  (arg2 quantum))
 (cffi:defcfun ("PixelSetAlpha" pixel-set-alpha) :void (arg1 :pointer) (arg2 :double))
 (cffi:defcfun ("PixelGetQuantumColor" pixel-get-quantum-color) :void (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("PixelGetMagickColor" pixel-get-magick-color) :void (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("ClearPixelWand" clear-pixel-wand) :void (arg1 :pointer))
 (cffi:defcfun ("PixelGetColorCount" pixel-get-color-count) :unsigned-long (arg1 :pointer))
 (cffi:defcfun ("PixelGetYellowQuantum" pixel-get-yellow-quantum) quantum (arg1 :pointer))
 (cffi:defcfun ("PixelGetRedQuantum" pixel-get-red-quantum) quantum (arg1 :pointer))
 (cffi:defcfun ("PixelGetOpacityQuantum" pixel-get-opacity-quantum) quantum (arg1 :pointer))
 (cffi:defcfun ("PixelGetMagentaQuantum" pixel-get-magenta-quantum) quantum (arg1 :pointer))
 (cffi:defcfun ("PixelGetGreenQuantum" pixel-get-green-quantum) quantum (arg1 :pointer))
 (cffi:defcfun ("PixelGetCyanQuantum" pixel-get-cyan-quantum) quantum (arg1 :pointer))
 (cffi:defcfun ("PixelGetBlueQuantum" pixel-get-blue-quantum) quantum (arg1 :pointer))
 (cffi:defcfun ("PixelGetBlackQuantum" pixel-get-black-quantum) quantum (arg1 :pointer))
 (cffi:defcfun ("PixelGetAlphaQuantum" pixel-get-alpha-quantum) quantum (arg1 :pointer))
 (cffi:defcfun ("NewPixelWands" new-pixel-wands) :pointer (arg1 :unsigned-long))
 (cffi:defcfun ("NewPixelWand" new-pixel-wand) :pointer)
 (cffi:defcfun ("DestroyPixelWands" destroy-pixel-wands) :pointer (arg1 :pointer)
  (arg2 :unsigned-long))
 (cffi:defcfun ("DestroyPixelWand" destroy-pixel-wand) :pointer (arg1 :pointer))
 (cffi:defcfun ("PixelSetColor" pixel-set-color) magick-boolean-type (arg1 :pointer)
  (arg2 :string))
 (cffi:defcfun ("PixelClearException" pixel-clear-exception) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("IsPixelWandSimilar" is-pixel-wand-similar) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 :double))
 (cffi:defcfun ("IsPixelWand" is-pixel-wand) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("PixelGetIndex" pixel-get-index) index-packet (arg1 :pointer))
 (cffi:defcfun ("PixelGetYellow" pixel-get-yellow) :double (arg1 :pointer))
 (cffi:defcfun ("PixelGetRed" pixel-get-red) :double (arg1 :pointer))
 (cffi:defcfun ("PixelGetOpacity" pixel-get-opacity) :double (arg1 :pointer))
 (cffi:defcfun ("PixelGetMagenta" pixel-get-magenta) :double (arg1 :pointer))
 (cffi:defcfun ("PixelGetGreen" pixel-get-green) :double (arg1 :pointer))
 (cffi:defcfun ("PixelGetCyan" pixel-get-cyan) :double (arg1 :pointer))
 (cffi:defcfun ("PixelGetBlue" pixel-get-blue) :double (arg1 :pointer))
 (cffi:defcfun ("PixelGetBlack" pixel-get-black) :double (arg1 :pointer))
 (cffi:defcfun ("PixelGetAlpha" pixel-get-alpha) :double (arg1 :pointer))
 (cffi:defcfun ("PixelGetColorAsString" pixel-get-color-as-string) :pointer (arg1 :pointer))
 (cffi:defcfun ("PixelGetException" pixel-get-exception) :pointer (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("ZoomImage" zoom-image) :pointer (arg1 :pointer) (arg2 :unsigned-long)
  (arg3 :unsigned-long) (arg4 :pointer))
 (cffi:defcfun ("ThumbnailImage" thumbnail-image) :pointer (arg1 :pointer) (arg2 :unsigned-long)
  (arg3 :unsigned-long) (arg4 :pointer))
 (cffi:defcfun ("ScaleImage" scale-image) :pointer (arg1 :pointer) (arg2 :unsigned-long)
  (arg3 :unsigned-long) (arg4 :pointer))
 (cffi:defcfun ("SampleImage" sample-image) :pointer (arg1 :pointer) (arg2 :unsigned-long)
  (arg3 :unsigned-long) (arg4 :pointer))
 (cffi:defcfun ("ResizeImage" resize-image) :pointer (arg1 :pointer) (arg2 :unsigned-long)
  (arg3 :unsigned-long) (arg4 filter-types) (arg5 :double) (arg6 :pointer))
 (cffi:defcfun ("MinifyImage" minify-image) :pointer (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("MagnifyImage" magnify-image) :pointer (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("SetImageOpacity" set-image-opacity) :void (arg1 :pointer) (arg2 quantum))
 (cffi:defcfun ("SetImageInfoFile" set-image-info-file) :void (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("SetImageInfoBlob" set-image-info-blob) :void (arg1 :pointer) (arg2 :pointer)
  (arg3 size-t))
 (cffi:defcfun ("SetImageBackgroundColor" set-image-background-color) :void (arg1 :pointer))
 (cffi:defcfun ("RelinquishImageResources" relinquish-image-resources) :void (arg1 :pointer))
 (cffi:defcfun ("ModifyImage" modify-image) :void (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("GetImageInfo" get-image-info) :void (arg1 :pointer))
 (cffi:defcfun ("GetImageException" get-image-exception) :void (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("DestroyImagePixels" destroy-image-pixels) :void (arg1 :pointer))
 (cffi:defcfun ("AllocateNextImage" allocate-next-image) :void (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("SetImagePixels" set-image-pixels) :pointer (arg1 :pointer) (arg2 :long)
  (arg3 :long) (arg4 :unsigned-long) (arg5 :unsigned-long))
 (cffi:defcfun ("GetPixels" get-pixels) :pointer (arg1 :pointer))
 (cffi:defcfun ("GetOnePixel" get-one-pixel) pixel-packet (arg1 :pointer) (arg2 :long)
  (arg3 :long))
 (cffi:defcfun ("GetImagePixels" get-image-pixels) :pointer (arg1 :pointer) (arg2 :long)
  (arg3 :long) (arg4 :unsigned-long) (arg5 :unsigned-long))
 (cffi:defcfun ("AcquireOnePixel" acquire-one-pixel) pixel-packet (arg1 :pointer) (arg2 :long)
  (arg3 :long) (arg4 :pointer))
 (cffi:defcfun ("TextureImage" texture-image) magick-boolean-type (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("SyncImagePixels" sync-image-pixels) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("SyncImage" sync-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("StripImage" strip-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("SortColormapByIntensity" sort-colormap-by-intensity) magick-boolean-type
  (arg1 :pointer))
 (cffi:defcfun ("SetImageType" set-image-type) magick-boolean-type (arg1 :pointer)
  (arg2 image-type))
 (cffi:defcfun ("SetImageInfo" set-image-info) magick-boolean-type (arg1 :pointer)
  (arg2 magick-boolean-type) (arg3 :pointer))
 (cffi:defcfun ("SetImageExtent" set-image-extent) magick-boolean-type (arg1 :pointer)
  (arg2 :unsigned-long) (arg3 :unsigned-long))
 (cffi:defcfun ("SetImageClipMask" set-image-clip-mask) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("SeparateImageChannel" separate-image-channel) magick-boolean-type (arg1 :pointer)
  (arg2 channel-type))
 (cffi:defcfun ("PlasmaImage" plasma-image) magick-boolean-type (arg1 :pointer) (arg2 :pointer)
  (arg3 :unsigned-long) (arg4 :unsigned-long))
 (cffi:defcfun ("ListMagickInfo" list-magick-info) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer))
 (cffi:defcfun ("IsMagickConflict" is-magick-conflict) magick-boolean-type (arg1 :string))
 (cffi:defcfun ("IsTaintImage" is-taint-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("GradientImage" gradient-image) magick-boolean-type (arg1 :pointer) (arg2 :pointer)
  (arg3 :pointer))
 (cffi:defcfun ("CycleColormapImage" cycle-colormap-image) magick-boolean-type (arg1 :pointer)
  (arg2 :long))
 (cffi:defcfun ("ClipPathImage" clip-path-image) magick-boolean-type (arg1 :pointer) (arg2 :string)
  (arg3 magick-boolean-type))
 (cffi:defcfun ("ClipImage" clip-image) magick-boolean-type (arg1 :pointer))
 (cffi:defcfun ("AllocateImageColormap" allocate-image-colormap) magick-boolean-type
  (arg1 :pointer) (arg2 :unsigned-long))
 (cffi:defcfun ("GetIndexes" get-indexes) :pointer (arg1 :pointer))
 (cffi:defcfun ("GetImageType" get-image-type) image-type (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("DestroyImageInfo" destroy-image-info) :pointer (arg1 :pointer))
 (cffi:defcfun ("CloneImageInfo" clone-image-info) :pointer (arg1 :pointer))
 (cffi:defcfun ("ReferenceImage" reference-image) :pointer (arg1 :pointer))
 (cffi:defcfun ("NewMagickImage" new-magick-image) :pointer (arg1 :pointer) (arg2 :unsigned-long)
  (arg3 :unsigned-long) (arg4 :pointer))
 (cffi:defcfun ("GetImageClipMask" get-image-clip-mask) :pointer (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("DestroyImage" destroy-image) :pointer (arg1 :pointer))
 (cffi:defcfun ("CombineImages" combine-images) :pointer (arg1 :pointer) (arg2 channel-type)
  (arg3 :pointer))
 (cffi:defcfun ("CloneImages" clone-images) :pointer (arg1 :pointer) (arg2 :string)
  (arg3 :pointer))
 (cffi:defcfun ("CloneImage" clone-image) :pointer (arg1 :pointer) (arg2 :unsigned-long)
  (arg3 :unsigned-long) (arg4 magick-boolean-type) (arg5 :pointer))
 (cffi:defcfun ("AverageImages" average-images) :pointer (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("AppendImages" append-images) :pointer (arg1 :pointer) (arg2 magick-boolean-type)
  (arg3 :pointer))
 (cffi:defcfun ("AllocateImage" allocate-image) :pointer (arg1 :pointer))
 (cffi:defcfun ("CatchImageException" catch-image-exception) exception-type (arg1 :pointer))
 (cffi:defcfun ("AcquireImagePixels" acquire-image-pixels) :pointer (arg1 :pointer) (arg2 :long)
  (arg3 :long) (arg4 :unsigned-long) (arg5 :unsigned-long) (arg6 :pointer))
 (cffi:defcfun ("DestroyConstitute" destroy-constitute) :void)
 (cffi:defcfun ("WriteImages" write-images) magick-boolean-type (arg1 :pointer) (arg2 :pointer)
  (arg3 :string) (arg4 :pointer))
 (cffi:defcfun ("WriteImage" write-image) magick-boolean-type (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("ReadInlineImage" read-inline-image) :pointer (arg1 :pointer) (arg2 :string)
  (arg3 :pointer))
 (cffi:defcfun ("ReadImage" read-image) :pointer (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("PingImage" ping-image) :pointer (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("ConstituteImage" constitute-image) :pointer (arg1 :unsigned-long)
  (arg2 :unsigned-long) (arg3 :string) (arg4 storage-type) (arg5 :pointer) (arg6 :pointer))
 (cffi:defcfun ("GetDrawInfo" get-draw-info) :void (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("GetAffineMatrix" get-affine-matrix) :void (arg1 :pointer))
 (cffi:defcfun ("DrawPrimitive" draw-primitive) magick-boolean-type (arg1 :pointer) (arg2 :pointer)
  (arg3 :pointer))
 (cffi:defcfun ("DrawPatternPath" draw-pattern-path) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 :string) (arg4 :pointer))
 (cffi:defcfun ("DrawImage" draw-image) magick-boolean-type (arg1 :pointer) (arg2 :pointer))
 (cffi:defcfun ("DrawClipPath" draw-clip-path) magick-boolean-type (arg1 :pointer) (arg2 :pointer)
  (arg3 :string))
 (cffi:defcfun ("DrawAffineImage" draw-affine-image) magick-boolean-type (arg1 :pointer)
  (arg2 :pointer) (arg3 :pointer))
 (cffi:defcfun ("DestroyDrawInfo" destroy-draw-info) :pointer (arg1 :pointer))
 (cffi:defcfun ("CloneDrawInfo" clone-draw-info) :pointer (arg1 :pointer) (arg2 :pointer)))
