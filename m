Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F35C433F5
	for <backports@archiver.kernel.org>; Fri, 27 May 2022 07:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240822AbiE0HXy (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 27 May 2022 03:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238720AbiE0HXy (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 27 May 2022 03:23:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1AED712
        for <backports@vger.kernel.org>; Fri, 27 May 2022 00:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qGEJN3A3phDynRkH3U4/CEevCjWlFrFkSW8Civq+JUY=;
        t=1653636233; x=1654845833; b=C4+5llQSAzwyfM2s79vVKC044wLb1lpjA09hkf39GG9UR9y
        nlgoTeb8OT9ShWpc11qh1hnu1KWga9EvXJwizNco2FR0ze+nqs9oesWkNfuSjDNIpyZjXsl5iXpST
        LvGLJp0yPphPFTlxjRRHLvy1uWoW5QDZFu1l/oMTXjsUaM/UnIBbfj2AI9v5RqwLVsTgle3OMjgEK
        AKGp60Icoog+h/o6bahs4KNke9QKZtE01lShI60JVzZVPspo30u0cIi9P7C/CmFck+EmyEvUh0C18
        ZWiQpvstUMIEHzJSj5kstITE/IQKiX/yaFQgW9Vba5gGIaZmGQETe9UoiTYk1Mzg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nuUK6-005xP6-Oo;
        Fri, 27 May 2022 09:23:50 +0200
Message-ID: <5361ae998893a0cd427a35a3050c6eb55b798aa6.camel@sipsolutions.net>
Subject: Re: Backport wifi drivers from 5.15.8.1-1 to 4.15.0-38 not
 compatible with NetworkManager 1.2.6
From:   Johannes Berg <johannes@sipsolutions.net>
To:     =?ISO-8859-1?Q?Nicol=F2?= Sprea <nsprea@gmail.com>,
        backports@vger.kernel.org
Date:   Fri, 27 May 2022 09:23:49 +0200
In-Reply-To: <CA+BgFQX=E53UWdw0u+36eO8KZB5HwTFM8Usp5Ju2b4eC6ah_Fg@mail.gmail.com>
References: <CA+BgFQUdDoCx_zrxNjWGKWNMjioimeO+CSzGkx3Zg14bbbNpQA@mail.gmail.com>
         <CA+BgFQX=E53UWdw0u+36eO8KZB5HwTFM8Usp5Ju2b4eC6ah_Fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Fri, 2022-05-27 at 08:42 +0200, Nicol=C3=B2 Sprea wrote:
> Hi backport team,
> I'm trying to backport wifi drivers from 5.15.8.1-1 to 4.15.0-3.
> However, starting NetworkManager results in the following kernel trace:
>=20
> kernel: [ 1442.859649] BUG: unable to handle kernel NULL pointer
> dereference at 00000000000001e8
> kernel: [ 1442.859835] IP: cfg80211_init_wdev+0xa3/0x150 [cfg80211]
> kernel: [ 1442.859917] PGD 8000000187ac4067 P4D 8000000187ac4067 PUD
> 186ce3067 PMD 0
>=20

Yeah, I think Mathy reported the same.

You can turn off WEXT support in the meantime in the Kconfig for
backports, but I'll need to investigate some time.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
