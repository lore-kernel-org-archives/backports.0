Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BA3C43219
	for <backports@archiver.kernel.org>; Wed, 12 Oct 2022 08:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJLIun (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 12 Oct 2022 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJLIuk (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 12 Oct 2022 04:50:40 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD65A75FED
        for <backports@vger.kernel.org>; Wed, 12 Oct 2022 01:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=82biTP1+cfq9UfHZqGWXoDWHbOiqXNw6yWH9/S7t6qs=;
        t=1665564639; x=1666774239; b=h+WVIpmHXDA2eOori3oo7XH6Jmvo0N5FqKpBD1Bq4iX37BX
        bcHjvQPbFBfljkqzDY4Qhxi9JHWHN75ocTgErBAXFNt1gxeDk4HPVSbO7Sc7VDNkM/ebBRBG3vyK/
        bhinCA5CUNHezEz8ehZ84xKPdQoLtc7zjT1HZRmY1Lz5VzOm/KU+CnKeqhdYKrqCe6eAjxjPODQft
        bxPr2IN3SsiX0y4/kRY6uNmKKmHghKwKqb0zcke3YG2h9cnk20FFuFyJ48YwCHj9D68ZB7CbcEQWI
        UfyZMyHHBeMLaCHVcUaE5WHFyuHcTdU1ukzJy61rYTKVKYq4/VEOYg1l2zi1jzCw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiXRl-004kGC-01;
        Wed, 12 Oct 2022 10:50:37 +0200
Message-ID: <e41eb7b7cf94b02fc51f7d0da696c6c6035bb7a9.camel@sipsolutions.net>
Subject: Re: [PATCH 11/38] backports: stub structs but remove
 ndo_fill_forward_path
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, backports@vger.kernel.org
Date:   Wed, 12 Oct 2022 10:50:36 +0200
In-Reply-To: <59047a24-e419-a750-afae-213f2d8aac0d@nbd.name>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
         <20221011230356.fc6d493894a6.I59271805ee60501a03c50f5ec05240393f1fb4be@changeid>
         <59047a24-e419-a750-afae-213f2d8aac0d@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

On Wed, 2022-10-12 at 10:18 +0200, Felix Fietkau wrote:
>=20
> > +++ b/patches/0107-net-forward-path.cocci
> > @@ -0,0 +1,19 @@
> > +@ops@
> > +identifier ops, fn;
> > +@@
> > +const struct net_device_ops ops =3D {
> > ++#if LINUX_VERSION_IS_GEQ(5,13,0)
> > +  .ndo_fill_forward_path =3D fn,
> > ++#endif
> > +  ...
> > +};
> > +
> > +@@
> > +identifier ops.fn;
> > +@@
> > ++#if LINUX_VERSION_IS_GEQ(5,13,0)
> > +int fn(...)
> > +{
> > +...
> > +}
> > ++#endif /* LINUX_VERSION_IS_GEQ(5,13,0) */

> How about using #ifdef NET_DEVICE_PATH_STACK_MAX here as well?
>=20

I guess that would work, don't remember that I thought about it and
rejected that for some reason.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
