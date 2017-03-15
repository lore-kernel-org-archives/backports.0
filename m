Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34164 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbdCOPGL (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 15 Mar 2017 11:06:11 -0400
Received: by mail-pg0-f49.google.com with SMTP id 141so10413675pgd.1
        for <backports@vger.kernel.org>; Wed, 15 Mar 2017 08:06:10 -0700 (PDT)
MIME-Version: 1.0
From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date: Wed, 15 Mar 2017 12:06:09 -0300
Message-ID: <CAAEAJfDinWQ+GdU7hJR3z79LMu8whduStXUHJqihXW0MmWBLYQ@mail.gmail.com> (sfid-20170315_160654_994503_9D1656D8)
Subject: Errors using linux-4.4.y against kernel target v3.19
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

I have checked out linux-4.4.y branch, and executed this:

  $ python2 gentree.py --integrate ~/repos/linux/next/
~/repos/linux/torvalds/  --clean --gitdebug --git-revision v4.4.53
--verbose

My torvalds dir is reset to v3.19. It seems it goes more or less well,
but it fails at three points:

1) Failed to process SmPL patch
collateral-evolutions/network/0027-genl-const/genl-const.cocci:

Failed to process SmPL patch
collateral-evolutions/network/0027-genl-const/genl-const.cocci
Traceback (most recent call last):
  File "gentree.py", line 1091, in <module>
    ret =3D _main()
  File "gentree.py", line 724, in _main
    logwrite=3Dlogwrite)
  File "gentree.py", line 906, in process
    apply_patches(args, "backport", source_dir, 'patches',
bpid.target_dir, logwrite)
  File "gentree.py", line 605, in apply_patches
    raise Exception('SmPL patch failed')
Exception: SmPL patch failed

Running coccinelle results in this:

[zeta@laptop ~/repos/backports]$ ./devel/pycocci
patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci
~/repos/linux/torvalds/backports/
spatch --sp-file
patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci
--in-place --recursive-includes --relax-include-path --use-coccigrep
--timeout 120 --dir /home/zeta/repos/linux/torvalds/backports/ -max 4
-index 0
spatch --sp-file
patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci
--in-place --recursive-includes --relax-include-path --use-coccigrep
--timeout 120 --dir /home/zeta/repos/linux/torvalds/backports/ -max 4
-index 1
spatch --sp-file
patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci
--in-place --recursive-includes --relax-include-path --use-coccigrep
--timeout 120 --dir /home/zeta/repos/linux/torvalds/backports/ -max 4
-index 2
spatch --sp-file
patches/collateral-evolutions/network/0027-genl-const/genl-const.cocci
--in-place --recursive-includes --relax-include-path --use-coccigrep
--timeout 120 --dir /home/zeta/repos/linux/torvalds/backports/ -max 4
-index 3
Failed to apply changes from genl-const.cocci
Specific log output from change that failed using genl-const.cocci
init_defs_builtins: /usr/lib/coccinelle/standard.h
plus: parse error:
  File "patches/collateral-evolutions/network/0027-genl-const/genl-const.co=
cci",
line 6, column 1, charpos =3D 68
  around =3D '__genl_const',
  whole content =3D +__genl_const struct genl_multicast_group

Full log using genl-const.cocci
init_defs_builtins: /usr/lib/coccinelle/standard.h
plus: parse error:
  File "patches/collateral-evolutions/network/0027-genl-const/genl-const.co=
cci",
line 6, column 1, charpos =3D 68
  around =3D '__genl_const',
  whole content =3D +__genl_const struct genl_multicast_group

2) The Makefile patch doesn't apply, namely:
integration-patches/0001-enable-backports/0001-enable-backports-built-in.pa=
tch.
The resolution was fairly easy.

3) The BACKPORT_BP_MODULES symbol is problematic:

scripts/kconfig/mconf Kconfig
backports//compat/Kconfig:57: symbol 'BACKPORT_BP_MODULES' redefines
option 'modules' already defined by symbol 'MODULES'
make[1]: *** [scripts/kconfig/Makefile:24: menuconfig] Error 1
make: *** [Makefile:543: menuconfig] Error 2

Any ideas on why I get all of these? Is it that v3.19 is not supported
by the 4.4.y branch ?

Thanks!
--=20
Ezequiel Garc=C3=ADa, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe backports" in
