Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:36284 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222Ab3LGXFb (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 7 Dec 2013 18:05:31 -0500
Message-ID: <52A3A9B1.1080903@hauke-m.de> (sfid-20131208_000534_144157_15ECB527)
Date: Sun, 08 Dec 2013 00:05:21 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org
Subject: Re: [PATCH v2] backports: add Python based get-backport-kernels
References: <1386332707-9736-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1386332707-9736-1-git-send-email-mcgrof@do-not-panic.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/06/2013 01:25 PM, Luis R. Rodriguez wrote:
> This replaces the old shell get-compat-kernels
> with a shiny Python  based  get-backport-kernels.
> The new version provides a few features which were
> simply a difficult to implement and quite frankly
> pointless to try to implement in shell. Things worth
> mentioning:
> 
>   * This will now monitor your old directories
>     and packages and remove any stale old directory
>     or packages. You should feel comfortable with
>     now just getting the latest code from the repo
>     and always just running the script, it will do
>     everything you wished it did for you.
> 
>   * This will always check the URLs and ensure your
>     file size matches the target upstream size, we
>     used to only check if you had the file or not
> 
>   * The compat-ksrc directory was renamed to
>     ksrc-backports which goes inline with our
>     rebranding crusade. The tool is smart enough
>     to figure out if you had the old name and
>     rename it for you. Its also smart enough to
>     figure out if you had your old compat-ksrc
>     as a symlink and preserve things just as you
>     intended following the old real path.
> 
>   * The debs/ directory is now moved into
>     ksrc-backports, making it easier to manage
>     and detect what is or not part of backports.
> 
>   * I found no way to deal with objects to extract
>     GNU archive items with Python, so we're stuck with
>     requiring GNU ar, this provides a simple wrapper
>     for our usage.
> 
> Relying on an continued update list is dumb though,
> in the future we should look into putting out new
> builds through without requiring GNU ar and also
> updating the list through a json file just as the
> kernel has its own now:
> 
> 	https://www.kernel.org/releases.json
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> ---
> 
> This v2 also contains a 1 line required change to ckmake.
> 
>  devel/ckmake               |   2 +-
>  devel/get-backport-kernels | 523 +++++++++++++++++++++++++++++++++++++++++++++
>  devel/get-compat-kernels   | 268 -----------------------
>  lib/bpar.py                |  17 ++

I just tried this on the compat server, but I am getting some errors:

./devel/get-backport-kernels
......
3.5.7 - installing usr/src/ generic solution ...
3.8.13 - installing usr/src/  ...
3.8.13 - rebuilding binary dependencies ...
  CLEAN   scripts/basic
  HOSTCC  scripts/basic/fixdep
  Building modules, stage 2.
  MODPOST 0 modules
  CLEAN   scripts/mod
  CHECK   scripts/mod/empty.c
/bin/sh: 1: sparse: not found
make[1]: *** [scripts/mod/empty.o] Error 127
make[1]: *** Waiting for unfinished jobs....
  HOSTCC  scripts/mod/mk_elfconfig
make: *** [_module_scripts/mod] Error 2
  CLEAN   scripts/genksyms
  HOSTCC  scripts/genksyms/genksyms.o
  SHIPPED scripts/genksyms/lex.lex.c
  SHIPPED scripts/genksyms/keywords.hash.c
  SHIPPED scripts/genksyms/parse.tab.h
  SHIPPED scripts/genksyms/parse.tab.c
  HOSTCC  scripts/genksyms/lex.lex.o
  HOSTCC  scripts/genksyms/parse.tab.o
  HOSTLD  scripts/genksyms/genksyms
  Building modules, stage 2.
  MODPOST 0 modules
/bin/sh: 1: scripts/mod/modpost: not found
make[1]: *** [__modpost] Error 127
make: *** [modules] Error 2
  Building modules, stage 2.
  MODPOST 0 modules
/bin/sh: 1: scripts/mod/modpost: not found
make[1]: *** [__modpost] Error 127
make: *** [modules] Error 2
  CHECK   scripts/mod/empty.c
/bin/sh: 1: sparse: not found
make[1]: *** [scripts/mod/empty.o] Error 127
make: *** [_module_scripts/mod] Error 2
  Building modules, stage 2.
  MODPOST 0 modules
/bin/sh: 1: scripts/mod/modpost: not found
make[1]: *** [__modpost] Error 127
make: *** [modules] Error 2
  Building modules, stage 2.
  MODPOST 0 modules
/bin/sh: 1: scripts/mod/modpost: not found
make[1]: *** [__modpost] Error 127
make: *** [modules] Error 2
  CHECK   scripts/mod/empty.c
/bin/sh: 1: sparse: not found
make[1]: *** [scripts/mod/empty.o] Error 127
make[1]: *** Waiting for unfinished jobs....
make: *** [_module_scripts/mod] Error 2
  Building modules, stage 2.
  MODPOST 0 modules
/bin/sh: 1: scripts/mod/modpost: not found
make[1]: *** [__modpost] Error 127
make: *** [modules] Error 2
  Building modules, stage 2.
  MODPOST 0 modules
/bin/sh: 1: scripts/mod/modpost: not found
make[1]: *** [__modpost] Error 127
make: *** [modules] Error 2
  CHECK   scripts/mod/empty.c
/bin/sh: 1: sparse: not found
make[1]: *** [scripts/mod/empty.o] Error 127
make: *** [_module_scripts/mod] Error 2
  Building modules, stage 2.
  MODPOST 0 modules
/bin/sh: 1: scripts/mod/modpost: not found
make[1]: *** [__modpost] Error 127
make: *** [modules] Error 2
3.5.7 - rebuilding binary dependencies ...
  CLEAN   scripts/basic
  HOSTCC  scripts/basic/fixdep
  Building modules, stage 2.
  MODPOST 0 modules
  CLEAN   scripts/mod
  CHECK   scripts/mod/empty.c
/bin/sh: 1: sparse: not found
  HOSTCC  scripts/mod/mk_elfconfig
make[1]: *** [scripts/mod/empty.o] Error 127
make[1]: *** Waiting for unfinished jobs....
make: *** [_module_scripts/mod] Error 2
  CLEAN   scripts/genksyms
  HOSTCC  scripts/genksyms/genksyms.o
  SHIPPED scripts/genksyms/lex.lex.c
  SHIPPED scripts/genksyms/keywords.hash.c
  SHIPPED scripts/genksyms/parse.tab.h
  SHIPPED scripts/genksyms/parse.tab.c
  HOSTCC  scripts/genksyms/lex.lex.o
  HOSTCC  scripts/genksyms/parse.tab.o
  HOSTLD  scripts/genksyms/genksyms
  Building modules, stage 2.
  MODPOST 0 modules
/bin/sh: 1: scripts/mod/modpost: not found
make[1]: *** [__modpost] Error 127
make: *** [modules] Error 2
  Building modules, stage 2.
  MODPOST 0 modules
/bin/sh: 1: scripts/mod/modpost: not found
make[1]: *** [__modpost] Error 127
make: *** [modules] Error 2
  CHECK   scripts/mod/empty.c
/bin/sh: 1: sparse: not found
make[1]: *** [scripts/mod/empty.o] Error 127
make: *** [_module_scripts/mod] Error 2
  Building modules, stage 2.
  MODPOST 0 modules
/bin/sh: 1: scripts/mod/modpost: not found
make[1]: *** [__modpost] Error 127
make: *** [modules] Error 2
  Building modules, stage 2.
  MODPOST 0 modules
/bin/sh: 1: scripts/mod/modpost: not found
make[1]: *** [__modpost] Error 127
make: *** [modules] Error 2
  CHECK   scripts/mod/empty.c
/bin/sh: 1: sparse: not found
make[1]: *** [scripts/mod/empty.o] Error 127
make: *** [_module_scripts/mod] Error 2
  Building modules, stage 2.
  MODPOST 0 modules
/bin/sh: 1: scripts/mod/modpost: not found
make[1]: *** [__modpost] Error 127
make: *** [modules] Error 2
  Building modules, stage 2.
  MODPOST 0 modules
/bin/sh: 1: scripts/mod/modpost: not found
make[1]: *** [__modpost] Error 127
make: *** [modules] Error 2
  CHECK   scripts/mod/empty.c
/bin/sh: 1: sparse: not found
make[1]: *** [scripts/mod/empty.o] Error 127
make[1]: *** Waiting for unfinished jobs....
make: *** [_module_scripts/mod] Error 2
  Building modules, stage 2.
  MODPOST 0 modules
/bin/sh: 1: scripts/mod/modpost: not found
make[1]: *** [__modpost] Error 127
make: *** [modules] Error 2



