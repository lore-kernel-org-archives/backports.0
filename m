Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11199C07E96
	for <backports@archiver.kernel.org>; Tue,  6 Jul 2021 06:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA39261964
	for <backports@archiver.kernel.org>; Tue,  6 Jul 2021 06:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhGFGos (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 6 Jul 2021 02:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhGFGor (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 6 Jul 2021 02:44:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A279C061574
        for <backports@vger.kernel.org>; Mon,  5 Jul 2021 23:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=vJVe6yoxIeQKU8EDVu5TZQbVQn2Sls1Yuv0a1uyQXsg=;
        t=1625553729; x=1626763329; b=jjZ3iNfgAx1wByzpHV5B1EQs03dyyAvz2hJJZ1AVpHdVIXy
        ttV9ALSYIAea1BEOfjb8qQXoqgM6DbMkQpkDb8ijqkrRlYmvbAHbVr3AcNVd7fLXQNvVDyJV/NW5I
        G2AQo5DRV2qsO2SetfPbozfzrMphj0Cag/sVwZIck17dkV+c+4wbI1eL4x7zFv35304/PKnBt48Md
        mLCwdP2JDXDVmIFFzVDuk15OKgps0yJ5LxUxNB9eKjEmKkHaSw6WCf2idyYXZ1VD1K1Hsii/MYAEA
        GLy2pI5oaRFVupUcPweDxcEuckgr8BSGV4VrC/wizwoKKlhRnL+FrpGE3NITO8+A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1m0emN-00G6Wf-4H; Tue, 06 Jul 2021 08:41:59 +0200
Message-ID: <a9775be6b1faef0d05a5345630c52c37d9c7f220.camel@sipsolutions.net>
Subject: Re: backports spatch question
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     backports@vger.kernel.org
Date:   Tue, 06 Jul 2021 08:41:58 +0200
In-Reply-To: <94421dca-f1b7-1f89-27d1-a981845b5a63@candelatech.com>
References: <e26b0d55-8662-ecf7-6630-ac23a99374b5@candelatech.com>
         <84336f24b55f6ef407511235a90af4b24a8488ce.camel@sipsolutions.net>
         <cdc5aeac-e618-5b67-15fe-0a4fc5ef6e21@candelatech.com>
         <6260cc7d2771a5d67e04736a036ae23c8441c57d.camel@sipsolutions.net>
         <31776ce8-7014-b3ed-41bf-121e8ce5001c@candelatech.com>
         <244749b289fcaca6826670471890420d4b51b6ed.camel@sipsolutions.net>
         <a5e843c9-bed8-a381-4e67-dac3a1a207ed@candelatech.com>
         <05c73f83ce63bc1e15c40836fce56dcdb7eb9a8b.camel@sipsolutions.net>
         <f00e3ea0-97e4-4f47-b8d1-fd667668754b@candelatech.com>
         <33deca8741a231072f2a835ccf7a93eac1430e9d.camel@sipsolutions.net>
         <d772161b-673c-cb57-ca18-ce994fd1b28e@candelatech.com>
         <9ace0ebe7417d5ade9f5f1df02e46ad982c11c5e.camel@sipsolutions.net>
         <5cb833b8-4c9d-7628-fd1d-d95f12c3962c@candelatech.com>
         <40985f693651f6712aad27f1033c48d99dc5298c.camel@sipsolutions.net>
         <94421dca-f1b7-1f89-27d1-a981845b5a63@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Mon, 2021-07-05 at 13:30 -0700, Ben Greear wrote:
> So next problem is kcov stuff.  This is just FYI, I'll just revert this
> patch since I don't need it.

I guess that works, but FWIW, I did point you to our tree already
earlier in the thread and generally we do have backports there for
everything we needed. In this instance:

https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/backport-iwlwifi.git/tree/backport-include/linux/kcov.h

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
