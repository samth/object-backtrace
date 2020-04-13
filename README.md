# object-backtrace

Shows what keeps an object alive. Requires Racket CS.

#### Using

```
[samth@homer:~/.../src/build/ChezScheme (master) plt] racketcs
Welcome to Racket v7.6.0.18 [cs].
> (require object-backtrace)
> (object-backtrace map)
'#hasheq((#<procedure:map> . (#<procedure:...-backtrace/main.rkt:16:3>))
         (#<procedure:...-backtrace/main.rkt:16:3> . (#<thread 0>))
         (#<thread 0> . ()))
> (object-referrer map)
'(#<procedure:...-backtrace/main.rkt:7:3>)
```


#### Installing

```
raco pkg install object-backtrace
```
