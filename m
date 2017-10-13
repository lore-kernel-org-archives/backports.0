Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49642 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdJMKX5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 06:23:57 -0400
Message-ID: <1507890235.2551.44.camel@sipsolutions.net> (sfid-20171013_122358_642256_19763CC9)
Subject: Re: [PATCH 5/5] backports: add signature verification code
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Date: Fri, 13 Oct 2017 12:23:55 +0200
In-Reply-To: <898fb3d5-44bf-e176-ff29-40c4b5918c1f@broadcom.com> (sfid-20171013_122231_882738_F06E9A66)
References: <20171012210025.7490-1-johannes@sipsolutions.net>
         <20171012210025.7490-5-johannes@sipsolutions.net>
         <ce53b46c-e75c-3a37-606b-e40be0ae063f@broadcom.com>
         <1507885767.2551.37.camel@sipsolutions.net>
         <2f943e21-1a4f-0863-dc7b-93640f9c4149@broadcom.com>
         <1507887514.2551.40.camel@sipsolutions.net>
         <1507887597.2551.41.camel@sipsolutions.net>
         <898fb3d5-44bf-e176-ff29-40c4b5918c1f@broadcom.com>
         (sfid-20171013_122231_882738_F06E9A66)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> It is probably better to keep it like that and leave the mbedtls
> code unmodified as much as possible.

Sure, I just sent a modification to reduce stack usage, but yeah, I
don't really want to deal with cleaning that up in any way.

> So this stuff is going to be needed for mac80211. Also for the 
> regulatory db loading you sent out I guess.

Only the regulatory db signature verification.

I don't see that we'd want to use it in mac80211, starting from kernel
3.10 you have all the needed crypto stuff for that, so just enable it.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
