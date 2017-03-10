Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:40834 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934332AbdCJKJu (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 10 Mar 2017 05:09:50 -0500
Message-ID: <1489140587.3038.5.camel@sipsolutions.net> (sfid-20170310_110953_458923_5967B86E)
Subject: Re: [PATCH 1/4] patches: update crypto-ccm.patch for v4.11-rc1
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Fri, 10 Mar 2017 11:09:47 +0100
In-Reply-To: <53b84dec-ea90-eb9d-6392-952a80e37589@broadcom.com> (sfid-20170310_110844_780612_FCC3155B)
References: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
         <1489064253-3652-2-git-send-email-arend.vanspriel@broadcom.com>
         <1489127672.3038.0.camel@sipsolutions.net>
         <b5a13b6c-6ed7-7682-2043-1dcc8ddfec79@broadcom.com>
         <1489139555.3038.4.camel@sipsolutions.net>
         <53b84dec-ea90-eb9d-6392-952a80e37589@broadcom.com>
         (sfid-20170310_110844_780612_FCC3155B)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> > No, I meant adding all of crypto/ to copy-list and making sure
> > *that*
> > works across kernels ...
> 
> Understand. There seem to have been significant changes in crypto
> land making this a challenge. Still seems like right idea.

I'm not really sure it's the right idea, it seems like it'll be quite
complicated ... :)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
