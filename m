Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:35599 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbbETI1t (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 20 May 2015 04:27:49 -0400
Message-ID: <1432110463.2174.2.camel@sipsolutions.net> (sfid-20150520_102751_696775_F518E947)
Subject: Re: [PATCH] backport: allow compilation with Ubuntu's 3.13
From: Johannes Berg <johannes@sipsolutions.net>
To: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: backports@vger.kernel.org
Date: Wed, 20 May 2015 10:27:43 +0200
In-Reply-To: <1432042936-23733-1-git-send-email-emmanuel.grumbach@intel.com> (sfid-20150519_154230_230935_983C6CAB)
References: <1432042936-23733-1-git-send-email-emmanuel.grumbach@intel.com>
	 (sfid-20150519_154230_230935_983C6CAB)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2015-05-19 at 16:42 +0300, Emmanuel Grumbach wrote:

> +#if (LINUX_VERSION_CODE == KERNEL_VERSION(3,13,11) && UTS_UBUNTU_RELEASE_ABI < 24)

Now that I look at this again, I'm confused - shouldn't this whole thing
have a ! in front?

johannes

