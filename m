Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:62590 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755912Ab3EGDDa (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 6 May 2013 23:03:30 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so69626pdj.24
        for <backports@vger.kernel.org>; Mon, 06 May 2013 20:03:30 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: johannes@sipsolutions.net
Cc: backports@vger.kernel.org, techtonik@gmail.com,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/3] backports: keep headers on patch refresh
Date: Mon,  6 May 2013 20:03:17 -0700
Message-Id: <1367895800-14305-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130507_050334_102477_409139F3)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This changeset updates the backports project to enable keeping
headers around upon patch refresh. We now use a Python library
for managing patches, update that library to the the latest
from svn trunk, make a small change to it and then modify our
gentree.py to take advantage of it.

Anatoly, feel free to incorporate the patch.py change to your
respective upstream if you see it fit.

Luis R. Rodriguez (3):
  backports: update patch Python library
  lib/patch.py: add top header parsing support
  gentree.py: keep patch headers for patch refresh

 gentree.py   |    4 +++-
 lib/patch.py |   45 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 39 insertions(+), 10 deletions(-)

-- 
1.7.10.4

