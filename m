Return-Path: <SRS0=LA5M=NC=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_TVD_MIME_EPI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86830C67863
	for <backports@archiver.kernel.org>; Mon, 22 Oct 2018 19:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4562064C
	for <backports@archiver.kernel.org>; Mon, 22 Oct 2018 19:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA4562064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=backports-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeJWEJC (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 23 Oct 2018 00:09:02 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:33590 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbeJWEJC (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 23 Oct 2018 00:09:02 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 0B8114B45D;
        Mon, 22 Oct 2018 21:49:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id pZVvYbvOWUFV; Mon, 22 Oct 2018 21:49:08 +0200 (CEST)
Subject: Re: [Cocci] New release after 1.0.7?
To:     Johannes Berg <johannes@sipsolutions.net>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     "backports@vger.kernel.org" <backports@vger.kernel.org>
References: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
 <alpine.DEB.2.20.1808141515280.3371@hadrien>
 <1536564277.3224.7.camel@sipsolutions.net>
 <alpine.DEB.2.20.1809121214160.31876@hadrien>
 <1536747369.3678.11.camel@sipsolutions.net>
 <cf992997-868d-56dc-bd1e-1d2064af4def@broadcom.com>
 <1be0fb185e04dd80f57fcf1fe04ddf5491601f3d.camel@sipsolutions.net>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <6e4b8e78-8a10-3987-dbbb-7793e351e355@hauke-m.de>
Date:   Mon, 22 Oct 2018 21:49:03 +0200
MIME-Version: 1.0
In-Reply-To: <1be0fb185e04dd80f57fcf1fe04ddf5491601f3d.camel@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ji54ca0zIKpkn71525dDbm7uJGT8Ugn6T"
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ji54ca0zIKpkn71525dDbm7uJGT8Ugn6T
Content-Type: multipart/mixed; boundary="xT57DvNm7jcneC0YiJ9leaYrGtwlwl0vP";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: Johannes Berg <johannes@sipsolutions.net>,
 Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Message-ID: <6e4b8e78-8a10-3987-dbbb-7793e351e355@hauke-m.de>
Subject: Re: [Cocci] New release after 1.0.7?
References: <32b52167e7dd5734ba4aa5f21aa1fddd257e6292.camel@intel.com>
 <alpine.DEB.2.20.1808141515280.3371@hadrien>
 <1536564277.3224.7.camel@sipsolutions.net>
 <alpine.DEB.2.20.1809121214160.31876@hadrien>
 <1536747369.3678.11.camel@sipsolutions.net>
 <cf992997-868d-56dc-bd1e-1d2064af4def@broadcom.com>
 <1be0fb185e04dd80f57fcf1fe04ddf5491601f3d.camel@sipsolutions.net>
In-Reply-To: <1be0fb185e04dd80f57fcf1fe04ddf5491601f3d.camel@sipsolutions.net>

--xT57DvNm7jcneC0YiJ9leaYrGtwlwl0vP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10/22/2018 01:45 PM, Johannes Berg wrote:
> On Mon, 2018-10-22 at 13:44 +0200, Arend van Spriel wrote:
>> On 9/12/2018 12:16 PM, Johannes Berg wrote:
>>> On Wed, 2018-09-12 at 12:14 +0200, Julia Lawall wrote:
>>>
>>>>> I see now that the website advertises the 1.0.7 release, however
>>>>>
>>>>>  * it's not tagged in git(hub) - all previous releases have a tag
>>>>>  * commit c1522bde ("Release 1.0.7") is NOT what's released as 1.0.=
7 on
>>>>>    the website
>>>>>  * it *looks* like the actual 1.0.7 release was cut from a much new=
er
>>>>>    git commit, likely with the fix?
>>>>
>>>> There is now a tag for the official release of 1.0.7 in github.
>>>
>>> Great, thanks!
>>
>> Were you able to build this tag? I probably have dependency issues on =

>> our build server. I tried following the install.txt in coccinelle repo=
,=20
>> but still getting failures. Some hints might be useful. The server run=
s=20
>> ubuntu trusty which is pretty old of course.
>=20
> Hmm. I built something, either that tag or the tarball?
>=20
> johannes

I built the tag on Debian stable successfully, some older versions did
not build but this tag worked.

Hauke


--xT57DvNm7jcneC0YiJ9leaYrGtwlwl0vP--

--Ji54ca0zIKpkn71525dDbm7uJGT8Ugn6T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAlvOKbMACgkQ8bdnhZyy
68eEywgA20vGqcGtjXClzOmd2RVql1ZXp717bF1XTcqgLzTGckGpnolv5NGgjLH0
cruQUBwijxLjgYTXXqi5Y7f7kA1Sf0vZn5Xbrw9HCUfI2d1ev/OeZmDBQbj+Fkd+
lWT7RK8SMNbLPYHDGOu560Vjjq/rJtDa/84KIOb6NkC7csry7R1TCYe8iCKo/j3r
1rjrw+hRl4zl63/UKYYUx/fwV758ARsrWHGLNVWRGXp8OJsq2ncD9grEOWFK3vOj
RrTcVDeg5a6yJnQn3h2KLwCPy5LqTIE+kQmzzzRcls6kyGZ0C+hJAaQUw5wC+AjS
l70Bpl3Ea3um0dC6PJ4WFZxntQUsIQ==
=x6yB
-----END PGP SIGNATURE-----

--Ji54ca0zIKpkn71525dDbm7uJGT8Ugn6T--
--
To unsubscribe from this list: send the line "unsubscribe backports" in
