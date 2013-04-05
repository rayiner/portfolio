;;; WARNING: This is a generated file, editing it is not advised!
(in-package :cl-user)
(asdf:operate 'asdf:load-op :verrazano-runtime)
(DEFPACKAGE :LDAP-CFFI-BINDINGS (:USE :CFFI) (:NICKNAMES)
            (:EXPORT "+LDAP-URL-ERR-BADEXTS+" "+LDAP-URL-ERR-BADFILTER+" "+LDAP-URL-ERR-BADSCOPE+"
             "+LDAP-URL-ERR-BADATTRS+" "+LDAP-URL-ERR-BADHOST+" "+LDAP-URL-ERR-BADURL+"
             "+LDAP-URL-ERR-BADENCLOSURE+" "+LDAP-URL-ERR-BADSCHEME+" "+LDAP-URL-ERR-PARAM+"
             "+LDAP-URL-ERR-MEM+" "+LDAP-URL-SUCCESS+" "+LDAP-MSG-RECEIVED+" "+LDAP-MSG-ALL+"
             "+LDAP-MSG-ONE+" "+LDAP-NO-LIMIT+" "+LDAP-DEREF-ALWAYS+" "+LDAP-DEREF-FINDING+"
             "+LDAP-DEREF-SEARCHING+" "+LDAP-DEREF-NEVER+" "+LDAP-REFERRAL-LIMIT-EXCEEDED+"
             "+LDAP-CLIENT-LOOP+" "+LDAP-MORE-RESULTS-TO-RETURN+" "+LDAP-NO-RESULTS-RETURNED+"
             "+LDAP-CONTROL-NOT-FOUND+" "+LDAP-NOT-SUPPORTED+" "+LDAP-CONNECT-ERROR+"
             "+LDAP-NO-MEMORY+" "+LDAP-PARAM-ERROR+" "+LDAP-USER-CANCELLED+" "+LDAP-FILTER-ERROR+"
             "+LDAP-AUTH-UNKNOWN+" "+LDAP-TIMEOUT+" "+LDAP-DECODING-ERROR+" "+LDAP-ENCODING-ERROR+"
             "+LDAP-LOCAL-ERROR+" "+LDAP-SERVER-DOWN+" "+LDAP-OTHER+"
             "+LDAP-AFFECTS-MULTIPLE-DSAS+" "+LDAP-RESULTS-TOO-LARGE+"
             "+LDAP-NO-OBJECT-CLASS-MODS+" "+LDAP-ALREADY-EXISTS+" "+LDAP-NOT-ALLOWED-ON-RDN+"
             "+LDAP-NOT-ALLOWED-ON-NONLEAF+" "+LDAP-OBJECT-CLASS-VIOLATION+"
             "+LDAP-NAMING-VIOLATION+" "+LDAP-LOOP-DETECT+" "+LDAP-UNWILLING-TO-PERFORM+"
             "+LDAP-UNAVAILABLE+" "+LDAP-BUSY+" "+LDAP-INSUFFICIENT-ACCESS+"
             "+LDAP-INVALID-CREDENTIALS+" "+LDAP-INAPPROPRIATE-AUTH+" "+LDAP-PROXY-AUTHZ-FAILURE+"
             "+LDAP-ALIAS-DEREF-PROBLEM+" "+LDAP-IS-LEAF+" "+LDAP-INVALID-DN-SYNTAX+"
             "+LDAP-ALIAS-PROBLEM+" "+LDAP-NO-SUCH-OBJECT+" "+LDAP-INVALID-SYNTAX+"
             "+LDAP-TYPE-OR-VALUE-EXISTS+" "+LDAP-CONSTRAINT-VIOLATION+"
             "+LDAP-INAPPROPRIATE-MATCHING+" "+LDAP-UNDEFINED-TYPE+" "+LDAP-NO-SUCH-ATTRIBUTE+"
             "+LDAP-SASL-BIND-IN-PROGRESS+" "+LDAP-CONFIDENTIALITY-REQUIRED+"
             "+LDAP-UNAVAILABLE-CRITICAL-EXTENSION+" "+LDAP-ADMINLIMIT-EXCEEDED+" "+LDAP-REFERRAL+"
             "+LDAP-PARTIAL-RESULTS+" "+LDAP-STRONG-AUTH-REQUIRED+"
             "+LDAP-AUTH-METHOD-NOT-SUPPORTED+" "+LDAP-COMPARE-TRUE+" "+LDAP-COMPARE-FALSE+"
             "+LDAP-SIZELIMIT-EXCEEDED+" "+LDAP-TIMELIMIT-EXCEEDED+" "+LDAP-PROTOCOL-ERROR+"
             "+LDAP-OPERATIONS-ERROR+" "+LDAP-SUCCESS+" "+LDAP-OPT-SUCCESS+"
             "+LDAP-OPT-X-SASL-MAXBUFSIZE+" "+LDAP-OPT-X-SASL-SSF-MAX+" "+LDAP-OPT-X-SASL-SSF-MIN+"
             "+LDAP-OPT-X-SASL-SECPROPS+" "+LDAP-OPT-X-SASL-SSF-EXTERNAL+" "+LDAP-OPT-X-SASL-SSF+"
             "+LDAP-OPT-X-SASL-AUTHZID+" "+LDAP-OPT-X-SASL-AUTHCID+" "+LDAP-OPT-X-SASL-REALM+"
             "+LDAP-OPT-X-SASL-MECH+" "+LDAP-OPT-X-TLS-TRY+" "+LDAP-OPT-X-TLS-ALLOW+"
             "+LDAP-OPT-X-TLS-DEMAND+" "+LDAP-OPT-X-TLS-HARD+" "+LDAP-OPT-X-TLS-NEVER+"
             "+LDAP-OPT-X-TLS-SSL-CTX+" "+LDAP-OPT-X-TLS-RANDOM-FILE+"
             "+LDAP-OPT-X-TLS-CIPHER-SUITE+" "+LDAP-OPT-X-TLS-REQUIRE-CERT+"
             "+LDAP-OPT-X-TLS-KEYFILE+" "+LDAP-OPT-X-TLS-CERTFILE+" "+LDAP-OPT-X-TLS-CACERTDIR+"
             "+LDAP-OPT-X-TLS-CACERTFILE+" "+LDAP-OPT-X-TLS-CTX+" "+LDAP-OPT-X-TLS+"
             "+LDAP-OPT-REFERRAL-URLS+" "+LDAP-OPT-URI+" "+LDAP-OPT-NETWORK-TIMEOUT+"
             "+LDAP-OPT-REFHOPLIMIT+" "+LDAP-OPT-TIMEOUT+" "+LDAP-OPT-DEBUG-LEVEL+"
             "+LDAP-OPT-PRIVATE-EXTENSION-BASE+" "+LDAP-OPT-MATCHED-DN+" "+LDAP-OPT-ERROR-STRING+"
             "+LDAP-OPT-ERROR-NUMBER+" "+LDAP-OPT-HOST-NAME+" "+LDAP-OPT-API-FEATURE-INFO+"
             "+LDAP-OPT-CLIENT-CONTROLS+" "+LDAP-OPT-SERVER-CONTROLS+"
             "+LDAP-OPT-PROTOCOL-VERSION+" "+LDAP-OPT-RESTART+" "+LDAP-OPT-REFERRALS+"
             "+LDAP-OPT-TIMELIMIT+" "+LDAP-OPT-SIZELIMIT+" "+LDAP-OPT-DEREF+" "+LDAP-OPT-DESC+"
             "+LDAP-OPT-API-INFO+" "+LDAPS-PORT+" "+LDAP-PORT+" "+LDAP-API-VERSION+"
             "+LDAP-VERSION-3+" "+LDAP-VERSION-2+" "+LDAP-VERSION-1+" "LDAP-GET-OPTION"
             "LDAP-SET-OPTION" "LDAP-SET-REBIND-PROC" "LDAP-CREATE-CONTROL" "LDAP-CONTROL-FREE"
             "LDAP-CONTROLS-FREE" "LDAP-DOMAIN-2DN" "LDAP-DN-2DOMAIN" "LDAP-DOMAIN-2HOSTLIST"
             "LDAP-EXTENDED-OPERATION" "LDAP-EXTENDED-OPERATION-S" "LDAP-PARSE-EXTENDED-RESULT"
             "LDAP-PARSE-EXTENDED-PARTIAL" "LDAP-PARSE-INTERMEDIATE-RESP-RESULT" "LDAP-ABANDON-EXT"
             "LDAP-ABANDON" "LDAP-ADD-EXT" "LDAP-ADD-EXT-S" "LDAP-ADD" "LDAP-ADD-S"
             "LDAP-SASL-BIND" "LDAP-SASL-INTERACTIVE-BIND-S" "LDAP-SASL-BIND-S"
             "LDAP-PARSE-SASL-BIND-RESULT" "LDAP-BIND" "LDAP-BIND-S" "LDAP-SIMPLE-BIND"
             "LDAP-SIMPLE-BIND-S" "LDAP-KERBEROS-BIND-S" "LDAP-KERBEROS-BIND-1"
             "LDAP-KERBEROS-BIND-1-S" "LDAP-KERBEROS-BIND-2" "LDAP-KERBEROS-BIND-2-S" "LDAP-CANCEL"
             "LDAP-CANCEL-S" "LDAP-COMPARE-EXT" "LDAP-COMPARE-EXT-S" "LDAP-COMPARE"
             "LDAP-COMPARE-S" "LDAP-DELETE-EXT" "LDAP-DELETE-EXT-S" "LDAP-DELETE" "LDAP-DELETE-S"
             "LDAP-PARSE-RESULT" "LDAP-ERR-2STRING" "LDAP-RESULT-2ERROR" "LDAP-PERROR"
             "LDAP-MODIFY-EXT" "LDAP-MODIFY-EXT-S" "LDAP-MODIFY" "LDAP-MODIFY-S" "LDAP-RENAME"
             "LDAP-RENAME-S" "LDAP-RENAME-2" "LDAP-RENAME-2-S" "LDAP-MODRDN" "LDAP-MODRDN-S"
             "LDAP-MODRDN-2" "LDAP-MODRDN-2-S" "LDAP-INIT" "LDAP-OPEN" "LDAP-CREATE"
             "LDAP-INITIALIZE" "LDAP-START-TLS-S" "LDAP-FIRST-MESSAGE" "LDAP-NEXT-MESSAGE"
             "LDAP-COUNT-MESSAGES" "LDAP-FIRST-REFERENCE" "LDAP-NEXT-REFERENCE"
             "LDAP-COUNT-REFERENCES" "LDAP-PARSE-REFERENCE" "LDAP-FIRST-ENTRY" "LDAP-NEXT-ENTRY"
             "LDAP-COUNT-ENTRIES" "LDAP-GET-ENTRY-CONTROLS" "LDAP-DELETE-RESULT-ENTRY"
             "LDAP-ADD-RESULT-ENTRY" "LDAP-GET-DN" "LDAP-AVAFREE" "LDAP-RDNFREE" "LDAP-DNFREE"
             "LDAP-BV-2DN" "LDAP-STR-2DN" "LDAP-DN-2BV" "LDAP-DN-2STR" "LDAP-BV-2RDN"
             "LDAP-STR-2RDN" "LDAP-RDN-2BV" "LDAP-RDN-2STR" "LDAP-DN-NORMALIZE" "LDAP-DN-2UFN"
             "LDAP-EXPLODE-DN" "LDAP-EXPLODE-RDN" "LDAP-X-509DN-2BV" "LDAP-DN-2DCEDN"
             "LDAP-DCEDN-2DN" "LDAP-DN-2AD-CANONICAL" "LDAP-GET-DN-BER" "LDAP-GET-ATTRIBUTE-BER"
             "LDAP-FIRST-ATTRIBUTE" "LDAP-NEXT-ATTRIBUTE" "LDAP-GET-VALUES-LEN"
             "LDAP-COUNT-VALUES-LEN" "LDAP-VALUE-FREE-LEN" "LDAP-GET-VALUES" "LDAP-COUNT-VALUES"
             "LDAP-VALUE-FREE" "LDAP-RESULT" "LDAP-MSGTYPE" "LDAP-MSGID" "LDAP-MSGFREE"
             "LDAP-MSGDELETE" "LDAP-SEARCH-EXT" "LDAP-SEARCH-EXT-S" "LDAP-SEARCH" "LDAP-SEARCH-S"
             "LDAP-SEARCH-ST" "LDAP-UNBIND" "LDAP-UNBIND-S" "LDAP-UNBIND-EXT" "LDAP-UNBIND-EXT-S"
             "LDAP-PUT-VR-FILTER" "LDAP-MEMALLOC" "LDAP-MEMREALLOC" "LDAP-MEMCALLOC" "LDAP-MEMFREE"
             "LDAP-MEMVFREE" "LDAP-STRDUP" "LDAP-MODS-FREE" "LDAP-SORT-ENTRIES" "LDAP-SORT-VALUES"
             "LDAP-SORT-STRCASECMP" "LDAP-IS-LDAP-URL" "LDAP-IS-LDAPS-URL" "LDAP-IS-LDAPI-URL"
             "LDAP-URL-PARSE" "LDAP-URL-DESC-2STR" "LDAP-FREE-URLDESC" "LDAP-CREATE-SORT-KEYLIST"
             "LDAP-FREE-SORT-KEYLIST" "LDAP-CREATE-SORT-CONTROL" "LDAP-PARSE-SORT-CONTROL"
             "LDAP-CREATE-VLV-CONTROL" "LDAP-PARSE-VLV-CONTROL" "LDAP-PARSE-WHOAMI" "LDAP-WHOAMI"
             "LDAP-WHOAMI-S" "LDAP-PARSE-PASSWD" "LDAP-PASSWD" "LDAP-PASSWD-S" "LDAP-NTLM-BIND"
             "LDAP-PARSE-NTLM-BIND-RESULT" "TIMEVAL" "BERELEMENT" "LDAPMSG" "LDAP" "LDAPVLVINFO"
             "LDAPSORTKEY" "LDAP-AVA" "LDAP-URL-DESC" "LDAPMOD" "LDAPMOD-MOD-VALS-U" "LDAPCONTROL"
             "LDAP-APIFEATURE-INFO" "LDAPAPIINFO" "BERVAL" "LDAPAPII-NFO" "LDAPAPIF-EATURE-INFO"
             "LDAP-REBIND-PROC" "LDAP-SASL-INTERACT-PROC" "LDAPAVA" "LDAPRDN" "LDAPDN"
             "LDAPDN-REWRITE-FUNC" "BER-ELEMENT" "LDAPM-OD" "LDAP-SORT-AD-CMP-PROC"
             "LDAP-SORT-AV-CMP-PROC" "LDAPURLD-ESC" "LDAPS-ORT-KEY" "LDAPVLVI-NFO" "LDAPC-ONTROL"
             "BER-TAG-T" "LDAPM-ESSAGE" "LDAP" "BER-LEN-T"))

(in-package :LDAP-CFFI-BINDINGS)
(cffi::defctype* ber-len-t :unsigned-long)
(cffi:defcstruct berval (bv-len ber-len-t) (bv-val :pointer))
(cffi:defcstruct ldapapiinfo (ldapai-info-version :int) (ldapai-api-version :int)
 (ldapai-protocol-version :int) (ldapai-extensions :pointer) (ldapai-vendor-name :pointer)
 (ldapai-vendor-version :int))
(cffi:defcstruct ldap-apifeature-info (ldapaif-info-version :int) (ldapaif-name :pointer)
 (ldapaif-version :int))
(cffi:defcstruct ldapcontrol (ldctl-oid :pointer) (ldctl-value berval) (ldctl-iscritical :char))
(cffi:defcstruct ldapmod-mod-vals-u (modv-strvals :pointer) (modv-bvals :pointer))
(cffi:defcstruct ldapmod (mod-op :int) (mod-type :pointer) (mod-vals ldapmod-mod-vals-u))
(cffi:defcstruct ldap-url-desc (lud-next :pointer) (lud-scheme :pointer) (lud-host :pointer)
 (lud-port :int) (lud-dn :pointer) (lud-attrs :pointer) (lud-scope :int) (lud-filter :pointer)
 (lud-exts :pointer) (lud-crit-exts :int))
(cffi:defcstruct ldap-ava (la-attr berval) (la-value berval) (la-flags :unsigned-int)
 (la-private :pointer))
(cffi:defcstruct ldapsortkey (attribute-type :pointer) (ordering-rule :pointer)
 (reverse-order :int))
(cffi:defcstruct ldapvlvinfo (ldvlv-version :int) (ldvlv-before-count :unsigned-long)
 (ldvlv-after-count :unsigned-long) (ldvlv-offset :unsigned-long) (ldvlv-count :unsigned-long)
 (ldvlv-attrvalue :pointer) (ldvlv-context :pointer) (ldvlv-extradata :pointer))
(cffi::defctype* ldap ldap)
(cffi:defcstruct ldap)
(cffi::defctype* ldapm-essage ldapmsg)
(cffi:defcstruct ldapmsg)
(cffi::defctype* ber-tag-t :unsigned-long)
(cffi::defctype* ldapc-ontrol ldapcontrol)
(cffi::defctype* ldapvlvi-nfo ldapvlvinfo)
(cffi::defctype* ldaps-ort-key ldapsortkey)
(cffi::defctype* ldapurld-esc ldap-url-desc)
(cffi::defctype* ldap-sort-av-cmp-proc anonymous317)
(cffi::defctype* ldap-sort-ad-cmp-proc anonymous320)
(cffi::defctype* ldapm-od ldapmod)
(cffi::defctype* ber-element berelement)
(cffi:defcstruct berelement)
(cffi:defcstruct timeval)
(cffi::defctype* ldapdn-rewrite-func anonymous339)
(cffi::defctype* ldapdn :pointer)
(cffi::defctype* ldaprdn :pointer)
(cffi::defctype* ldapava ldap-ava)
(cffi::defctype* ldap-sasl-interact-proc anonymous345)
(cffi::defctype* ldap-rebind-proc anonymous347)
(cffi::defctype* ldapapif-eature-info ldap-apifeature-info)
(cffi::defctype* ldapapii-nfo ldapapiinfo)
(cl:progn
 (cffi:defcfun ("ldap_parse_ntlm_bind_result" ldap-parse-ntlm-bind-result) :int (ld :pointer)
  (res :pointer) (challenge :pointer))
 (cffi:defcfun ("ldap_ntlm_bind" ldap-ntlm-bind) :int (ld :pointer) (dn :string) (tag ber-tag-t)
  (cred :pointer) (sctrls :pointer) (cctrls :pointer) (msgidp :pointer))
 (cffi:defcfun ("ldap_passwd_s" ldap-passwd-s) :int (ld :pointer) (user :pointer) (oldpw :pointer)
  (newpw :pointer) (newpasswd :pointer) (sctrls :pointer) (cctrls :pointer))
 (cffi:defcfun ("ldap_passwd" ldap-passwd) :int (ld :pointer) (user :pointer) (oldpw :pointer)
  (newpw :pointer) (sctrls :pointer) (cctrls :pointer) (msgidp :pointer))
 (cffi:defcfun ("ldap_parse_passwd" ldap-parse-passwd) :int (ld :pointer) (res :pointer)
  (newpasswd :pointer))
 (cffi:defcfun ("ldap_whoami_s" ldap-whoami-s) :int (ld :pointer) (authzid :pointer)
  (sctrls :pointer) (cctrls :pointer))
 (cffi:defcfun ("ldap_whoami" ldap-whoami) :int (ld :pointer) (sctrls :pointer) (cctrls :pointer)
  (msgidp :pointer))
 (cffi:defcfun ("ldap_parse_whoami" ldap-parse-whoami) :int (ld :pointer) (res :pointer)
  (authzid :pointer))
 (cffi:defcfun ("ldap_parse_vlv_control" ldap-parse-vlv-control) :int (ld :pointer)
  (ctrls :pointer) (target_posp :pointer) (list_countp :pointer) (contextp :pointer)
  (errcodep :pointer))
 (cffi:defcfun ("ldap_create_vlv_control" ldap-create-vlv-control) :int (ld :pointer)
  (ldvlistp :pointer) (ctrlp :pointer))
 (cffi:defcfun ("ldap_parse_sort_control" ldap-parse-sort-control) :int (ld :pointer)
  (ctrlp :pointer) (result :pointer) (attribute :pointer))
 (cffi:defcfun ("ldap_create_sort_control" ldap-create-sort-control) :int (ld :pointer)
  (keyList :pointer) (ctl_iscritical :int) (ctrlp :pointer))
 (cffi:defcfun ("ldap_free_sort_keylist" ldap-free-sort-keylist) :void (sortkeylist :pointer))
 (cffi:defcfun ("ldap_create_sort_keylist" ldap-create-sort-keylist) :int (sortKeyList :pointer)
  (keyString :pointer))
 (cffi:defcfun ("ldap_free_urldesc" ldap-free-urldesc) :void (ludp :pointer))
 (cffi:defcfun ("ldap_url_desc2str" ldap-url-desc-2str) :pointer (ludp :pointer))
 (cffi:defcfun ("ldap_url_parse" ldap-url-parse) :int (url :string) (ludpp :pointer))
 (cffi:defcfun ("ldap_is_ldapi_url" ldap-is-ldapi-url) :int (url :string))
 (cffi:defcfun ("ldap_is_ldaps_url" ldap-is-ldaps-url) :int (url :string))
 (cffi:defcfun ("ldap_is_ldap_url" ldap-is-ldap-url) :int (url :string))
 (cffi:defcfun ("ldap_sort_strcasecmp" ldap-sort-strcasecmp) :int (a :pointer) (b :pointer))
 (cffi:defcfun ("ldap_sort_values" ldap-sort-values) :int (ld :pointer) (vals :pointer)
  (cmp :pointer))
 (cffi:defcfun ("ldap_sort_entries" ldap-sort-entries) :int (ld :pointer) (chain :pointer)
  (attr :string) (cmp :pointer))
 (cffi:defcfun ("ldap_mods_free" ldap-mods-free) :void (mods :pointer) (freemods :int))
 (cffi:defcfun ("ldap_strdup" ldap-strdup) :pointer (arg1 :string))
 (cffi:defcfun ("ldap_memvfree" ldap-memvfree) :void (v :pointer))
 (cffi:defcfun ("ldap_memfree" ldap-memfree) :void (p :pointer))
 (cffi:defcfun ("ldap_memcalloc" ldap-memcalloc) :pointer (n ber-len-t) (s ber-len-t))
 (cffi:defcfun ("ldap_memrealloc" ldap-memrealloc) :pointer (p :pointer) (s ber-len-t))
 (cffi:defcfun ("ldap_memalloc" ldap-memalloc) :pointer (s ber-len-t))
 (cffi:defcfun ("ldap_put_vrFilter" ldap-put-vr-filter) :int (ber :pointer) (vrf :string))
 (cffi:defcfun ("ldap_unbind_ext_s" ldap-unbind-ext-s) :int (ld :pointer) (serverctrls :pointer)
  (clientctrls :pointer))
 (cffi:defcfun ("ldap_unbind_ext" ldap-unbind-ext) :int (ld :pointer) (serverctrls :pointer)
  (clientctrls :pointer))
 (cffi:defcfun ("ldap_unbind_s" ldap-unbind-s) :int (ld :pointer))
 (cffi:defcfun ("ldap_unbind" ldap-unbind) :int (ld :pointer))
 (cffi:defcfun ("ldap_search_st" ldap-search-st) :int (ld :pointer) (base :string) (scope :int)
  (filter :string) (attrs :pointer) (attrsonly :int) (timeout :pointer) (res :pointer))
 (cffi:defcfun ("ldap_search_s" ldap-search-s) :int (ld :pointer) (base :string) (scope :int)
  (filter :string) (attrs :pointer) (attrsonly :int) (res :pointer))
 (cffi:defcfun ("ldap_search" ldap-search) :int (ld :pointer) (base :string) (scope :int)
  (filter :string) (attrs :pointer) (attrsonly :int))
 (cffi:defcfun ("ldap_search_ext_s" ldap-search-ext-s) :int (ld :pointer) (base :string)
  (scope :int) (filter :string) (attrs :pointer) (attrsonly :int) (serverctrls :pointer)
  (clientctrls :pointer) (timeout :pointer) (sizelimit :int) (res :pointer))
 (cffi:defcfun ("ldap_search_ext" ldap-search-ext) :int (ld :pointer) (base :string) (scope :int)
  (filter :string) (attrs :pointer) (attrsonly :int) (serverctrls :pointer) (clientctrls :pointer)
  (timeout :pointer) (sizelimit :int) (msgidp :pointer))
 (cffi:defcfun ("ldap_msgdelete" ldap-msgdelete) :int (ld :pointer) (msgid :int))
 (cffi:defcfun ("ldap_msgfree" ldap-msgfree) :int (lm :pointer))
 (cffi:defcfun ("ldap_msgid" ldap-msgid) :int (lm :pointer))
 (cffi:defcfun ("ldap_msgtype" ldap-msgtype) :int (lm :pointer))
 (cffi:defcfun ("ldap_result" ldap-result) :int (ld :pointer) (msgid :int) (all :int)
  (timeout :pointer) (result :pointer))
 (cffi:defcfun ("ldap_value_free" ldap-value-free) :void (vals :pointer))
 (cffi:defcfun ("ldap_count_values" ldap-count-values) :int (vals :pointer))
 (cffi:defcfun ("ldap_get_values" ldap-get-values) :pointer (ld :pointer) (entry :pointer)
  (target :string))
 (cffi:defcfun ("ldap_value_free_len" ldap-value-free-len) :void (vals :pointer))
 (cffi:defcfun ("ldap_count_values_len" ldap-count-values-len) :int (vals :pointer))
 (cffi:defcfun ("ldap_get_values_len" ldap-get-values-len) :pointer (ld :pointer) (entry :pointer)
  (target :string))
 (cffi:defcfun ("ldap_next_attribute" ldap-next-attribute) :pointer (ld :pointer) (entry :pointer)
  (ber :pointer))
 (cffi:defcfun ("ldap_first_attribute" ldap-first-attribute) :pointer (ld :pointer)
  (entry :pointer) (ber :pointer))
 (cffi:defcfun ("ldap_get_attribute_ber" ldap-get-attribute-ber) :int (ld :pointer) (e :pointer)
  (ber :pointer) (attr :pointer) (vals :pointer))
 (cffi:defcfun ("ldap_get_dn_ber" ldap-get-dn-ber) :int (ld :pointer) (e :pointer)
  (berout :pointer) (dn :pointer))
 (cffi:defcfun ("ldap_dn2ad_canonical" ldap-dn-2ad-canonical) :pointer (dn :string))
 (cffi:defcfun ("ldap_dcedn2dn" ldap-dcedn-2dn) :pointer (dce :string))
 (cffi:defcfun ("ldap_dn2dcedn" ldap-dn-2dcedn) :pointer (dn :string))
 (cffi:defcfun ("ldap_X509dn2bv" ldap-x-509dn-2bv) :int (x509_name :pointer) (dn :pointer)
  (func :pointer) (flags :unsigned-int))
 (cffi:defcfun ("ldap_explode_rdn" ldap-explode-rdn) :pointer (rdn :string) (notypes :int))
 (cffi:defcfun ("ldap_explode_dn" ldap-explode-dn) :pointer (dn :string) (notypes :int))
 (cffi:defcfun ("ldap_dn2ufn" ldap-dn-2ufn) :pointer (dn :string))
 (cffi:defcfun ("ldap_dn_normalize" ldap-dn-normalize) :int (in :string) (iflags :unsigned-int)
  (out :pointer) (oflags :unsigned-int))
 (cffi:defcfun ("ldap_rdn2str" ldap-rdn-2str) :int (rdn :pointer) (str :pointer)
  (flags :unsigned-int))
 (cffi:defcfun ("ldap_rdn2bv" ldap-rdn-2bv) :int (rdn :pointer) (bv :pointer)
  (flags :unsigned-int))
 (cffi:defcfun ("ldap_str2rdn" ldap-str-2rdn) :int (str :string) (rdn :pointer) (next :pointer)
  (flags :unsigned-int))
 (cffi:defcfun ("ldap_bv2rdn" ldap-bv-2rdn) :int (bv :pointer) (rdn :pointer) (next :pointer)
  (flags :unsigned-int))
 (cffi:defcfun ("ldap_dn2str" ldap-dn-2str) :int (dn :pointer) (str :pointer)
  (flags :unsigned-int))
 (cffi:defcfun ("ldap_dn2bv" ldap-dn-2bv) :int (dn :pointer) (bv :pointer) (flags :unsigned-int))
 (cffi:defcfun ("ldap_str2dn" ldap-str-2dn) :int (str :string) (dn :pointer) (flags :unsigned-int))
 (cffi:defcfun ("ldap_bv2dn" ldap-bv-2dn) :int (bv :pointer) (dn :pointer) (flags :unsigned-int))
 (cffi:defcfun ("ldap_dnfree" ldap-dnfree) :void (dn :pointer))
 (cffi:defcfun ("ldap_rdnfree" ldap-rdnfree) :void (rdn :pointer))
 (cffi:defcfun ("ldap_avafree" ldap-avafree) :void (ava :pointer))
 (cffi:defcfun ("ldap_get_dn" ldap-get-dn) :pointer (ld :pointer) (entry :pointer))
 (cffi:defcfun ("ldap_add_result_entry" ldap-add-result-entry) :void (list :pointer) (e :pointer))
 (cffi:defcfun ("ldap_delete_result_entry" ldap-delete-result-entry) :pointer (list :pointer)
  (e :pointer))
 (cffi:defcfun ("ldap_get_entry_controls" ldap-get-entry-controls) :int (ld :pointer)
  (entry :pointer) (serverctrls :pointer))
 (cffi:defcfun ("ldap_count_entries" ldap-count-entries) :int (ld :pointer) (chain :pointer))
 (cffi:defcfun ("ldap_next_entry" ldap-next-entry) :pointer (ld :pointer) (entry :pointer))
 (cffi:defcfun ("ldap_first_entry" ldap-first-entry) :pointer (ld :pointer) (chain :pointer))
 (cffi:defcfun ("ldap_parse_reference" ldap-parse-reference) :int (ld :pointer) (ref :pointer)
  (referralsp :pointer) (serverctrls :pointer) (freeit :int))
 (cffi:defcfun ("ldap_count_references" ldap-count-references) :int (ld :pointer) (chain :pointer))
 (cffi:defcfun ("ldap_next_reference" ldap-next-reference) :pointer (ld :pointer) (ref :pointer))
 (cffi:defcfun ("ldap_first_reference" ldap-first-reference) :pointer (ld :pointer)
  (chain :pointer))
 (cffi:defcfun ("ldap_count_messages" ldap-count-messages) :int (ld :pointer) (chain :pointer))
 (cffi:defcfun ("ldap_next_message" ldap-next-message) :pointer (ld :pointer) (msg :pointer))
 (cffi:defcfun ("ldap_first_message" ldap-first-message) :pointer (ld :pointer) (chain :pointer))
 (cffi:defcfun ("ldap_start_tls_s" ldap-start-tls-s) :int (ld :pointer) (serverctrls :pointer)
  (clientctrls :pointer))
 (cffi:defcfun ("ldap_initialize" ldap-initialize) :int (ldp :pointer) (url :string))
 (cffi:defcfun ("ldap_create" ldap-create) :int (ldp :pointer))
 (cffi:defcfun ("ldap_open" ldap-open) :pointer (host :string) (port :int))
 (cffi:defcfun ("ldap_init" ldap-init) :pointer (host :string) (port :int))
 (cffi:defcfun ("ldap_modrdn2_s" ldap-modrdn-2-s) :int (ld :pointer) (dn :string) (newrdn :string)
  (deleteoldrdn :int))
 (cffi:defcfun ("ldap_modrdn2" ldap-modrdn-2) :int (ld :pointer) (dn :string) (newrdn :string)
  (deleteoldrdn :int))
 (cffi:defcfun ("ldap_modrdn_s" ldap-modrdn-s) :int (ld :pointer) (dn :string) (newrdn :string))
 (cffi:defcfun ("ldap_modrdn" ldap-modrdn) :int (ld :pointer) (dn :string) (newrdn :string))
 (cffi:defcfun ("ldap_rename2_s" ldap-rename-2-s) :int (ld :pointer) (dn :string) (newrdn :string)
  (newSuperior :string) (deleteoldrdn :int))
 (cffi:defcfun ("ldap_rename2" ldap-rename-2) :int (ld :pointer) (dn :string) (newrdn :string)
  (newSuperior :string) (deleteoldrdn :int))
 (cffi:defcfun ("ldap_rename_s" ldap-rename-s) :int (ld :pointer) (dn :string) (newrdn :string)
  (newSuperior :string) (deleteoldrdn :int) (sctrls :pointer) (cctrls :pointer))
 (cffi:defcfun ("ldap_rename" ldap-rename) :int (ld :pointer) (dn :string) (newrdn :string)
  (newSuperior :string) (deleteoldrdn :int) (sctrls :pointer) (cctrls :pointer) (msgidp :pointer))
 (cffi:defcfun ("ldap_modify_s" ldap-modify-s) :int (ld :pointer) (dn :string) (mods :pointer))
 (cffi:defcfun ("ldap_modify" ldap-modify) :int (ld :pointer) (dn :string) (mods :pointer))
 (cffi:defcfun ("ldap_modify_ext_s" ldap-modify-ext-s) :int (ld :pointer) (dn :string)
  (mods :pointer) (serverctrls :pointer) (clientctrls :pointer))
 (cffi:defcfun ("ldap_modify_ext" ldap-modify-ext) :int (ld :pointer) (dn :string) (mods :pointer)
  (serverctrls :pointer) (clientctrls :pointer) (msgidp :pointer))
 (cffi:defcfun ("ldap_perror" ldap-perror) :void (ld :pointer) (s :string))
 (cffi:defcfun ("ldap_result2error" ldap-result-2error) :int (ld :pointer) (r :pointer)
  (freeit :int))
 (cffi:defcfun ("ldap_err2string" ldap-err-2string) :pointer (err :int))
 (cffi:defcfun ("ldap_parse_result" ldap-parse-result) :int (ld :pointer) (res :pointer)
  (errcodep :pointer) (matcheddnp :pointer) (errmsgp :pointer) (referralsp :pointer)
  (serverctrls :pointer) (freeit :int))
 (cffi:defcfun ("ldap_delete_s" ldap-delete-s) :int (ld :pointer) (dn :string))
 (cffi:defcfun ("ldap_delete" ldap-delete) :int (ld :pointer) (dn :string))
 (cffi:defcfun ("ldap_delete_ext_s" ldap-delete-ext-s) :int (ld :pointer) (dn :string)
  (serverctrls :pointer) (clientctrls :pointer))
 (cffi:defcfun ("ldap_delete_ext" ldap-delete-ext) :int (ld :pointer) (dn :string)
  (serverctrls :pointer) (clientctrls :pointer) (msgidp :pointer))
 (cffi:defcfun ("ldap_compare_s" ldap-compare-s) :int (ld :pointer) (dn :string) (attr :string)
  (value :string))
 (cffi:defcfun ("ldap_compare" ldap-compare) :int (ld :pointer) (dn :string) (attr :string)
  (value :string))
 (cffi:defcfun ("ldap_compare_ext_s" ldap-compare-ext-s) :int (ld :pointer) (dn :string)
  (attr :string) (bvalue :pointer) (serverctrls :pointer) (clientctrls :pointer))
 (cffi:defcfun ("ldap_compare_ext" ldap-compare-ext) :int (ld :pointer) (dn :string) (attr :string)
  (bvalue :pointer) (serverctrls :pointer) (clientctrls :pointer) (msgidp :pointer))
 (cffi:defcfun ("ldap_cancel_s" ldap-cancel-s) :int (ld :pointer) (cancelid :int) (sctrl :pointer)
  (cctrl :pointer))
 (cffi:defcfun ("ldap_cancel" ldap-cancel) :int (ld :pointer) (cancelid :int) (sctrls :pointer)
  (cctrls :pointer) (msgidp :pointer))
 (cffi:defcfun ("ldap_kerberos_bind2_s" ldap-kerberos-bind-2-s) :int (ld :pointer) (who :string))
 (cffi:defcfun ("ldap_kerberos_bind2" ldap-kerberos-bind-2) :int (ld :pointer) (who :string))
 (cffi:defcfun ("ldap_kerberos_bind1_s" ldap-kerberos-bind-1-s) :int (ld :pointer) (who :string))
 (cffi:defcfun ("ldap_kerberos_bind1" ldap-kerberos-bind-1) :int (ld :pointer) (who :string))
 (cffi:defcfun ("ldap_kerberos_bind_s" ldap-kerberos-bind-s) :int (ld :pointer) (who :string))
 (cffi:defcfun ("ldap_simple_bind_s" ldap-simple-bind-s) :int (ld :pointer) (who :string)
  (passwd :string))
 (cffi:defcfun ("ldap_simple_bind" ldap-simple-bind) :int (ld :pointer) (who :string)
  (passwd :string))
 (cffi:defcfun ("ldap_bind_s" ldap-bind-s) :int (ld :pointer) (who :string) (cred :string)
  (authmethod :int))
 (cffi:defcfun ("ldap_bind" ldap-bind) :int (ld :pointer) (who :string) (passwd :string)
  (authmethod :int))
 (cffi:defcfun ("ldap_parse_sasl_bind_result" ldap-parse-sasl-bind-result) :int (ld :pointer)
  (res :pointer) (servercredp :pointer) (freeit :int))
 (cffi:defcfun ("ldap_sasl_bind_s" ldap-sasl-bind-s) :int (ld :pointer) (dn :string)
  (mechanism :string) (cred :pointer) (serverctrls :pointer) (clientctrls :pointer)
  (servercredp :pointer))
 (cffi:defcfun ("ldap_sasl_interactive_bind_s" ldap-sasl-interactive-bind-s) :int (ld :pointer)
  (dn :string) (saslMechanism :string) (serverControls :pointer) (clientControls :pointer)
  (flags :unsigned-int) (proc :pointer) (defaults :pointer))
 (cffi:defcfun ("ldap_sasl_bind" ldap-sasl-bind) :int (ld :pointer) (dn :string)
  (mechanism :string) (cred :pointer) (serverctrls :pointer) (clientctrls :pointer)
  (msgidp :pointer))
 (cffi:defcfun ("ldap_add_s" ldap-add-s) :int (ld :pointer) (dn :string) (attrs :pointer))
 (cffi:defcfun ("ldap_add" ldap-add) :int (ld :pointer) (dn :string) (attrs :pointer))
 (cffi:defcfun ("ldap_add_ext_s" ldap-add-ext-s) :int (ld :pointer) (dn :string) (attrs :pointer)
  (serverctrls :pointer) (clientctrls :pointer))
 (cffi:defcfun ("ldap_add_ext" ldap-add-ext) :int (ld :pointer) (dn :string) (attrs :pointer)
  (serverctrls :pointer) (clientctrls :pointer) (msgidp :pointer))
 (cffi:defcfun ("ldap_abandon" ldap-abandon) :int (ld :pointer) (msgid :int))
 (cffi:defcfun ("ldap_abandon_ext" ldap-abandon-ext) :int (ld :pointer) (msgid :int)
  (serverctrls :pointer) (clientctrls :pointer))
 (cffi:defcfun ("ldap_parse_intermediate_resp_result" ldap-parse-intermediate-resp-result) :int
  (ld :pointer) (res :pointer) (retoidp :pointer) (retdatap :pointer) (freeit :int))
 (cffi:defcfun ("ldap_parse_extended_partial" ldap-parse-extended-partial) :int (ld :pointer)
  (res :pointer) (retoidp :pointer) (retdatap :pointer) (serverctrls :pointer) (freeit :int))
 (cffi:defcfun ("ldap_parse_extended_result" ldap-parse-extended-result) :int (ld :pointer)
  (res :pointer) (retoidp :pointer) (retdatap :pointer) (freeit :int))
 (cffi:defcfun ("ldap_extended_operation_s" ldap-extended-operation-s) :int (ld :pointer)
  (reqoid :string) (reqdata :pointer) (serverctrls :pointer) (clientctrls :pointer)
  (retoidp :pointer) (retdatap :pointer))
 (cffi:defcfun ("ldap_extended_operation" ldap-extended-operation) :int (ld :pointer)
  (reqoid :string) (reqdata :pointer) (serverctrls :pointer) (clientctrls :pointer)
  (msgidp :pointer))
 (cffi:defcfun ("ldap_domain2hostlist" ldap-domain-2hostlist) :int (domain :string)
  (hostlist :pointer))
 (cffi:defcfun ("ldap_dn2domain" ldap-dn-2domain) :int (dn :string) (domain :pointer))
 (cffi:defcfun ("ldap_domain2dn" ldap-domain-2dn) :int (domain :string) (dn :pointer))
 (cffi:defcfun ("ldap_controls_free" ldap-controls-free) :void (ctrls :pointer))
 (cffi:defcfun ("ldap_control_free" ldap-control-free) :void (ctrl :pointer))
 (cffi:defcfun ("ldap_create_control" ldap-create-control) :int (requestOID :string) (ber :pointer)
  (iscritical :int) (ctrlp :pointer))
 (cffi:defcfun ("ldap_set_rebind_proc" ldap-set-rebind-proc) :int (ld :pointer)
  (rebind_proc :pointer) (params :pointer))
 (cffi:defcfun ("ldap_set_option" ldap-set-option) :int (ld :pointer) (option :int)
  (invalue :pointer))
 (cffi:defcfun ("ldap_get_option" ldap-get-option) :int (ld :pointer) (option :int)
  (outvalue :pointer))
 (cl:defconstant +ldap-version-1+ 1) (cl:defconstant +ldap-version-2+ 2)
 (cl:defconstant +ldap-version-3+ 3) (cl:defconstant +ldap-api-version+ 2004)
 (cl:defconstant +ldap-port+ 389) (cl:defconstant +ldaps-port+ 636)
 (cl:defconstant +ldap-opt-api-info+ 0) (cl:defconstant +ldap-opt-desc+ 1)
 (cl:defconstant +ldap-opt-deref+ 2) (cl:defconstant +ldap-opt-sizelimit+ 3)
 (cl:defconstant +ldap-opt-timelimit+ 4) (cl:defconstant +ldap-opt-referrals+ 8)
 (cl:defconstant +ldap-opt-restart+ 9) (cl:defconstant +ldap-opt-protocol-version+ 17)
 (cl:defconstant +ldap-opt-server-controls+ 18) (cl:defconstant +ldap-opt-client-controls+ 19)
 (cl:defconstant +ldap-opt-api-feature-info+ 21) (cl:defconstant +ldap-opt-host-name+ 48)
 (cl:defconstant +ldap-opt-error-number+ 49) (cl:defconstant +ldap-opt-error-string+ 50)
 (cl:defconstant +ldap-opt-matched-dn+ 51) (cl:defconstant +ldap-opt-private-extension-base+ 16384)
 (cl:defconstant +ldap-opt-debug-level+ 20481) (cl:defconstant +ldap-opt-timeout+ 20482)
 (cl:defconstant +ldap-opt-refhoplimit+ 20483) (cl:defconstant +ldap-opt-network-timeout+ 20485)
 (cl:defconstant +ldap-opt-uri+ 20486) (cl:defconstant +ldap-opt-referral-urls+ 20487)
 (cl:defconstant +ldap-opt-x-tls+ 24576) (cl:defconstant +ldap-opt-x-tls-ctx+ 24577)
 (cl:defconstant +ldap-opt-x-tls-cacertfile+ 24578)
 (cl:defconstant +ldap-opt-x-tls-cacertdir+ 24579) (cl:defconstant +ldap-opt-x-tls-certfile+ 24580)
 (cl:defconstant +ldap-opt-x-tls-keyfile+ 24581)
 (cl:defconstant +ldap-opt-x-tls-require-cert+ 24582)
 (cl:defconstant +ldap-opt-x-tls-cipher-suite+ 24584)
 (cl:defconstant +ldap-opt-x-tls-random-file+ 24585)
 (cl:defconstant +ldap-opt-x-tls-ssl-ctx+ 24586) (cl:defconstant +ldap-opt-x-tls-never+ 0)
 (cl:defconstant +ldap-opt-x-tls-hard+ 1) (cl:defconstant +ldap-opt-x-tls-demand+ 2)
 (cl:defconstant +ldap-opt-x-tls-allow+ 3) (cl:defconstant +ldap-opt-x-tls-try+ 4)
 (cl:defconstant +ldap-opt-x-sasl-mech+ 24832) (cl:defconstant +ldap-opt-x-sasl-realm+ 24833)
 (cl:defconstant +ldap-opt-x-sasl-authcid+ 24834) (cl:defconstant +ldap-opt-x-sasl-authzid+ 24835)
 (cl:defconstant +ldap-opt-x-sasl-ssf+ 24836) (cl:defconstant +ldap-opt-x-sasl-ssf-external+ 24837)
 (cl:defconstant +ldap-opt-x-sasl-secprops+ 24838) (cl:defconstant +ldap-opt-x-sasl-ssf-min+ 24839)
 (cl:defconstant +ldap-opt-x-sasl-ssf-max+ 24840)
 (cl:defconstant +ldap-opt-x-sasl-maxbufsize+ 24841) (cl:defconstant +ldap-opt-success+ 0)
 (cl:defconstant +ldap-success+ 0) (cl:defconstant +ldap-operations-error+ 1)
 (cl:defconstant +ldap-protocol-error+ 2) (cl:defconstant +ldap-timelimit-exceeded+ 3)
 (cl:defconstant +ldap-sizelimit-exceeded+ 4) (cl:defconstant +ldap-compare-false+ 5)
 (cl:defconstant +ldap-compare-true+ 6) (cl:defconstant +ldap-auth-method-not-supported+ 7)
 (cl:defconstant +ldap-strong-auth-required+ 8) (cl:defconstant +ldap-partial-results+ 9)
 (cl:defconstant +ldap-referral+ 10) (cl:defconstant +ldap-adminlimit-exceeded+ 11)
 (cl:defconstant +ldap-unavailable-critical-extension+ 12)
 (cl:defconstant +ldap-confidentiality-required+ 13)
 (cl:defconstant +ldap-sasl-bind-in-progress+ 14) (cl:defconstant +ldap-no-such-attribute+ 16)
 (cl:defconstant +ldap-undefined-type+ 17) (cl:defconstant +ldap-inappropriate-matching+ 18)
 (cl:defconstant +ldap-constraint-violation+ 19) (cl:defconstant +ldap-type-or-value-exists+ 20)
 (cl:defconstant +ldap-invalid-syntax+ 21) (cl:defconstant +ldap-no-such-object+ 32)
 (cl:defconstant +ldap-alias-problem+ 33) (cl:defconstant +ldap-invalid-dn-syntax+ 34)
 (cl:defconstant +ldap-is-leaf+ 35) (cl:defconstant +ldap-alias-deref-problem+ 36)
 (cl:defconstant +ldap-proxy-authz-failure+ 47) (cl:defconstant +ldap-inappropriate-auth+ 48)
 (cl:defconstant +ldap-invalid-credentials+ 49) (cl:defconstant +ldap-insufficient-access+ 50)
 (cl:defconstant +ldap-busy+ 51) (cl:defconstant +ldap-unavailable+ 52)
 (cl:defconstant +ldap-unwilling-to-perform+ 53) (cl:defconstant +ldap-loop-detect+ 54)
 (cl:defconstant +ldap-naming-violation+ 64) (cl:defconstant +ldap-object-class-violation+ 65)
 (cl:defconstant +ldap-not-allowed-on-nonleaf+ 66) (cl:defconstant +ldap-not-allowed-on-rdn+ 67)
 (cl:defconstant +ldap-already-exists+ 68) (cl:defconstant +ldap-no-object-class-mods+ 69)
 (cl:defconstant +ldap-results-too-large+ 70) (cl:defconstant +ldap-affects-multiple-dsas+ 71)
 (cl:defconstant +ldap-other+ 80) (cl:defconstant +ldap-server-down+ 81)
 (cl:defconstant +ldap-local-error+ 82) (cl:defconstant +ldap-encoding-error+ 83)
 (cl:defconstant +ldap-decoding-error+ 84) (cl:defconstant +ldap-timeout+ 85)
 (cl:defconstant +ldap-auth-unknown+ 86) (cl:defconstant +ldap-filter-error+ 87)
 (cl:defconstant +ldap-user-cancelled+ 88) (cl:defconstant +ldap-param-error+ 89)
 (cl:defconstant +ldap-no-memory+ 90) (cl:defconstant +ldap-connect-error+ 91)
 (cl:defconstant +ldap-not-supported+ 92) (cl:defconstant +ldap-control-not-found+ 93)
 (cl:defconstant +ldap-no-results-returned+ 94) (cl:defconstant +ldap-more-results-to-return+ 95)
 (cl:defconstant +ldap-client-loop+ 96) (cl:defconstant +ldap-referral-limit-exceeded+ 97)
 (cl:defconstant +ldap-deref-never+ 0) (cl:defconstant +ldap-deref-searching+ 1)
 (cl:defconstant +ldap-deref-finding+ 2) (cl:defconstant +ldap-deref-always+ 3)
 (cl:defconstant +ldap-no-limit+ 0) (cl:defconstant +ldap-msg-one+ 0)
 (cl:defconstant +ldap-msg-all+ 1) (cl:defconstant +ldap-msg-received+ 2)
 (cl:defconstant +ldap-url-success+ 0) (cl:defconstant +ldap-url-err-mem+ 1)
 (cl:defconstant +ldap-url-err-param+ 2) (cl:defconstant +ldap-url-err-badscheme+ 3)
 (cl:defconstant +ldap-url-err-badenclosure+ 4) (cl:defconstant +ldap-url-err-badurl+ 5)
 (cl:defconstant +ldap-url-err-badhost+ 6) (cl:defconstant +ldap-url-err-badattrs+ 7)
 (cl:defconstant +ldap-url-err-badscope+ 8) (cl:defconstant +ldap-url-err-badfilter+ 9)
 (cl:defconstant +ldap-url-err-badexts+ 10))
