Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:43677 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932080AbdKQCfI (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 16 Nov 2017 21:35:08 -0500
Received: by mail-wr0-f172.google.com with SMTP id u40so843501wrf.10
        for <backports@vger.kernel.org>; Thu, 16 Nov 2017 18:35:07 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?5ZCz6YeN5q+F?= <uranus0206@gmail.com>
Date: Fri, 17 Nov 2017 10:34:45 +0800
Message-ID: <CAN+BLYEzwNK40ZyCFaXr_9bq6qnTZ8Zvu8D7hTMnNFaVSUAYxw@mail.gmail.com> (sfid-20171117_033509_930299_8130882C)
Subject: Still cannot get IP from AP mode with git version 3d9856
To: backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi, I have ath10k built from backport (git version 3d9856) with
linux-stable 4.13 branch.

And i backport to my PC which kernel is 4.2.8.

I can make my module as AP mode and i bridge it with wired network,
but when i cannot get IP when i try to connect to it.

I have tested several git version of backport. And i found the latest
version i can successful connect to wifi is c6db471.

Is there some issue with netlink?

If i am wrong please correct me. Best regards.

-- 
Wu Chung-I
--
To unsubscribe from this list: send the line "unsubscribe backports" in
