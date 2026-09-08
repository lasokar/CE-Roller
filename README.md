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

## Download

You can download the pre-built version of the game [here](https://github.com/lasokar/CE-Roller/raw/refs/heads/main/bin/CROLLER.8xp). It has the same set of 49 levels as the JS version. I will not be providing instructions on how to Jailbreak a calculator in order to run this, there are plenty of tutorials out there.
