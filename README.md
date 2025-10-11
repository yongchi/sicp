# Setup for macOS

## Install gauche.

```bash
$ brew install gauche
```

## Install Gauche-compat-sicp.

```bash
$ git clone git@github.com:shirok/Gauche-compat-sicp.git
$ cd Gauche-compat-sicp
$ ./configure
$ make install
```

(if needed) Install rlwrap.

```bash
$ brew install rlwrap
```

# Run sample code

## Gauche script

```bash
$ gosh sample.scm
```

## gosh prompt

```bash
$ rlwrap gosh

gosh> (use compat.sicp)
gosh> print true
```
