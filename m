Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:60651 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119Ab3HRW31 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 18 Aug 2013 18:29:27 -0400
Message-ID: <52114ABC.10908@hauke-m.de> (sfid-20130819_002929_599882_9A9A7B1F)
Date: Mon, 19 Aug 2013 00:29:16 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Solomon Peachy <pizza@shaftnet.org>
CC: backports@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Enable cw1200 on >=2.6.34
References: <1376744579-4245-1-git-send-email-pizza@shaftnet.org>
In-Reply-To: <1376744579-4245-1-git-send-email-pizza@shaftnet.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 08/17/2013 03:02 PM, Solomon Peachy wrote:
> This superscedes the earlier patch set I posted when apparently sleep 
> deprived.  It enables the cw1200_wlan_sdio driver to build cleanly on 
>> =2.6.34 kernels, and the cw1200_wlan_spi driver to build cleanly on 
>> =2.6.35 kernels.

Hi Solomon,

I compile tested this and haven't found any problems in cw1200 with this
patches applied.

Hauke
