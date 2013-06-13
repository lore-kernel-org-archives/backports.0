Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:63428 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757760Ab3FMUrh (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 13 Jun 2013 16:47:37 -0400
Received: by mail-lb0-f182.google.com with SMTP id r11so9221934lbv.27
        for <backports@vger.kernel.org>; Thu, 13 Jun 2013 13:47:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51BA2CC7.7090701@broadcom.com>
References: <1370806659-2875-1-git-send-email-arend@broadcom.com>
 <CAB=NE6WOs9+rVAAu0g_19BeXWnJsT2SRNZ6FdTZxAvT7JU5eEw@mail.gmail.com>
 <51BA24D8.4090805@broadcom.com> <51BA25FD.4000704@broadcom.com>
 <1371154140.8335.15.camel@jlt4.sipsolutions.net> <51BA2CC7.7090701@broadcom.com>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Thu, 13 Jun 2013 13:47:15 -0700
Message-ID: <CAB=NE6XnYCHrNDoQGB8S+pZWqw-7qA3xyyY7yyQxcUy3GbjPUA@mail.gmail.com> (sfid-20130613_224741_005986_096BAA53)
Subject: Re: [PATCH] compat-drivers: do not disable bcma when selecting brcmsmac
To: Arend van Spriel <arend@broadcom.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Jun 13, 2013 at 1:34 PM, Arend van Spriel <arend@broadcom.com> wrote:
>
> Got it. Like the use of menuconfig. Just might come up with a defconfig for
> the brcm80211 drivers.

Its already there, the same upstream Kconfig files are used.

  Luis
