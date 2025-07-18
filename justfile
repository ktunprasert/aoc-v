alias d := dl
alias dg := dlg
alias g := gen
alias r := run
alias e := example
alias b := bench

_build fn:
    #!/usr/bin/env fish
    if not test -f {{fn}}
      echo "Building {{fn}}.v"
      v {{fn}}.v
    end

_must fn:
    @echo "Building {{fn}}.v"
    v {{fn}}.v

build-dl: (_build 'dl')

dl year day: build-dl
    ./dl -D {{year}} {{day}}

gen year day: build-dl
    ./dl -g {{year}} {{day}}

dlg year day: build-dl
    ./dl -Dg {{year}} {{day}}

build-day year day: (_must year/day)

run year day: (build-day year day)
    ./{{year}}/{{day}} ./{{year}}/{{day}}.txt

example year day *fn: (build-day year day)
    ./{{year}}/{{day}} ./{{year}}/{{if fn != '' { fn } else { day+'e' } }}.txt

bench year day *FLAGS: (build-day year day)
    hyperfine {{FLAGS}} './{{year}}/{{day}} ./{{year}}/{{day}}.txt'
