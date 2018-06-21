Return-path: <backports-owner@vger.kernel.org>
Received: from mail-db5eur01on0136.outbound.protection.outlook.com ([104.47.2.136]:5120
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750806AbeFUOOl (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 21 Jun 2018 10:14:41 -0400
From: Aaron Komisar <aaron.komisar@tandemg.com>
To: Wan-Hua Chang <winnie.chang@cypress.com>
CC: Johannes Berg <johannes@sipsolutions.net>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>,
        "chi-hsien.lin@cypress.com" <chi-hsien.lin@cypress.com>
Subject: Re: [PATCH] Updating id field in backports genl family
Date: Thu, 21 Jun 2018 14:14:39 +0000
Message-ID: <AM4PR0202MB2916993B0F8E323A5319820DF8760@AM4PR0202MB2916.eurprd02.prod.outlook.com> (sfid-20180621_161444_096545_15256535)
References: <20180611102947.GA188023@aremote01.aus.cypress.com>
 <1528719907.10346.0.camel@sipsolutions.net>
 <6bbc4985-0a18-80f5-2a52-6bc04f27af3a@cypress.com>
 <AM4PR0202MB2916BC5C05FC8D9A2DB041EBF87F0@AM4PR0202MB2916.eurprd02.prod.outlook.com>,<20180621101232.GA116498@aremote01.aus.cypress.com>
In-Reply-To: <20180621101232.GA116498@aremote01.aus.cypress.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2018-06-21 at 13:12 +0300, Wan-Hua Chang wrote:
>Hi Aaron,
>
>Since you want to backport from Linux v4.4.92 drivers to Linux v3.10.104
>kernel, you can use "git checkout linux-4.4.y" to set backports git to
>4.4. With this version, there is no backport-4.12.c created and this
>file is not needed in your case as well. If you use backports master
>branch it supposes you want to backports Linux latest drivers to
>v3.10.104.
>

I am doing the development on a recent kernel (4.16) and the target kernel =
is
either v3.10.104 or v4.4.92.

Thanks,
Aaron=
--
To unsubscribe from this list: send the line "unsubscribe backports" in
