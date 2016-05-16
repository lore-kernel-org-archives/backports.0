Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:48794 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754474AbcEPT2D (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 16 May 2016 15:28:03 -0400
Message-ID: <1463426878.2179.5.camel@sipsolutions.net> (sfid-20160516_212805_920941_4BEC43A2)
Subject: Re: [PATCH] backports: genetlink: add define for GENL_UNS_ADMIN_PERM
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: backports@vger.kernel.org
Date: Mon, 16 May 2016 21:27:58 +0200
In-Reply-To: <1463303597-32397-1-git-send-email-arend@broadcom.com> (sfid-20160515_111325_348941_B121C38D)
References: <1463303597-32397-1-git-send-email-arend@broadcom.com>
	 (sfid-20160515_111325_348941_B121C38D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2016-05-15 at 11:13 +0200, Arend van Spriel wrote:
> Since commit 5ed071ec9992 ("nl80211: Allow privileged operations
> from user namespaces") the definition GENL_UNS_ADMIN_PERM is used
> by nl80211.c. Add definition if not defined by target kernel.

NACK, this patch is really bad and breaks all security properties since
older kernels will not know anything about the flag 0x10, they will
assume that no permission checks are required.

The only sane thing to do is to
#define GENL_UNS_ADMIN_PERM GENL_ADMIN_PERM

and not get the user-namespace-awareness on kernels that didn't know
about the flag already.

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
