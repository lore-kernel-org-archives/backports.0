Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:52660 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758059AbdJMONr (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 10:13:47 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <johannes@sipsolutions.net>)
        id 1e30ig-00005B-5i
        for backports@vger.kernel.org; Fri, 13 Oct 2017 16:13:46 +0200
Message-ID: <1507904025.2551.55.camel@sipsolutions.net> (sfid-20171013_161439_285435_2D974CBF)
Subject: 4.14-rc4, pushed out all changes
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Fri, 13 Oct 2017 16:13:45 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

After testing that all the changes work on 4.14-rc4 against 3.10+, I've
pushed all that out and tagged v4.14-rc4-1 as well. Not sure anyone
needs a release, but I figured the tag was good to have.

It should also work on mac80211-next, though I haven't revalidated that
after the very last change to make netdev_upper_dev_link() support both
versions. It does work, and the signature validation does work (and
reject wrong signatures) :-)

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
