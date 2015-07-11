Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:56140 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbbGKVeR (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 11 Jul 2015 17:34:17 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: backports@vger.kernel.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/3] backports: convert  backports-update-manager to python 3
Date: Sat, 11 Jul 2015 23:34:07 +0200
Message-Id: <1436650450-2696-1-git-send-email-hauke@hauke-m.de> (sfid-20150711_233420_260215_E9BE0149)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Ubuntu now uses the xz algorithm to compress the debian packages and 
our old script was not compatible this that. One step to make it work 
again is to convert it to python 3.

Hauke Mehrtens (3):
  devel: convert backports-update-manager to python3
  devel: add support for deb with xz
  devel: update the test kernel versions

 devel/backports-update-manager | 44 ++++++++++++++++++++++--------------------
 lib/bpar.py                    |  4 ++--
 2 files changed, 25 insertions(+), 23 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe backports" in
