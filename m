Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52198 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab3JUJIi (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 21 Oct 2013 05:08:38 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn9so3616344wib.11
        for <backports@vger.kernel.org>; Mon, 21 Oct 2013 02:08:37 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: hauke@hauke-m.de
Cc: backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH v4 0/8] backports: add kernel uploader support
Date: Mon, 21 Oct 2013 11:08:24 +0200
Message-Id: <1382346512-18694-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20131021_110849_400251_C4EB3F96)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a simple respin of some old patches I had for adding
kernel uploading support into our scripts. I had agreed to
split this up but in the end just never got to it. Might as
well merge it and evolve it.

Luis R. Rodriguez (8):
  lib/bpgit.py: enable extra arguments on git describe
  lib/bpgit.py: add git status support
  lib/bpgit.py: add git clean support
  lib/bpgit.py: add git tree verification support
  lib/bpgit.py: add support for git paranoia
  lib/bpgpg.py: add simple gpg helper for gpg signing
  lib/bpkup.py: add or own kernel uploader helper lib
  gentree.py: add kernel upload support

 gentree.py   | 237 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 lib/bpgit.py |  93 ++++++++++++++++++++++-
 lib/bpgpg.py |  22 ++++++
 lib/bpkup.py |  44 +++++++++++
 4 files changed, 388 insertions(+), 8 deletions(-)
 create mode 100644 lib/bpgpg.py
 create mode 100644 lib/bpkup.py

-- 
1.8.4.rc3

