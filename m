Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:43245 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162213Ab3DERtC (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 5 Apr 2013 13:49:02 -0400
Message-ID: <1365184133.8515.34.camel@jlt4.sipsolutions.net> (sfid-20130405_194905_060922_AE3A5DF6)
Subject: Re: [PATCH v2 2/5] backports: Add NFC core and drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Thierry Escande <thierry.escande@linux.intel.com>
Cc: backports@vger.kernel.org
Date: Fri, 05 Apr 2013 19:48:53 +0200
In-Reply-To: <515F0801.7020507@linux.intel.com>
References: <1365175014-6028-2-git-send-email-thierry.escande@linux.intel.com>
	  (sfid-20130405_171658_345140_E6DC5D9A) <1365176113.8515.33.camel@jlt4.sipsolutions.net>
	 <515F0801.7020507@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-04-05 at 19:21 +0200, Thierry Escande wrote:
> On 04/05/2013 05:35 PM, Johannes Berg wrote:
> >> +# NFC core needs PF_NFC defined in socket.h which was
> >> +# only introduced in kernel 3.1
> >> +NFC 3.1
> > 
> > Just PF_NFC could be defined in compat, no?
> 
> That's right for compilation but sock_register for PF_NFC will fail and the module won't load.

Ok.

johannes

