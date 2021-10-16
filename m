Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E658C433EF
	for <backports@archiver.kernel.org>; Sat, 16 Oct 2021 12:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83E086115C
	for <backports@archiver.kernel.org>; Sat, 16 Oct 2021 12:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbhJPMN0 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sat, 16 Oct 2021 08:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbhJPMN0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 16 Oct 2021 08:13:26 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA53DC061570
        for <backports@vger.kernel.org>; Sat, 16 Oct 2021 05:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=U8A4BUTrre17PX1OtjrGn6q7xqrGKgfW842H+QogGtk=;
        t=1634386278; x=1635595878; b=tsKKvzLCfoMs7zXqm7/E3Wi7CB42+DRe6zdmSk8Hx9zkd5B
        695e4meWIS7u6zhG4GYMDIShN/Z6ENJv1ruDj1CEJl7sYO8CoEJwgzlDXHRz28ogvBxvD5E7CXYvQ
        hs1lWjzePFKkCP5CKR9b/RCiV9wghCrq0MmFprT+gjcccQm4n91ll18G5Vc2HZwJSMOCXDckPe4Wv
        G1fWgiK0dNeTPyPX9e2SIsyQj6tMy4NGMridTqiSlIIoCQN32YMtmer7QYGarJmdGFKp2CO/rsKld
        vBwBt+XlVOGyg/Pdf0Q8h51AYNB0CuB/Sf44atfJ1LZzrVifUWSSAkVdP72ZMKLw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mbiWu-0032hB-50;
        Sat, 16 Oct 2021 14:11:12 +0200
Date:   Sat, 16 Oct 2021 14:11:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
CC:     Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] backports: add rb_tree_cached
In-Reply-To: <72a11f8f-66d4-4410-854d-1988f97b3d49@hauke-m.de>
References: <20210715180046.6635727a182b.Id747625a81c1c87ae14145eff93436b94a122980@changeid> <72a11f8f-66d4-4410-854d-1988f97b3d49@hauke-m.de>
Message-ID: <2B913000-E02A-4933-B337-E6E43DD21AF6@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org



On 16 October 2021 14:06:42 CEST, Hauke Mehrtens <hauke@hauke-m=2Ede> wrot=
e:
>On 7/15/21 6:00 PM, Johannes Berg wrote:
>> From: Johannes Berg <johannes=2Eberg@intel=2Ecom>
>>=20
>> We just map them to the normal rb_tree, losing the efficiency
>> gain in this case=2E
>>=20
>> ticket=3Dnone
>>=20
>> Signed-off-by: Johannes Berg <johannes=2Eberg@intel=2Ecom>
>
>I had a look at this too and the cached optimization seams to be=20
>completely in the header file now, initially the in kernel rb lib code=20
>was changed too=2E
>
>Sine this commit we should be able to fully backport this easily:
>https://git=2Ekernel=2Eorg/linus/9f973cb38088e0cf42e0bae97ff140813e623f13
>

I guess I could've always done it that way, just didn't bother as it didn'=
t seem so important, at least not to iwlwifi=2E

johannes=20
--=20
Sent from my phone=2E 
--
To unsubscribe from this list: send the line "unsubscribe backports" in
