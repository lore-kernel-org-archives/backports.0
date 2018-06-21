Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:58710 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeFUORF (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 21 Jun 2018 10:17:05 -0400
Message-ID: <1529590622.26642.6.camel@sipsolutions.net> (sfid-20180621_161706_978921_779F659E)
Subject: Re: [PATCH] Updating id field in backports genl family
From: Johannes Berg <johannes@sipsolutions.net>
To: Aaron Komisar <aaron.komisar@tandemg.com>,
        Wan-Hua Chang <winnie.chang@cypress.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
        "chi-hsien.lin@cypress.com" <chi-hsien.lin@cypress.com>
Date: Thu, 21 Jun 2018 16:17:02 +0200
In-Reply-To: <AM4PR0202MB2916993B0F8E323A5319820DF8760@AM4PR0202MB2916.eurprd02.prod.outlook.com>
References: <20180611102947.GA188023@aremote01.aus.cypress.com>
         <1528719907.10346.0.camel@sipsolutions.net>
         <6bbc4985-0a18-80f5-2a52-6bc04f27af3a@cypress.com>
         <AM4PR0202MB2916BC5C05FC8D9A2DB041EBF87F0@AM4PR0202MB2916.eurprd02.prod.outlook.com>
        ,<20180621101232.GA116498@aremote01.aus.cypress.com>
         <AM4PR0202MB2916993B0F8E323A5319820DF8760@AM4PR0202MB2916.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2018-06-21 at 14:14 +0000, Aaron Komisar wrote:
> On Mon, 2018-06-21 at 13:12 +0300, Wan-Hua Chang wrote:
> > Hi Aaron,
> > 
> > Since you want to backport from Linux v4.4.92 drivers to Linux v3.10.104
> > kernel, you can use "git checkout linux-4.4.y" to set backports git to
> > 4.4. With this version, there is no backport-4.12.c created and this
> > file is not needed in your case as well. If you use backports master
> > branch it supposes you want to backports Linux latest drivers to
> > v3.10.104.
> > 
> 
> I am doing the development on a recent kernel (4.16) and the target kernel is
> either v3.10.104 or v4.4.92.

Yeah, I think we just need to put the right ifdef on that id assignment?

We might even have that already internally, I'll check.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
