Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:53230 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab3JUW1p (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Oct 2013 18:27:45 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: mcgrof@gmail.com
Cc: backports@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 0/4] gentree.py: fixes to release upload part
Date: Tue, 22 Oct 2013 00:27:33 +0200
Message-Id: <1382394457-25147-1-git-send-email-hauke@hauke-m.de> (sfid-20131022_002747_813443_28E7E8CA)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These are some small fixes on top of Luis patch series which are fixing 
minor problems in the release upload part.

Hauke Mehrtens (4):
  gentree.py: do not add full path into tar
  gentree.py: fix directory creating
  gentree.py: log kup command before executing
  gentree.py: add ending slash to upload path

 gentree.py |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

-- 
1.7.10.4

