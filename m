Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D57EC11F6A
	for <backports@archiver.kernel.org>; Thu,  1 Jul 2021 21:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7503261410
	for <backports@archiver.kernel.org>; Thu,  1 Jul 2021 21:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhGAVyC (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 1 Jul 2021 17:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhGAVyC (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 1 Jul 2021 17:54:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948E1C061762
        for <backports@vger.kernel.org>; Thu,  1 Jul 2021 14:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6Jn3+c+mXxVp7lbLeUDqAn/i3Hnc13F6aNS2BCdHEJk=;
        t=1625176291; x=1626385891; b=lAzNXcDOfyCDTkjT0C9FOcmsQgdMfk4AbMkHkd7LggzcFdw
        alunknUuqUgWoOQtBiU0/7zOYrERiIbzmKHsWRG/TGdYh7+VrUD3gZynsUbQbEVWNxC10p4H2ghGv
        1tz6GYjSuaOlN8RNgOuCqY5QBkec8tyFIkSrWK8t6Kn+Vu+veEmMMCfeHB2jYnfA5bYPYiO3Lfesp
        d+jq1J2znH6ouYRHrOagcVhm4rF28CkOHtwDhWKR1cfF0Zd+7dc7WvuOJUbVRsNDfRa0KZ+4BdFr4
        t4srEOl+CCxpvWgMovcBQ5bqfQizNsLq0cJ6ZxC628TVkHlK7dpSIKXVNN2HAc/A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lz4af-00EP5q-Jm; Thu, 01 Jul 2021 23:51:21 +0200
Message-ID: <6260cc7d2771a5d67e04736a036ae23c8441c57d.camel@sipsolutions.net>
Subject: Re: backports spatch question
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Cc:     backports@vger.kernel.org
Date:   Thu, 01 Jul 2021 23:51:20 +0200
In-Reply-To: <cdc5aeac-e618-5b67-15fe-0a4fc5ef6e21@candelatech.com>
References: <e26b0d55-8662-ecf7-6630-ac23a99374b5@candelatech.com>
         <84336f24b55f6ef407511235a90af4b24a8488ce.camel@sipsolutions.net>
         <cdc5aeac-e618-5b67-15fe-0a4fc5ef6e21@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Thu, 2021-07-01 at 14:40 -0700, Ben Greear wrote:
> 
> [greearb@v-f34-64 backports]$ spatch --version
> spatch version 1.0.8-gf4ba8df-dirty compiled with OCaml version 4.11.1


I just realized I never even tried on my system recently, I'm still on
F33 and have

spatch version 1.0.8-gc1dbb4f-dirty compiled with OCaml version 4.11.1

Could you try some other version? Backports says it needs "at least"
1.0.7 but perhaps only exactly that works?

johannes

--
To unsubscribe from this list: send the line "unsubscribe backports" in
