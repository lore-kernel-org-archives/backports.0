Return-path: <backports-owner@vger.kernel.org>
Received: from mail-eopbgr20119.outbound.protection.outlook.com ([40.107.2.119]:2944
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752390AbeFZGyt (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 26 Jun 2018 02:54:49 -0400
From: Aaron Komisar <aaron.komisar@tandemg.com>
To: Wan-Hua Chang <winnie.chang@cypress.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>,
        "Chi-Hsien.Lin@cypress.com" <chi-hsien.lin@cypress.com>
Subject: Re: [PATCH] Updating id field in backports genl family
Date: Tue, 26 Jun 2018 06:54:46 +0000
Message-ID: <AM4PR0202MB29164C902F2A904E875C123EF8490@AM4PR0202MB2916.eurprd02.prod.outlook.com> (sfid-20180626_085451_895564_7A4E76BC)
References: <20180611102947.GA188023@aremote01.aus.cypress.com>
 <1529944813.10347.3.camel@sipsolutions.net>,<20180626060717.GA33209@aremote01.aus.cypress.com>
In-Reply-To: <20180626060717.GA33209@aremote01.aus.cypress.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Jun 26, 2018 at 09:07:13PM +0300, Wan-Hua Chang wrote:

>> Looking at this again ...
>>=20
>> > I see the patch causes compiling error becasue family->family is not
>> > found when LINUX_VERSION >=3D 3.13
>>=20
>> Yeah, that seems right.
>>=20
>> > backports/backport/backport-include/genetlink.h
>> > struct backport_genl_fmaily is only defined when LINUX_VERSION < 3.13
>> >=20
>> >=20
>> > And in backports/backport/compat/backport-3.13.c line 127=20
>> >=20
>> > family->id =3D family->family.id
>> >=20
>> > it looks like this line has done what the patch want to do. Is the
>> > comprehension correct?
>>=20
>> I don't think so. We call this function - via
>> __real_bp_extack_genl_register_family() - on copy->family, so we do need
>> to copy like Aaron said, we just need to make it conditional for kernel
>> < 3.13 because on 3.13 we don't use this sub-family thing.
>>=20
>> I've committed a fix - does that work for both of you? Aaron?
>Hi Johannes,=20
>Yes, the fix works for me, thanks.
Same here.
Thanks!
>
>>=20
>> johannes
    =
--
To unsubscribe from this list: send the line "unsubscribe backports" in
