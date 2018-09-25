Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:57420 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbeIZBdR (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 25 Sep 2018 21:33:17 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g4swO-0003l7-Vz
        for backports@vger.kernel.org; Tue, 25 Sep 2018 21:24:13 +0200
Message-ID: <1537903442.3387.19.camel@sipsolutions.net> (sfid-20180925_212417_359581_8DED8580)
Subject: Re: backports test automation
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Tue, 25 Sep 2018 21:24:02 +0200
In-Reply-To: <1537881030.3387.12.camel@sipsolutions.net> (sfid-20180925_151043_638811_F7DF4797)
References: <1537881030.3387.12.camel@sipsolutions.net>
         (sfid-20180925_151043_638811_F7DF4797)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2018-09-25 at 15:10 +0200, Johannes Berg wrote:
> 
> Another thing I should say is that I'm trying to avoid having automation
> that manipulates the git tree (even adding tags) since we have no
> permission model for that and kernel.org trees are supposed to be
> controlled by people, afaict.

Konstantin informed me that he *does* have a way to do per-ref
permissions, so it sounds like in theory we could add a notes ref for
some automation to write test things etc. to. I don't think gitolite
supports a permission check for "just a tag", so I think that's still
out.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
