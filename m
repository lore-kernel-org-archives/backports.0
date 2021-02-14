Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_TVD_MIME_EPI,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A30C433E0
	for <backports@archiver.kernel.org>; Sun, 14 Feb 2021 20:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F32764D73
	for <backports@archiver.kernel.org>; Sun, 14 Feb 2021 20:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhBNT7r (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 14 Feb 2021 14:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhBNT7q (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 14 Feb 2021 14:59:46 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB63C061574
        for <backports@vger.kernel.org>; Sun, 14 Feb 2021 11:59:05 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Ddyj9085VzQlYV;
        Sun, 14 Feb 2021 20:58:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1613332715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7gPk2n7WMlwrm8uYirXWpFYPh4yMiWefArRX+3hPWCs=;
        b=LfSU3qOzn4nWkW8QIVEVsEdyIyvrxrTgTn5M4/qeXzZxEpyh/J40QVuCYBsYXhgYK8q70d
        6aTnsKzfQsS1LLQ8fM6XCgjxpfHChAi2Ntl7flpCuD5iTct+5OfyISyiGIRUuQiTHFCv0+
        1su+xXDnU9Nbx+OsMZn4cBB4yEKcV13KLXymDunPPDQenQEcQbXIV8OIlRdnCsbqulHAMJ
        Ki+Bdb7a4MrquDFJF0q/abtZOfdUAI4tkeXX31KBMrt1CiqkUhb3T71qQFHtBtweVf+d2e
        AmqL/pb3Lz2CzbILvuZow4wV2Au5WciQ9PnnFNgz+l07v0U/WXBmn9fC4UXpRw==
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id F9FXrTLq4wD5; Sun, 14 Feb 2021 20:58:34 +0100 (CET)
Subject: Re: [PATCH] backport: declare GPIO own_desc functions if GPIOLIB is
 not defined
To:     Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20201216142634.1625546-1-luca@coelho.fi>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <479949cf-8d78-5982-5dc1-72ef9184c84e@hauke-m.de>
Date:   Sun, 14 Feb 2021 20:58:23 +0100
MIME-Version: 1.0
In-Reply-To: <20201216142634.1625546-1-luca@coelho.fi>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cYYzi39Dvr9bteHgroTTTkdERgZWX6FuA"
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -7.44 / 15.00 / 15.00
X-Rspamd-Queue-Id: 149C417D0
X-Rspamd-UID: 54a714
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cYYzi39Dvr9bteHgroTTTkdERgZWX6FuA
Content-Type: multipart/mixed; boundary="4kYgji0YX4POfU3GSeAhaMH4ydXoICIwc";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
Cc: johannes@sipsolutions.net
Message-ID: <479949cf-8d78-5982-5dc1-72ef9184c84e@hauke-m.de>
Subject: Re: [PATCH] backport: declare GPIO own_desc functions if GPIOLIB is
 not defined
References: <20201216142634.1625546-1-luca@coelho.fi>
In-Reply-To: <20201216142634.1625546-1-luca@coelho.fi>

--4kYgji0YX4POfU3GSeAhaMH4ydXoICIwc
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/16/20 3:26 PM, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
>=20
> In kernels older than v5.4, the gpiochip_request_own_desc() and the
> gpiochip_free_own_desc() functions are declared inside a
> CONFIG_GPIOLIB ifdef, so we need to declare them in our implementation
> to avoid compilation problems.
>=20
> Change-Id: Ic6da0d7ff9d99c64d110da63fb950fb555fd2782
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>   backport/compat/backport-5.3.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>=20
> diff --git a/backport/compat/backport-5.3.c b/backport/compat/backport-=
5.3.c
> index f501448e24cd..46e6a11d8da3 100644
> --- a/backport/compat/backport-5.3.c
> +++ b/backport/compat/backport-5.3.c
> @@ -45,6 +45,17 @@ static int gpiod_configure_flags(struct gpio_desc *d=
esc, const char *con_id,
>   }
>  =20
>   #undef gpiochip_request_own_desc
> +
> +/* In kernels older than 5.4, these function declarations are inside a=

> + * CONFIG_GPIOLIB ifdef, so we need to declare them here.
> + */
> +#ifndef CONFIG_GPIOLIB
> +extern struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *c=
hip,
> +						   u16 hwnum,
> +						   const char *label);
> +void gpiochip_free_own_desc(struct gpio_desc *desc);
> +#endif /* CONFIG_GPIOLIB */
> +
>   struct gpio_desc *backport_gpiochip_request_own_desc(struct gpio_chip=
 *gc,
>   					    unsigned int hwnum,
>   					    const char *label,
>=20

Thank you for the patch, I applied it and created a new 5.10.16 release.

Hauke


--4kYgji0YX4POfU3GSeAhaMH4ydXoICIwc--

--cYYzi39Dvr9bteHgroTTTkdERgZWX6FuA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAmApgN8ACgkQ8bdnhZyy
68fDFgf/VbECXTmzUSxITqWaE0s4q9ZlXP0l1/1YigtsojWvyTKZCfcUcXeuTiAA
M+TRw0UPaxNvrcxynm5Fa3SH7TGB8EPInn7PR0lw7x/O7g00ySd359qtQ1vmO06T
N2rx+urQx3OQLasqJVhKUEmzseMsNJ3es5COHS64s4m3wzJ19LlicdbaMtF+Pb5X
YzK1FgUdjL1yAdJLfjLcAgTATQ4m95UQE0QxC8u9cFG5E9NwSua/JmJ9tO9VPQQa
RrE4r5ZvEhy/l9xvkoVV2KYD+YxbLruQxJoF9E+NLdZ4v7oNUevhIr22iLyMictn
fHKdH+YcY7fHhS7KMpvTY1QLWc+ojg==
=mNlk
-----END PGP SIGNATURE-----

--cYYzi39Dvr9bteHgroTTTkdERgZWX6FuA--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
