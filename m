Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36185 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204AbcEQJEA (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 17 May 2016 05:04:00 -0400
Received: by mail-pa0-f54.google.com with SMTP id bt5so4657442pac.3
        for <backports@vger.kernel.org>; Tue, 17 May 2016 02:04:00 -0700 (PDT)
Subject: Re: [PATCH] backports: genetlink: add define for GENL_UNS_ADMIN_PERM
To: Johannes Berg <johannes@sipsolutions.net>,
	Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
References: <1463303597-32397-1-git-send-email-arend@broadcom.com>
 <1463426878.2179.5.camel@sipsolutions.net>
Cc: backports@vger.kernel.org
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <573ADE74.3060107@broadcom.com> (sfid-20160517_110410_963552_3F40298E)
Date: Tue, 17 May 2016 11:03:48 +0200
MIME-Version: 1.0
In-Reply-To: <1463426878.2179.5.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 16-5-2016 21:27, Johannes Berg wrote:
> On Sun, 2016-05-15 at 11:13 +0200, Arend van Spriel wrote:
>> Since commit 5ed071ec9992 ("nl80211: Allow privileged operations
>> from user namespaces") the definition GENL_UNS_ADMIN_PERM is used
>> by nl80211.c. Add definition if not defined by target kernel.
> 
> NACK, this patch is really bad and breaks all security properties since
> older kernels will not know anything about the flag 0x10, they will
> assume that no permission checks are required.

Obviously been cutting to many corners here.

> The only sane thing to do is to
> #define GENL_UNS_ADMIN_PERM GENL_ADMIN_PERM
> 
> and not get the user-namespace-awareness on kernels that didn't know
> about the flag already.

Will send a v2 using your suggestion.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
