Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:60093 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080Ab3DJNfJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 09:35:09 -0400
Message-ID: <1365600903.4235.10.camel@jlt4.sipsolutions.net> (sfid-20130410_153511_507576_DB3F3754)
Subject: Re: [PATCH 13/18] backports: add blacklist module support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 10 Apr 2013 15:35:03 +0200
In-Reply-To: <1365593728-5720-14-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133640_558509_CE70F58E)
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365593728-5720-14-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130410_133640_558509_CE70F58E)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:

> --- /dev/null
> +++ b/backport/.blacklist.map
> @@ -0,0 +1,10 @@
> +# Update this map when a driver gets renamed or
> +# symbols from old drivers get moved to a newer
> +# driver. If you have the driver on the right
> +# hand side it will be blacklisted upon installation
> +# only if you actually installed the driver on the
> +# left.
> +
> +# new-driver	old-driver
> +iwlagn		iwlwifi
> +iwlagn		iwl4965

Seems that's really

# old-driver	new-driver

no?

> +rm -f $BLACKLIST_CONF
> +
> +echo "# To be used when using backported drivers" >> $BLACKLIST_CONF

Or you could just use > instead of >> on this first line ;-)

> +for i in $(grep -v ^# $BLACKLIST_MAP | cut -f 2); do

What happens if the blacklist map contains empty lines? Might want to
allow that.

> +	MODULE="${i}.ko"
> +	MODULE_UPDATE="$(grep -v ^# $BLACKLIST_MAP | grep $i | cut -f 1 | head -1).ko"
> +
> +	COUNT=$(find $MODULE_DIR -type f -name ${MODULE} -or -name ${MODULE}.gz | wc -l)
> +	COUNT_REPLACE=$(find $MODULE_UPDATES -type f -name ${MODULE_UPDATE} -or -name ${MODULE_UPDATE}.gz | wc -l)
> +
> +	if [ $COUNT -ne 0 ]; then
> +		if [ $COUNT_REPLACE -ne 0 ]; then
> +			echo "Blacklisting $MODULE ..."
> +			echo blacklist $i >> $BLACKLIST_CONF
> +		fi

So you do mean "# new-driver old-driver", but then shouldn't the iwlwifi
lines be reversed?

johannes

