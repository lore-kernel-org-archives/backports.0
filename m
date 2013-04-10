Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:60101 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935833Ab3DJNke (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 09:40:34 -0400
Message-ID: <1365601223.4235.13.camel@jlt4.sipsolutions.net> (sfid-20130410_154044_872232_72BBC4FA)
Subject: Re: [PATCH 14/18] backports: add support for module compression
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 10 Apr 2013 15:40:23 +0200
In-Reply-To: <1365593728-5720-15-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133659_917460_4A29DF72)
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365593728-5720-15-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130410_133659_917460_4A29DF72)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:

> +++ b/backport/scripts/are_mods_compressed
> @@ -0,0 +1,8 @@
> +#!/bin/bash
> +MODULE=$(./scripts/mod_path mac80211)
> +MODULE=${MODULE##*/}
> +if [ "$MODULE" = "mac80211.ko.gz" ]; then
> +	COMPRESSION_FOUND="y"

That variable seems useless?

Also is there much value in splitting this across two scripts? Seems a
bit small to do that?

johannes

