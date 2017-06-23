Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ot0-f175.google.com ([74.125.82.175]:35922 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754089AbdFWFje (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 23 Jun 2017 01:39:34 -0400
Received: by mail-ot0-f175.google.com with SMTP id 95so25068493ott.3
        for <backports@vger.kernel.org>; Thu, 22 Jun 2017 22:39:33 -0700 (PDT)
MIME-Version: 1.0
From: Heena Sirwani <heenasirwani@gmail.com>
Date: Fri, 23 Jun 2017 11:09:32 +0530
Message-ID: <CAFEh7=n0RMxU7YgzszG6ybz7sdmCrnjzA2ZpAvOUoW0dD2xa2w@mail.gmail.com> (sfid-20170623_073939_394520_9FC0CBCD)
Subject: Authentication issues with mwifiex using backports 4.2.6.1
To: backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi all,

I am using backports 4.2.6.1 for target kernel 3.2.26 and use the
mwifiex drivers from there. Has anybody had problems with
authentication while connecting to the access point using mwifiex? I
specifically get errors while associating, something like
"auth_failures=11 duration=121 reason=WRONG_KEY" when I know the key
is correct because the same key works with other wifi drivers like
pcie8xxx, mlan.
Reason code I usually get vary between 2,3 and 15.
If this is not the right place to ask, please let me know.

Thanks,
Heena
--
To unsubscribe from this list: send the line "unsubscribe backports" in
