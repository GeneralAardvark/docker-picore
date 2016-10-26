piCore Linux armv7 Docker Image Builder
============================================

## Credit

These build scripts were modified from [tatsushid's docker tinycore](https://github.com/tatsushid/docker-tinycore/tree/master/7.2/x86_64)

## Information

Dockerfile and helper scripts for building a very small CLI system image based
on Tiny Core Linux developed at [The Core Project](http://tinycorelinux.net).
It builds Core 8.0 armv7 image by using following packages which were
converted those archive type from The Core Project packages.

- 8.0v7.tgz: contains base system binaries and a file system layout
- squashfs-tools.tar.gz: contains a squashfs builder and expander

Those original packages are found under http://tinycorelinux.net/8.x/armv7

## How to build the image

Just run

```bash
make
```

To clean up the directory, run

```bash
make clean
```

## License

rootfs64.tar.gz, squashfs-tools.tar.gz and tce-load.patch are under
[GPLv2](http://www.gnu.org/licenses/gpl-2.0.html). The other build scripts are
under [MIT](LICENSE).
