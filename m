Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2B9C4332F
	for <backports@archiver.kernel.org>; Thu, 20 Oct 2022 07:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJTHXJ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Thu, 20 Oct 2022 03:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJTHXI (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 20 Oct 2022 03:23:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8F8153E19
        for <backports@vger.kernel.org>; Thu, 20 Oct 2022 00:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=GNv6SGwYW6MBkPZcYWCfUDXhYXSmdQOi+f8tvadM2vg=;
        t=1666250587; x=1667460187; b=CUuV7dUw4V3B4rdf47SPS8o5PP+Cl9UN511huS4odsLTERO
        CcqHa43sHgwqdJHP1cyKg5Vy7pRNCgnmGSqyEH+0/hOxu+giD9RZ25wKySUJ1aw1Mc/G9DIzsT4PN
        pyl1xqH9JqdHTPlzk5lJ7sjcZ2DeSiFKQKQUYqr2CIF7aYjza3K3YA6eB8FuAsv6ADf589fEgdmMo
        RUMmDwW1A5ajDldx1gxOtq8ijzin5ai2OiQ5HpiI+dI8hdSG5pLNOpwlIDN4+el1yQq2ESLDOka7I
        daNidmeZmmsLmfO0fvaKlqLhRmC7VUdsuEea4acHVffafaiAGTjFY0WGLoYjPiiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1olPtQ-00BtVk-0j;
        Thu, 20 Oct 2022 09:23:04 +0200
Message-ID: <06ccc75a230b24e7deddef0a1b88004d8e9bdb60.camel@sipsolutions.net>
Subject: Re: [PATCH 00/38] backports updates
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Cc:     nbd@nbd.name
Date:   Thu, 20 Oct 2022 09:23:02 +0200
In-Reply-To: <364548b0-8b4e-853a-27f4-38051097cb09@hauke-m.de>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
         <364548b0-8b4e-853a-27f4-38051097cb09@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Wed, 2022-10-19 at 22:53 +0200, Hauke Mehrtens wrote:
>=20
> Can I remove some of the tags from the commit messages you probably used=
=20
> internally form the patches before applying them
>=20

Feel free to do whatever you like :)

> or will you send=20
> cleaned up versions?

Well I only sent it out because Felix asked - I'll probably not have
time soon given the conference is coming up etc.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
