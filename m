Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D60C433F5
	for <backports@archiver.kernel.org>; Fri, 13 May 2022 16:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381646AbiEMQFf (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 13 May 2022 12:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381602AbiEMQFd (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 May 2022 12:05:33 -0400
Received: from web.adapt-ip.com (mail.adapt-ip.com [107.194.246.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3836286
        for <backports@vger.kernel.org>; Fri, 13 May 2022 09:05:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id B48836E3A7B;
        Fri, 13 May 2022 16:05:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id dVohxO_PU2aR; Fri, 13 May 2022 16:05:24 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-73-162-155-239.hsd1.ca.comcast.net [73.162.155.239])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 41D126E3A73;
        Fri, 13 May 2022 16:05:24 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 00/15] Resurrect Integration Mode v2
Date:   Fri, 13 May 2022 09:05:08 -0700
Message-Id: <20220513160523.2944694-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Original submission here:

https://lore.kernel.org/all/YfyN2GnfeANyNhaS@bombadil.infradead.org/T/

Changes since v1:

- Include Luis' patches to track kconfig as git subtree[1], since the
  original integration mode submission required updated kconfig anyway.
- Version integration patches per target kernel version supporting
  kernel 4.19 and 5.4
- Fixup skb list patch for builds against 4.19. This was not required by
  the series, but needed for build testing.

Tested generating and building an integrated backports of mac80211 from
Linux 5.15.33 against 4.19 and 5.4.

[1]: https://lore.kernel.org/all/Yf2eRJmG80L9htvo@bombadil.infradead.org/T/

Luis Chamberlain (4):
  backport/kconf: remove our version of kconfig
  Squashed 'backport/kconf/' content from commit 98bda615
  kconfig: fix backport syntax to work with linux-next next-20220204
  Makefile.subtrees: document how to update kconfig

Thomas Pedersen (11):
  backport: define BACKPORT_DIR for Kconfig.integrate
  gentree: update kconfig source var to new kconfig format
  gentree: try to make patch operation idempotent in case of --clean
  gentree: do not prefix Kernel.local symbols
  lib/bpversion: calculate Kconfig.versions for next major version
  backport: expose BP_MODULES in package mode only
  kconfig: fix select conversion for BPAUTO_ symbols in integration mode
  integration-patches: refresh integration patch
  integration-patches: make patches per target kernel version
  integration-patches: support 5.4 target kernel
  patches: fixup skb list patch

 Makefile.subtrees                             |   10 +
 backport/Kconfig.integrate                    |    7 +-
 backport/Kconfig.package                      |   18 +-
 backport/Kconfig.package.hacks                |   10 +
 backport/Kconfig.sources                      |   22 +-
 backport/Makefile.real                        |   32 +-
 backport/compat/Kconfig                       |    9 -
 backport/kconf/.gitignore                     |   15 +-
 backport/kconf/GPL-2.0                        |  359 ++++
 backport/kconf/Kbuild.include                 |   73 +
 backport/kconf/Makefile                       |   69 +-
 backport/kconf/README.kconfig                 |   13 +
 backport/kconf/conf.c                         |  548 ++++--
 backport/kconf/confdata.c                     | 1139 ++++++------
 backport/kconf/expr.c                         |   28 +-
 backport/kconf/expr.h                         |   21 +-
 backport/kconf/internal.h                     |    9 +
 backport/kconf/kconf_id.c                     |    1 -
 backport/kconf/kconfig.Makefile               |   65 +
 backport/kconf/kconfig/.gitignore             |   16 +
 backport/kconf/{zconf.l => lexer.l}           |  288 ++-
 backport/kconf/lkc.h                          |  106 +-
 backport/kconf/lkc_proto.h                    |   37 +-
 backport/kconf/lxdialog/BIG.FAT.WARNING       |    2 +-
 backport/kconf/lxdialog/check-lxdialog.sh     |   93 -
 backport/kconf/lxdialog/checklist.c           |   19 +-
 backport/kconf/lxdialog/dialog.h              |   23 +-
 backport/kconf/lxdialog/inputbox.c            |   22 +-
 backport/kconf/lxdialog/menubox.c             |   25 +-
 backport/kconf/lxdialog/textbox.c             |   17 +-
 backport/kconf/lxdialog/util.c                |   19 +-
 backport/kconf/lxdialog/yesno.c               |   19 +-
 backport/kconf/mconf-cfg.sh                   |   52 +
 backport/kconf/mconf.c                        |  178 +-
 backport/kconf/menu.c                         |  256 +--
 backport/kconf/nconf-cfg.sh                   |   50 +
 backport/kconf/nconf.c                        | 1549 +++++++++++++++++
 backport/kconf/nconf.gui.c                    |  614 +++++++
 backport/kconf/nconf.h                        |   83 +
 backport/kconf/{zconf.y => parser.y}          |  374 ++--
 backport/kconf/preprocess.c                   |  574 ++++++
 backport/kconf/setlocalversion                |  118 ++
 backport/kconf/symbol.c                       |  286 +--
 backport/kconf/update-upstream-kconfig.sh     |   28 +
 backport/kconf/util.c                         |   64 +-
 gentree.py                                    |   65 +-
 .../0001-enable-backports-built-in.patch      |   40 -
 .../0001-enable-backports-built-in.patch      |   36 +
 .../0001-enable-backports-built-in.patch      |   40 +
 lib/bpversion.py                              |   11 +-
 lib/kconfig.py                                |    5 +-
 patches/0097-skb-list/mac80211-rx.patch       |    7 +-
 52 files changed, 5542 insertions(+), 2022 deletions(-)
 create mode 100644 Makefile.subtrees
 create mode 100644 backport/kconf/GPL-2.0
 create mode 100644 backport/kconf/Kbuild.include
 create mode 100644 backport/kconf/README.kconfig
 create mode 100644 backport/kconf/internal.h
 create mode 100644 backport/kconf/kconfig.Makefile
 create mode 100644 backport/kconf/kconfig/.gitignore
 rename backport/kconf/{zconf.l => lexer.l} (55%)
 delete mode 100755 backport/kconf/lxdialog/check-lxdialog.sh
 create mode 100755 backport/kconf/mconf-cfg.sh
 create mode 100755 backport/kconf/nconf-cfg.sh
 create mode 100644 backport/kconf/nconf.c
 create mode 100644 backport/kconf/nconf.gui.c
 create mode 100644 backport/kconf/nconf.h
 rename backport/kconf/{zconf.y => parser.y} (68%)
 create mode 100644 backport/kconf/preprocess.c
 create mode 100755 backport/kconf/setlocalversion
 create mode 100755 backport/kconf/update-upstream-kconfig.sh
 delete mode 100644 integration-patches/0001-enable-backports/0001-enable-backports-built-in.patch
 create mode 100644 integration-patches/4.19/0001-enable-backports/0001-enable-backports-built-in.patch
 create mode 100644 integration-patches/5.4/0001-enable-backports/0001-enable-backports-built-in.patch

-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
