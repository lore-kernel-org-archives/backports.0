Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:39548 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751738AbdCNNtN (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 14 Mar 2017 09:49:13 -0400
Message-ID: <1489499345.10872.2.camel@sipsolutions.net> (sfid-20170314_144954_178430_26599BD6)
Subject: Re: [PATCH 3/4] backports: introduce new definition for
 DECLARE_EWMA macro
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Tue, 14 Mar 2017 14:49:05 +0100
In-Reply-To: <d639368b-b887-cd0b-9c51-b76f127407f4@broadcom.com> (sfid-20170310_105333_837576_BD83F099)
References: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
         <1489064253-3652-4-git-send-email-arend.vanspriel@broadcom.com>
         <1489127774.3038.1.camel@sipsolutions.net>
         <d639368b-b887-cd0b-9c51-b76f127407f4@broadcom.com>
         (sfid-20170310_105333_837576_BD83F099)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> That will work as long a linux/average.h only contains DECLARE_EWMA
> and that is all the backported code cares about. So for now the copy-
> list approach will work. Maybe add a comment in the copy-list
> documenting the approach.
> 
I think it's highly unlikely it'll ever contain anything else.

Will you respin this, or did you want me to handle it?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
