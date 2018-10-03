# Fano Web Framework

Pascal web application framework

## Requirement

- FreePascal >= 3.0
- Web Server (Apache, nginx)

## Installation

### Build
Copy `build.cfg.sample` to `build.cfg`. Make adjustment as you need and run `build.sh` shell script.

    $ cp build.cfg.sample build.cfg
    $ ./build.sh

By default, it will output binary executable in `public` directory.

### Setup virtual host

Setup a virtual host. Please consult documentation of web server you use.
