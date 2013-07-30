Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:47295 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab3G3KaH (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 30 Jul 2013 06:30:07 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so6534157pdi.2
        for <backports@vger.kernel.org>; Tue, 30 Jul 2013 03:30:06 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [PATCH 0/2] rel-html: update projet list.
Date: Tue, 30 Jul 2013 03:29:59 -0700
Message-Id: <1375180201-5274-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130730_123010_850699_42AA6150)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

This updates rel-html's project release list.
The compat-drivers releases, the releaes used prior
to the rename to backports, are now fully deprecated
and no longer supported.

Luis R. Rodriguez (2):
  rel-html: update linux and backports project releases
  backports: eol the same Linux releases

 projects/backports.cfg |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
1.7.10.4

