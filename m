Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:47230 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbaBJWua (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 10 Feb 2014 17:50:30 -0500
Message-ID: <52F957B1.6090908@hauke-m.de> (sfid-20140210_235032_573677_644257FD)
Date: Mon, 10 Feb 2014 23:50:25 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
Subject: Re: [PATCH 1/2] backports: make BACKPORT_BUILD_LEDS depend on LEDS_CLASS=n
References: <1392035146-12349-1-git-send-email-johannes@sipsolutions.net>
In-Reply-To: <1392035146-12349-1-git-send-email-johannes@sipsolutions.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 02/10/2014 01:25 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Somehow !LEDS_CLASS and LEDS_CLASS=n seem to be different (likely
> because LEDS_CLASS is tristate, but BACKPORT_BUILD_LEDS is just a
> bool), so use LEDS_CLASS=n to fix build issues in other cases on
> certain kernel configurations.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  backport/compat/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thank you for the patches, They were applied and I tested them.

Hauke
