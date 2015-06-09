Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35167 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbbFIWQS (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 9 Jun 2015 18:16:18 -0400
Received: by iesa3 with SMTP id a3so22770345ies.2
        for <backports@vger.kernel.org>; Tue, 09 Jun 2015 15:16:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1433330756-22733-1-git-send-email-sassmann@kpanic.de>
References: <1433330756-22733-1-git-send-email-sassmann@kpanic.de>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 9 Jun 2015 15:15:56 -0700
Message-ID: <CAB=NE6WXJZGTWE-jUW-tNk-T=zhNdYLnMSVJaPMLwJJsxmEuTA@mail.gmail.com> (sfid-20150610_001620_880359_3AA91632)
Subject: Re: [PATCH 0/4] backports: more generic ethernet patches
To: Stefan Assmann <sassmann@kpanic.de>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Jun 3, 2015 at 4:25 AM, Stefan Assmann <sassmann@kpanic.de> wrote:
> Stefan Assmann (4):
>   backports: replace igb skb->no_fcs patch with semantic patch
>   backports: replace igb ethtool_cmd_mdix patch with semantic patch
>   backports: replace igb xmit_more patch with semantic patch
>   backports: replace igb pfmemalloc patch with semantic patch

Thanks Stefan! Applied and pushed!

 Luis
