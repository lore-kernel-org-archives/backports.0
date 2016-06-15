Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:44902 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbcFOIjF (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 15 Jun 2016 04:39:05 -0400
Message-ID: <1465979938.2994.5.camel@sipsolutions.net> (sfid-20160615_103910_380384_948D1478)
Subject: Re: [PATCH] backports: netlink: add 64-bit aligned helper functions
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	Luciano Coelho <luciano.coelho@intel.com>
Cc: backports@vger.kernel.org
Date: Wed, 15 Jun 2016 10:38:58 +0200
In-Reply-To: <1463142983-17166-1-git-send-email-arend@broadcom.com> (sfid-20160513_143629_166716_8F835081)
References: <1463142983-17166-1-git-send-email-arend@broadcom.com>
	 (sfid-20160513_143629_166716_8F835081)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


>  backport/compat/backport-4.7.c          | 113
> 
This patch is correct, Luca's is not because he erroneously added it to
backport-4.6.c instead :)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
