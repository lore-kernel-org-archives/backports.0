Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:45665 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbaBJM0p (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 10 Feb 2014 07:26:45 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.82)
	(envelope-from <johannes@sipsolutions.net>)
	id 1WCpwi-0008D1-Ie
	for backports@vger.kernel.org; Mon, 10 Feb 2014 13:26:44 +0100
Message-ID: <1392035201.4128.18.camel@jlt4.sipsolutions.net> (sfid-20140210_132706_233022_BF835C00)
Subject: Re: [PATCH 2/2] backports: conditionally access net/ieee802154/
 with make
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Mon, 10 Feb 2014 13:26:41 +0100
In-Reply-To: <1392035146-12349-2-git-send-email-johannes@sipsolutions.net> (sfid-20140210_132552_737547_CBDBDAF2)
References: <1392035146-12349-1-git-send-email-johannes@sipsolutions.net>
	 <1392035146-12349-2-git-send-email-johannes@sipsolutions.net>
	 (sfid-20140210_132552_737547_CBDBDAF2)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2014-02-10 at 13:25 +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This essentially reverts commit cb6f08d3c38c as that caused
> issues with copy-list - the scripting when generating the
> backport can't prove that net/ieee802154/ isn't needed and
> will try to go into it even if it wasn't copied.
> 
> Instead, make net/ieee802154/ be entered whenever it might
> be needed - which is for CPTCFG_IEEE802154 and CPTCFG_BT.
> This is harmless if the directory ends up listed twice but
> will cause this problem to disappear.

Err, forgot to git commit correctly ...

