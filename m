Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CE5C07E99
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 19:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDE7A61353
	for <backports@archiver.kernel.org>; Mon,  5 Jul 2021 19:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhGETRU (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhGETRU (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 5 Jul 2021 15:17:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1405DC061574
        for <backports@vger.kernel.org>; Mon,  5 Jul 2021 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=CObFkJUVNdkvdzHkIPtaIGKO3ct6xXY0DZTp1OL4oLg=;
        t=1625512483; x=1626722083; b=EutlzTggNZ91bl+PuI0X7d2bdg7ZB+Z5xqKZBFUzb5E2d6k
        urb6/XtNuEviYHDqKpAImED3cCXnYLjN0WodCHXMKWlEMBFqhJdIRGKg02tkvx6YQxwr0xn5WtU5D
        M875FtoSMmMgZW8Iwnjy8BrVuIdbnGXtGiKY5wGM+xKVHiylvm5Rk4b3LFWZmE7rRD/kK0O0IpfEK
        obTtNYIgjF6N1RxH5ZeWaIdlgKav+nNLjoLuSNuAOButaHJsVi99zOyaCsGUg0EL9k/L6YiyP/imN
        A47z/gEmWphHpAX6j4BZGEtkIHi+mJiktZU29heilVk1+ZOGcSgPtSSI0lgwvvGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m0U36-00Fuqt-QA; Mon, 05 Jul 2021 21:14:32 +0200
Message-ID: <05c73f83ce63bc1e15c40836fce56dcdb7eb9a8b.camel@sipsolutions.net>
Subject: Re: backports spatch question
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     backports@vger.kernel.org
Date:   Mon, 05 Jul 2021 21:14:31 +0200
In-Reply-To: <a5e843c9-bed8-a381-4e67-dac3a1a207ed@candelatech.com>
References: <e26b0d55-8662-ecf7-6630-ac23a99374b5@candelatech.com>
         <84336f24b55f6ef407511235a90af4b24a8488ce.camel@sipsolutions.net>
         <cdc5aeac-e618-5b67-15fe-0a4fc5ef6e21@candelatech.com>
         <6260cc7d2771a5d67e04736a036ae23c8441c57d.camel@sipsolutions.net>
         <31776ce8-7014-b3ed-41bf-121e8ce5001c@candelatech.com>
         <244749b289fcaca6826670471890420d4b51b6ed.camel@sipsolutions.net>
         <a5e843c9-bed8-a381-4e67-dac3a1a207ed@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2021-07-05 at 12:10 -0700, Ben Greear wrote:
> On 7/5/21 10:55 AM, Johannes Berg wrote:
> > On Mon, 2021-07-05 at 10:47 -0700, Ben Greear wrote:
> > > On 7/1/21 2:51 PM, Johannes Berg wrote:
> > > > On Thu, 2021-07-01 at 14:40 -0700, Ben Greear wrote:
> > > > > 
> > > > > [greearb@v-f34-64 backports]$ spatch --version
> > > > > spatch version 1.0.8-gf4ba8df-dirty compiled with OCaml version 4.11.1
> > > > 
> > > > 
> > > > I just realized I never even tried on my system recently, I'm still on
> > > > F33 and have
> > > > 
> > > > spatch version 1.0.8-gc1dbb4f-dirty compiled with OCaml version 4.11.1
> > > > 
> > > > Could you try some other version? Backports says it needs "at least"
> > > > 1.0.7 but perhaps only exactly that works?
> > > > 
> > > > johannes
> > > > 
> > > 
> > > I hacked through this by removing the offending spatches.  Seems to have worked OK
> > > since the kernels I am using are relatively recent.
> > > 
> > > I spent a while getting the mac80211 patches from owrt tweaked or otherwise
> > > resolved so that it would patch against my backports tree.
> > > 
> > > But now I'm having trouble with rfkill and not sure best way forward.  Is backports
> > > supposed to take care of this somehow, or do I need to go hacking in openwrt?
> > 
> > You need this bit in backport-include/linux/rfkill.h, not sure why it's
> > not there yet:
> > 
> > #if LINUX_VERSION_IS_LESS(5,11,0)
> > 
> > /* This should come from uapi/linux/rfkill.h, but it was much easier
> >   * to do it this way.
> >   */
> > enum rfkill_hard_block_reasons {
> >          RFKILL_HARD_BLOCK_SIGNAL        = 1 << 0,
> >          RFKILL_HARD_BLOCK_NOT_OWNER     = 1 << 1,
> > };
> > 
> > static inline bool rfkill_set_hw_state_reason(struct rfkill *rfkill,
> >                                                bool blocked, unsigned
> > long reason)
> > {
> >          return rfkill_set_hw_state(rfkill, blocked);
> > }
> > 
> > #endif /* 5.11 */
> > 
> > 
> > johannes
> > 
> 
> I added that patch to the bottom of the file, just above the final #endif

Well I guess it needs to be at the beginning in the first existing ifdef
block.

https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwifi.git/tree/backport-include/linux/rfkill.h

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
