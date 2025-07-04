build-dl:
    #!/usr/bin/env fish
    if not test -f dl
      echo "Building dl.v file"
      v -o dl ./dl.v
    end

dl YEAR DAY: build-dl
    ./dl {{YEAR}} {{DAY}}
