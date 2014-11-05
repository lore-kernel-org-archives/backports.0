Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:60130 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbaKEHyO (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 5 Nov 2014 02:54:14 -0500
Message-ID: <1415174051.2589.6.camel@sipsolutions.net> (sfid-20141105_085416_271782_6218F351)
Subject: Re: [PATCH v2 06/13] backports: update dependencies map file
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, linux-kernel@vger.kernel.org,
	yann.morin.1998@free.fr, mmarek@suse.cz, sassmann@kpanic.de,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Date: Wed, 05 Nov 2014 08:54:11 +0100
In-Reply-To: <1415157517-15442-7-git-send-email-mcgrof@do-not-panic.com> (sfid-20141105_042137_742710_12F2DE3B)
References: <1415157517-15442-1-git-send-email-mcgrof@do-not-panic.com>
	 <1415157517-15442-7-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20141105_042137_742710_12F2DE3B)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2014-11-04 at 19:18 -0800, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> 
> During development of kernel integration support using CONFIG_BACKPORT
> was evaluated as a prefix over CPTCFG even for packaging backports,
> for some reason this change lifted some restrictions one some device
> drivers which was present before and as such requires some changes to
> the dependencies map file to ensure correct compilation for respective
> kernel versions.

This is confusing ... I think what you're trying to say is that you
noticed it because your integration system was broken and not honouring
restrictions properly?

johannes

