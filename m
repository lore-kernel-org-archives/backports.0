Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34765 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbbFFAMT (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 5 Jun 2015 20:12:19 -0400
Received: by qkoo18 with SMTP id o18so48692326qko.1
        for <backports@vger.kernel.org>; Fri, 05 Jun 2015 17:12:18 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: cocci@systeme.lip6.fr, "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: [PATCH 0/4] backports: SmPL patch equivalence support
Date: Fri,  5 Jun 2015 17:09:57 -0700
Message-Id: <1433549401-17006-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20150606_021221_389025_1333C065)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

A long time ago I wrote SmPL <--> patch equivalence proof support
for backports but put that work on hold as I found it could be
useful as a generic tool. Quite a bit of time has passed and I
haven't gotten to that again so just merge this for now. If we want
to generalize it we can do so later.

This goes with an example patch being transformed.

Luis R. Rodriguez (4):
  patches: remove bt_sock_stream_recvmsg() and bt_sock_recvmsg() from
    ifdefs
  patches: change 0054-struct-proto_ops-sig backport strategy
  gentree.py: add SmPL patch equivalence proof support
  patches: provide 0054-struct-proto_ops-sig SmPL patch replacement

 gentree.py                                         |  71 ++++++-
 .../network/0054-struct-proto_ops-sig.cocci        | 177 +++++++++++++++++
 .../0054-struct-proto_ops-sig/bluetooth.patch      | 212 ---------------------
 .../0054-struct-proto_ops-sig/ieee802154.patch     |  79 --------
 .../network/0054-struct-proto_ops-sig/nfc.patch    |  59 ------
 5 files changed, 240 insertions(+), 358 deletions(-)
 create mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig.cocci
 delete mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/bluetooth.patch
 delete mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/ieee802154.patch
 delete mode 100644 patches/collateral-evolutions/network/0054-struct-proto_ops-sig/nfc.patch

-- 
2.3.2.209.gd67f9d5.dirty

