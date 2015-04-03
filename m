Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39444 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371AbbDCVi7 (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 17:38:59 -0400
Message-ID: <551F0871.3060403@hauke-m.de> (sfid-20150403_233901_575593_6E30661B)
Date: Fri, 03 Apr 2015 23:38:57 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
CC: backports@vger.kernel.org
Subject: Re: [PATCH V3] backport: add backport for get_net_ns_by_fd()
References: <1422659632-8673-1-git-send-email-arend@broadcom.com>
In-Reply-To: <1422659632-8673-1-git-send-email-arend@broadcom.com>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 01/31/2015 12:13 AM, Arend van Spriel wrote:
> In mac80211-next a call to get_net_ns_by_fd() has been added in cfg80211
> which resides in networking core. This function has been backported
> such that it will always fail, ie. as it would when CONFIG_NET_NS
> is not defined. The call was added by:
> 
>    commit 4b681c82d2f9bef121c912ffcaac89a004af3f2c
>    Author: Vadim Kochan <vadim4j@gmail.com>
>    Date: Mon Jan 12 16:34:05 2015 +0200
> 
>      nl80211: Allow set network namespace by fd
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
> This patch replaces the V2 commit which has
> Message-ID: <1422651176-5433-1-git-send-email-arend@broadcom.com>
> 
> Changes:
>  V2
>   - solve backport using LINUX_BACKPORT macro (Johannes Berg)
>  V3
>   - make backport conditional for kernel before 3.20 (Hauke Mehrtens)
> ---
>  backport/backport-include/net/net_namespace.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
Thank you for the patch it was applied to backports.

Hauke

