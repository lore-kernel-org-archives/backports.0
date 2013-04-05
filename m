Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:42900 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755664Ab3DEPf3 (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 5 Apr 2013 11:35:29 -0400
Message-ID: <1365176113.8515.33.camel@jlt4.sipsolutions.net> (sfid-20130405_173531_444284_60CAE9EC)
Subject: Re: [PATCH v2 2/5] backports: Add NFC core and drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Thierry Escande <thierry.escande@linux.intel.com>
Cc: backports@vger.kernel.org
Date: Fri, 05 Apr 2013 17:35:13 +0200
In-Reply-To: <1365175014-6028-2-git-send-email-thierry.escande@linux.intel.com> (sfid-20130405_171658_345140_E6DC5D9A)
References: <1365175014-6028-2-git-send-email-thierry.escande@linux.intel.com>
	 (sfid-20130405_171658_345140_E6DC5D9A)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-04-05 at 17:16 +0200, Thierry Escande wrote:

> NFC build is disabled for now.

Why not just put all of this in after patch 3? The system will ignore
patches that can't be applied anyway :)

> +# NFC core needs PF_NFC defined in socket.h which was
> +# only introduced in kernel 3.1
> +NFC 3.1

Just PF_NFC could be defined in compat, no?

johannes

