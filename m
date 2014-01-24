Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36612 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbaAXWr0 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 24 Jan 2014 17:47:26 -0500
Received: by mail-pa0-f42.google.com with SMTP id kl14so3770512pab.15
        for <backports@vger.kernel.org>; Fri, 24 Jan 2014 14:47:26 -0800 (PST)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 00/11] rel-html: synch up to new project requirements
Date: Fri, 24 Jan 2014 14:47:05 -0800
Message-Id: <1390603636-27841-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20140125_000006_531136_DCDADF5C)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

The 3.13 kernel is out, and we are also in 2014, this patch set
addresses the new project requirements, changes, and also improves
parsing / inferences of releases. The json thing still needs to be
done. This also embraces the new shiny DCO.

Luis R. Rodriguez (11):
  rel-html: run autopep8 on rel-html.py
  rel-html: change default file extension to tar.xz
  rel-html: update Linux project file
  rel-html: add 3.14 for backports project release file
  rel-html: use system's date to determine current year
  rel-html: add the 2014 URL backports snapshot releases
  rel-html: revise stable releases prior to display
  rel-html: add copyleft-next URL reference
  rel-html: add 3.14 release to iw project
  rel-html: update CRDA project file
  rel-html: update documentation on contribution process using the DCO

 CONTRIBUTING           |   54 +-
 projects/backports.cfg |    2 +
 projects/crda.cfg      |    5 +-
 projects/iw.cfg        |    1 +
 rel-html.cfg           |    3 +-
 rel-html.py            | 2497 +++++++++++++++++++++++++-----------------------
 6 files changed, 1382 insertions(+), 1180 deletions(-)

-- 
1.8.5.2

