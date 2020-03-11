Return-Path: <SRS0=0b0C=44=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B855CC10F27
	for <backports@archiver.kernel.org>; Wed, 11 Mar 2020 09:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B292146E
	for <backports@archiver.kernel.org>; Wed, 11 Mar 2020 09:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgCKJif (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:38:35 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45680 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgCKJie (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 11 Mar 2020 05:38:34 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jBxou-000wMb-IK; Wed, 11 Mar 2020 10:38:32 +0100
Message-ID: <05b2f075407f4be8672a4325ed478a26296f856d.camel@sipsolutions.net>
Subject: Re: [PATCH 01/15] backports: handle RHEL 7.6 kernel
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Date:   Wed, 11 Mar 2020 10:38:31 +0100
In-Reply-To: <98e5b161-1bde-e663-d08a-6f142ab40aed@hauke-m.de>
References: <20200221085624.6213-1-johannes@sipsolutions.net>
         <20200221095437.388a35c2cde6.Ic310f826e4d1e036eca65b4fa7d13d2da12620aa@changeid>
         <98e5b161-1bde-e663-d08a-6f142ab40aed@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Sun, 2020-02-23 at 23:24 +0100, Hauke Mehrtens wrote:

> > +++ b/backport/backport-include/linux/time.h
> > @@ -1,5 +1,11 @@
> >  #ifndef __BACKPORT_LINUX_TIME_H
> >  #define __BACKPORT_LINUX_TIME_H
> > +
> > +#if RHEL_RELEASE_CODE >= RHEL_RELEASE_VERSION(7,6)
> > +#include_next <linux/time64.h>
> > +#include <uapi/linux/time.h>
> > +#endif
> > +
> 
> Something is strange with the time header file handling.

Too many changes in this area, I guess ;-)

(I'd appreciate if you trimmed your quoting a bit, it's hard to find
your responses in the pages-long text)

> > +EXPORT_SYMBOL_GPL(get_user_pages_unlocked);
> > +#endif
> > +
> 
> Please check if this is needed at all.

I guess we can

> > -static struct scatterlist *scatterwalk_ffwd(struct scatterlist dst[2],
> > +#if RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6)
> > + static struct scatterlist *scatterwalk_ffwd(struct scatterlist dst[2],
> 
> Why  did you add a space?

Heh.

> > @@ -441,3 +450,4 @@ int backport_genlmsg_multicast_allns(const struct genl_family *family,
> >  	return genlmsg_mcast(skb, portid, group, flags);
> >  }
> >  EXPORT_SYMBOL_GPL(backport_genlmsg_multicast_allns);
> > +#endif /* RHEL_RELEASE_CODE < RHEL_RELEASE_VERSION(7,6) */
> 
> Please check again if all these ifdefs for redhat are needed in this
> function. It looks like there are some bigger ifdes around most of the
> code in here.

This stuff is very tricky, and they tend to backport pieces of it ...

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
