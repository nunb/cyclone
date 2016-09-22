;; Sockets library
(define-library (106) ;(srfi 106)
  (include-c-header "<sys/types.h>")
  (include-c-header "<sys/socket.h>")
  (include-c-header "<netdb.h>")
  (import (scheme base))
  (export
      make-client-socket make-server-socket socket?
      socket-accept socket-send socket-recv
      socket-shutdown socket-close
      socket-input-port
      socket-output-port
      call-with-socket
      address-family address-info 
      socket-domain ip-protocol
      message-type shutdown-method
      socket-merge-flags
      socket-purge-flags
      *af-unspec* *af-inet* *af-inet6*
      *sock-stream* *sock-dgram*
      *ai-canonname* *ai-numerichost*
      *ai-v4mapped* *ai-all* *ai-addrconfig*
      *ipproto-ip* *ipproto-tcp* *ipproto-udp*
      *msg-peek* *msg-oob* *msg-waitall*
      *shut-rd* *shut-wr* *shut-rdwr*
  )
  (begin
    (define-syntax make-const
      (er-macro-transformer
        (lambda (expr rename compare)
          (let* ((base-str (symbol->string (cadr expr)))
                 (fsym (string->symbol (string-append "%" base-str "%")))
                 (vsym (string->symbol (string-append "*" base-str "*")))
                 (const-str (caddr expr)))
           `(begin
             (define ,vsym (,fsym))
             (define-c ,fsym
               "(void *data, int argc, closure _, object k)"
               ,(string-append 
                 "return_closcall1(data, k, obj_int2obj(" const-str ")); ")))))))

    (make-const af-unspec      "AF_UNSPEC"     )
    (make-const af-inet        "AF_INET"       )
    (make-const af-inet6       "AF_INET6"      )
    (make-const sock-stream    "SOCK_STREAM"   )
    (make-const sock-dgram     "SOCK_DGRAM"    )
    (make-const ai-canonname   "AI_CANONNAME"  )
    (make-const ai-numerichost "AI_NUMERICHOST")
    (make-const ai-v4mapped    "AI_V4MAPPED"   )
    (make-const ai-all         "AI_ALL"        )
    (make-const ai-addrconfig  "AI_ADDRCONFIG" )
    (make-const msg-peek       "MSG_PEEK"      )
    (make-const msg-oob        "MSG_OOB"       )
    (make-const msg-waitall    "MSG_WAITALL"   )
    (make-const shut-rd        "SHUT_RD"       )
    (make-const shut-wr        "SHUT_WR"       )
    (make-const shut-rdwr      "SHUT_RDWR"     )

    (define *ipproto-ip* 0)
    (define *ipproto-tcp* 6)
    (define *ipproto-udp* 17)
  )
)