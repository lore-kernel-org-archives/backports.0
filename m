Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:60145 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759688Ab3DJNpy (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 09:45:54 -0400
Message-ID: <1365601550.4235.16.camel@jlt4.sipsolutions.net> (sfid-20130410_154558_442733_631DB281)
Subject: Re: [PATCH 16/18] backports: add udev rules if required for
 backported firmware_class
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 10 Apr 2013 15:45:50 +0200
In-Reply-To: <1365593728-5720-17-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133654_279802_E5324896)
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365593728-5720-17-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130410_133654_279802_E5324896)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:

> +err "Cannot find  firmware file '$FIRMWARE'"

nitpick: need only one space :)

Other than that this looks like voodoo to me, so I guess it's good :)

johannes

