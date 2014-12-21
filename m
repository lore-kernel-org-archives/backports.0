Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:36380 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425AbaLUM3x (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 21 Dec 2014 07:29:53 -0500
Message-ID: <5496BD3F.5010500@hauke-m.de> (sfid-20141221_132955_347429_4938D64D)
Date: Sun, 21 Dec 2014 13:29:51 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Arend van Spriel <arend@broadcom.com>
CC: backports@vger.kernel.org
Subject: Re: [PATCH 06/14] backport: add debugfs_create_devm_seqfile()
References: <1419111577-22174-1-git-send-email-hauke@hauke-m.de> <1419111577-22174-7-git-send-email-hauke@hauke-m.de> <549684B0.1000308@broadcom.com>
In-Reply-To: <549684B0.1000308@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 12/21/2014 09:28 AM, Arend van Spriel wrote:
> On 12/20/14 22:39, Hauke Mehrtens wrote:
>> This new functions is used by ath9k.
> 
> Are you sure? In the driver-core repo the ath9k patch adding this was
> reverted as I made a stupid mistake with driver data. I have the revised
> patch ready, but it will be for 3.20.

I was using the next-20141201 snapshot and there it was included.
Thanks for the heads up, I will cherry pick your revert commit.
This problem was in the ath9k driver and not in the code in
fs/debugfs/file.c is that right?

> Regards,
> Arend
> 
>> Signed-off-by: Hauke Mehrtens<hauke@hauke-m.de>

