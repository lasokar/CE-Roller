# Cyber Roller TI-84 port

This project ports my Cyber Roller JS version to the **TI-84 Plus CE / TI-83 Premium CE**. Idk why I made this but I did. Microwave port coming soon™

## Building

Install the **CE C/C++ Toolchain v15.0 or newer**, make sure `cedev-config` is on `PATH`, then run:

```sh
make clean
make
```

or:

```sh
./build.sh
```

Expected output:

```text
bin/CROLLER.8xp
```