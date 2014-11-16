Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:37271 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755409AbaKPQsH (ORCPT <rfc822;backports@vger.kernel.org>);
	Sun, 16 Nov 2014 11:48:07 -0500
Message-ID: <5468D545.1040807@hauke-m.de> (sfid-20141116_174809_325406_3417FA33)
Date: Sun, 16 Nov 2014 17:48:05 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Sven Eckelmann <sven@narfation.org>, backports@vger.kernel.org
Subject: Re: [PATCH-resend] backports: Fix double fetch in hlist_for_each_entry*_rcu
References: <1416078459-29315-1-git-send-email-sven@narfation.org>
In-Reply-To: <1416078459-29315-1-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 11/15/2014 08:07 PM, Sven Eckelmann wrote:
> The backported (<3.9) version of hlist_for_each_entry_rcu and
> hlist_for_each_entry_safe uses the new macro hlist_entry_safe. It is called
> with an ACCESS_ONCE parameter for the first parameter ptr. This disallows
> merging of the two loads which the current version of the macro uses.
> 
> This is problematic because this macro must only generate one load. Otherwise
> with two contexts (or CPUs) following could happen:
> 
> 1. context 1 fetches the ptr to the last entry in hlist_entry_safe() and
>    accepts this non-NULL ptr
> 
> 2. context 2 deletes the last entry and terminates the list with NULL
> 
> 3. context 1 re-fetches the pointer, doesn't check for zero, calculates the
>    entry based on a NULL pointer
> 
> 4. context 1 crashes because it tries to load/write data from/to the invalid
>    address
> 
> Instead use a single load to a temporary variable and do the NULL-check and
> calculation based on that one. This is also the approach used in the current
> Linux versions and was introduced by Paul E. McKenney.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  backport/backport-include/linux/list.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
Thank you for your patch, it was pushed upstream.

Hauke
