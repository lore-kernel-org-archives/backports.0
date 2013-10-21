Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:53297 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752764Ab3JUWfH (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 21 Oct 2013 18:35:07 -0400
Message-ID: <5265AC11.6090709@hauke-m.de> (sfid-20131022_003550_755714_CEB414FB)
Date: Tue, 22 Oct 2013 00:34:57 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
CC: "Luis R. Rodriguez" <mcgrof@gmail.com>
Subject: new Backports releases (next-20130822)
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

There are "new" backport release based on the following linux-next version:

next-20130809
next-20130816
next-20130822

These releases can be found here:
https://www.kernel.org/pub/linux/kernel/projects/backports/2013/08/

The source code can be found here:
https://github.com/hauke/backports

This contains the code from the following patch series in addition to
the code from the main backport repository:

[PATCH v4 0/8] backports: add kernel uploader support
[PATCH 0/4] gentree.py: fixes to release upload part
[PATCH 00/11] backports: update to next-20130816
[PATCH 0/8] backports: add next-20130822

Versions based on more recent code will probably come soon, but this is
the last release with the GPU drivers included.

Hauke
