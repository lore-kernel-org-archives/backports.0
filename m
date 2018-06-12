Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ve1eur01on0098.outbound.protection.outlook.com ([104.47.1.98]:20256
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932555AbeFLMKj (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 12 Jun 2018 08:10:39 -0400
From: Aaron Komisar <aaron.komisar@tandemg.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Wan-Hua Chang <winnie.chang@cypress.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>,
        "chi-hsien.lin@cypress.com" <chi-hsien.lin@cypress.com>
Subject: Re: [PATCH] Updating id field in backports genl family
Date: Tue, 12 Jun 2018 12:10:36 +0000
Message-ID: <AM4PR0202MB2916BC5C05FC8D9A2DB041EBF87F0@AM4PR0202MB2916.eurprd02.prod.outlook.com> (sfid-20180612_141042_174140_305E8E64)
References: <20180611102947.GA188023@aremote01.aus.cypress.com>
 <1528719907.10346.0.camel@sipsolutions.net>,<6bbc4985-0a18-80f5-2a52-6bc04f27af3a@cypress.com>
In-Reply-To: <6bbc4985-0a18-80f5-2a52-6bc04f27af3a@cypress.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


On  6/12/2018 4:50, Chi-hsien Lin wrote:
>On 06/11/2018 8:25, Johannes Berg wrote:
>> On Mon, 2018-06-11 at 05:29 -0500, Wan-Hua Chang wrote:
>>> Hi,
>>>
>>> I see the patch causes compiling error becasue family->family is not
>>> found when LINUX_VERSION >=3D 3.13
>>>
>>> backports/backport/backport-include/genetlink.h
>>> struct backport_genl_fmaily is only defined when LINUX_VERSION < 3.13
>>>

I built backports-output for recent kernels (4.4.92, for example) and didn'=
t get any compilation errors.
Which version are you using?

>>>
>>> And in backports/backport/compat/backport-3.13.c line 127
>>>
>>> family->id =3D family->family.id
>>>
>>> it looks like this line has done what the patch want to do. Is the
>>> comprehension correct?

This line does update family id, but it gets **copy**->family.
copy->family.id in backport-4.12.c is changed, but family->family.id remain=
s unchanged.

>>=20
>> I guess we have to put an ifdef around this ...
>>=20
>> Aaron?
>
>Hi Aaron,
>
>As Wan-Hua mentioned, it looks like backport-3.13.c line 127 syncs back=20
>the id for backport_genl_family structure for kernel < 3.13 already.
>
>Could you please share more details about the failure you saw without=20
>this change? What's the kernel version you used?
>

I am using target kernel version 3.10.104.
The problem I saw was that a driver using family id after calling genl_regi=
ster_family would always get 0 instead of the actual value.

>
>Regards,
>Chi-hsien Lin
>
>>=20
>> johannes
> .
>=20

Aaron
    =
--
To unsubscribe from this list: send the line "unsubscribe backports" in
