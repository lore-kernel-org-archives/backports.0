Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38562 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdGMDHH (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 12 Jul 2017 23:07:07 -0400
Received: by mail-wm0-f43.google.com with SMTP id f67so11720831wmh.1
        for <backports@vger.kernel.org>; Wed, 12 Jul 2017 20:07:06 -0700 (PDT)
MIME-Version: 1.0
From: AceLan Kao <acelan.kao@canonical.com>
Date: Thu, 13 Jul 2017 11:07:05 +0800
Message-ID: <CAFv23QnvFGj3b2GCV=v=mGk8JgGwZRe+W-+m9gxbtAsChySz=Q@mail.gmail.com> (sfid-20170713_050709_241835_25AC9962)
Subject: Adding the BT driver
To: Johannes Berg <johannes.berg@intel.com>, hauke@hauke-m.de,
        mcgrof@kernel.org
Cc: backports@vger.kernel.org,
        Anthony Wong <anthony.wong@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi all,

I'm working on adding BT driver back to linux backport driver, and got
some questions.
1. Do we still do building the backport driver against all the
supported kernels? I didn't see those reports in git log recently, so
I'm wondering while backporting BT driver, can I skip some old
kernels' support.
2. Is there a script that can help me to build the backport driver
against certain kernels?
3. Is there anything I should take care of while doing the BT backport?
Thanks.

Best regards,
AceLan Kao.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
