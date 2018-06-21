Return-path: <backports-owner@vger.kernel.org>
Received: from mail-sn1nam02on0121.outbound.protection.outlook.com ([104.47.36.121]:11014
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751150AbeFUKMv (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 21 Jun 2018 06:12:51 -0400
Date: Thu, 21 Jun 2018 05:12:32 -0500
From: Wan-Hua Chang <winnie.chang@cypress.com>
To: Aaron Komisar <aaron.komisar@tandemg.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>,
        "chi-hsien.lin@cypress.com" <chi-hsien.lin@cypress.com>
Subject: Re: [PATCH] Updating id field in backports genl family
Message-ID: <20180621101232.GA116498@aremote01.aus.cypress.com> (sfid-20180621_121253_884644_5E5BB83A)
References: <20180611102947.GA188023@aremote01.aus.cypress.com>
 <1528719907.10346.0.camel@sipsolutions.net>
 <6bbc4985-0a18-80f5-2a52-6bc04f27af3a@cypress.com>
 <AM4PR0202MB2916BC5C05FC8D9A2DB041EBF87F0@AM4PR0202MB2916.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AM4PR0202MB2916BC5C05FC8D9A2DB041EBF87F0@AM4PR0202MB2916.eurprd02.prod.outlook.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Aaron,

Since you want to backport from Linux v4.4.92 drivers to Linux v3.10.104
kernel, you can use "git checkout linux-4.4.y" to set backports git to
4.4. With this version, there is no backport-4.12.c created and this
file is not needed in your case as well. If you use backports master
branch it supposes you want to backports Linux latest drivers to
v3.10.104.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
