Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:46206 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756346Ab3EWDQK (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 23:16:10 -0400
Received: by mail-pd0-f172.google.com with SMTP id 10so2384483pdi.31
        for <backports@vger.kernel.org>; Wed, 22 May 2013 20:16:09 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v3 0/8] backports: add kernel uploading support
Date: Wed, 22 May 2013 20:15:48 -0700
Message-Id: <1369278956-17550-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130523_051612_119381_FA045ECC)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

On this series I address Johannes' feedback, clean things
up a bit more, and add the --kup-test argument on the last
patch.

Luis R. Rodriguez (8):
  lib/bpgit.py: enable extra arguments on git describe
  lib/bpgit.py: add git status support
  lib/bpgit.py: add git clean support
  lib/bpgit.py: add git tree verification support
  lib/bpgit.py: add support for git paranoia
  lib/bpgpg.py: add simple gpg helper for gpg signing
  lib/bpkup.py: add or own kernel uploader helper lib
  gentree.py: add kernel upload support

 gentree.py   |  237 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 lib/bpgit.py |   93 ++++++++++++++++++++++-
 lib/bpgpg.py |   22 ++++++
 lib/bpkup.py |   44 +++++++++++
 4 files changed, 388 insertions(+), 8 deletions(-)
 create mode 100644 lib/bpgpg.py
 create mode 100644 lib/bpkup.py

-- 
1.7.10.4

