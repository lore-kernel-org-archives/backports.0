Return-path: <backports-owner@vger.kernel.org>
Received: from mail-eopbgr690136.outbound.protection.outlook.com ([40.107.69.136]:7552
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387458AbeGKWPZ (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 11 Jul 2018 18:15:25 -0400
From: "Shu, Nick" <Nick.Shu@spirent.com>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: ath10k driver backport on Linux-4.9
Date: Wed, 11 Jul 2018 22:08:57 +0000
Message-ID: <DM5PR1001MB2106BC41E3DF6D5CA5376B189D5A0@DM5PR1001MB2106.namprd10.prod.outlook.com> (sfid-20180712_000903_604673_DBFFFC37)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,
I need a urgent help.
Before, I can find ath10k driver backport for each kernel from this link:

http://drvbp1.linux-foundation.org/~mcgrof/rel-html/backports/

But it stopped support after Linux 4.2.

Then I followed this instruction to build my own backport driver:

https://wireless.wiki.kernel.org/en/users/drivers/ath10k/backports

I used to be able to build my own backport driver with 4.8 kernel.
But from time to time when I clone Backport tree, I got different structure=
 and it doesn't match the instruction anymore.

I have a 4.9 kernel driver that needs to be backported into my 4.8 kernel.
Can you provide some support on it?
Or where I can get ath10k 4.8 backport release?

Thanks a lot!
Nick shu







Spirent Communications e-mail confidentiality.
------------------------------------------------------------------------
This e-mail contains confidential and / or privileged information belonging=
 to Spirent Communications plc, its affiliates and / or subsidiaries. If yo=
u are not the intended recipient, you are hereby notified that any disclosu=
re, copying, distribution and / or the taking of any action based upon reli=
ance on the contents of this transmission is strictly forbidden. If you hav=
e received this message in error please notify the sender by return e-mail =
and delete it from your system.

Spirent Communications plc
Northwood Park, Gatwick Road, Crawley, West Sussex, RH10 9XN, United Kingdo=
m.
Tel No. +44 (0) 1293 767676
Fax No. +44 (0) 1293 767677

Registered in England Number 470893
Registered at Northwood Park, Gatwick Road, Crawley, West Sussex, RH10 9XN,=
 United Kingdom.

Or if within the US,

Spirent Communications,
27349 Agoura Road, Calabasas, CA, 91301, USA.
Tel No. 1-818-676- 2300
--
To unsubscribe from this list: send the line "unsubscribe backports" in
