Return-path: <backports-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.3]:57007 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192AbaDKGPO (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 11 Apr 2014 02:15:14 -0400
Message-ID: <5347886F.8070307@users.sourceforge.net> (sfid-20140411_081537_194367_B754D06D)
Date: Fri, 11 Apr 2014 08:15:11 +0200
From: SF Markus Elfring <elfring@users.sourceforge.net>
MIME-Version: 1.0
To: Julia Lawall <julia.lawall@lip6.fr>
CC: "Luis R. Rodriguez" <mcgrof@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, backports@vger.kernel.org,
	cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: add pycocci wrapper for multithreaded
 support
References: <1397152097-315-1-git-send-email-mcgrof@do-not-panic.com> <1397152289.4757.28.camel@jlt4.sipsolutions.net> <20140410175748.GK14815@wotan.suse.de> <534783DB.4080200@users.sourceforge.net> <alpine.DEB.2.02.1404110800120.2032@localhost6.localdomain6>
In-Reply-To: <alpine.DEB.2.02.1404110800120.2032@localhost6.localdomain6>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

>> Could you find out during the data processing which parts or files
>> result in a special application behaviour you would like to point out here?
> I don't understand the question at all, but since the various files have 
> different properties, it is hard to determine automatically in advance how 
> much work Coccinelle will need to do on each one.

It was reported that a system utilisation did not fit to some
expectations. I am curious if any more details or patterns can be
determined for an observed situation.

Do the involved files need also another look?
- semantic patches
- source directories

Regards,
Markus
