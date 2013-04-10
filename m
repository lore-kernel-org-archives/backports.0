Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:32893 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3DJUEA (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 16:04:00 -0400
Message-ID: <1365624228.4235.43.camel@jlt4.sipsolutions.net> (sfid-20130410_220402_954550_8C8E67C0)
Subject: Re: [PATCH v2 13/18] backports: add blacklist module support
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 10 Apr 2013 22:03:48 +0200
In-Reply-To: <1365624026-13027-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130410_220034_063515_A06FBA4D)
References: <1365624026-13027-1-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130410_220034_063515_A06FBA4D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-04-10 at 13:00 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> This lets us provide a simple map of new drivers and old
> drivers that it replaces at install time. This generates
> a blacklist via the file:

Applied and pushed, thanks! :)

johannes

