Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:60147 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759692Ab3DJNqT (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 09:46:19 -0400
Message-ID: <1365601575.4235.17.camel@jlt4.sipsolutions.net> (sfid-20130410_154620_579276_BF0B2295)
Subject: Re: [PATCH 17/18] backports: use depmod -a
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 10 Apr 2013 15:46:15 +0200
In-Reply-To: <1365593728-5720-18-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_133719_371217_D28C73CB)
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365593728-5720-18-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130410_133719_371217_D28C73CB)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> Use only depmod -a and at the same time tell the
> user to reboot, we no longer support unloading /
> loading for them given that we backport too many
> modules.

Heh, fine with me.

johannes

