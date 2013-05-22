Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:51919 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab3EVLet (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 07:34:49 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf10so678759pab.10
        for <backports@vger.kernel.org>; Wed, 22 May 2013 04:34:49 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/9] backports: add kernel uploading support
Date: Wed, 22 May 2013 04:34:29 -0700
Message-Id: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133451_974564_1E68E880)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

There were a few scripts left to convert to Python. One
was git-paranoia and another was gen-release.sh. This
converts both into the new framework under Python. The
new option is --kup, this would only be used by whoever
is maintaining releases for backports.

The Python gpg library didn't have support for
"--armor --detach-sign" so for now we just add
our own. For kup we add our own small wrapper.

A few thing we could do to help new maintainers or
later enhancements but we can do that later:

  * Add option to import PGP keys from the trees
    we manage or are reading data from.

  * Add option to build tarball for non kup usage

We should just go hack up git paranoia upstream on
git itself as well.

Luis R. Rodriguez (9):
  lib/bpgit.py: make git describe --long optional
  lib/bpgit.py: add git describe --dirty support
  lib/bpgit.py: add git status support
  lib/bpgit.py: add git clean support
  lib/bpgit.py: add git tree verification support
  lib/bpgit.py: add support for git paranoia
  lib/bpgpg.py: add simple gpg helpers for --armor --detach-sign
  lib/bpkup.py: add or own kernel uploader helper lib
  gentree.py: add kernel upload support

 gentree.py   |  211 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 lib/bpgit.py |   56 +++++++++++++++-
 lib/bpgpg.py |   12 ++++
 lib/bpkup.py |   38 +++++++++++
 4 files changed, 309 insertions(+), 8 deletions(-)
 create mode 100644 lib/bpgpg.py
 create mode 100644 lib/bpkup.py

-- 
1.7.10.4

