Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:36115 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757461Ab3FMTju (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 13 Jun 2013 15:39:50 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so9490061lab.15
        for <backports@vger.kernel.org>; Thu, 13 Jun 2013 12:39:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370806659-2875-1-git-send-email-arend@broadcom.com>
References: <1370806659-2875-1-git-send-email-arend@broadcom.com>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Thu, 13 Jun 2013 12:39:28 -0700
Message-ID: <CAB=NE6WOs9+rVAAu0g_19BeXWnJsT2SRNZ6FdTZxAvT7JU5eEw@mail.gmail.com> (sfid-20130613_213952_533757_56D64ECE)
Subject: Re: [PATCH] compat-drivers: do not disable bcma when selecting brcmsmac
To: Arend van Spriel <arend@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, Jun 9, 2013 at 12:37 PM, Arend van Spriel <arend@broadcom.com> wrote:
> The brcmsmac driver depends on the bcma bus driver these days. However,
> the driver-select script disabled bcma when selecting brcmsmac (or
> the brcm80211 driver group). This leads to mismatch between kernel
> bcma and backport brcmsmac. For the 3.9 backport this result in:
>
> [10298.323094] brcmsmac: Unknown symbol bcma_pmu_spuravoid_pllupdate (err 0)
>
> as this function was added to bcma.
>
> Signed-off-by: Arend van Spriel <arend@broadcom.com>

Thanks Arend but we're now using a new tree:

git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/backports.git

  Luis
