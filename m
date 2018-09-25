Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:50118 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeIYTSL (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 25 Sep 2018 15:18:11 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1g4n6u-0005Y9-9a
        for backports@vger.kernel.org; Tue, 25 Sep 2018 15:10:40 +0200
Message-ID: <1537881030.3387.12.camel@sipsolutions.net> (sfid-20180925_151043_638811_F7DF4797)
Subject: backports test automation
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Tue, 25 Sep 2018 15:10:30 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi all,

Yesterday Luca and I thought a bit about test automation ... I haven't
really come up with the best thing so far, but here's what I'm thinking
now...

First of all, I think we're currently stretched enough that we have to
restrict ourselves to Linux mainline - we don't have resources to worry
about linux-next, and in particular linux-next could break every day
anyway due to rebases etc. so things there aren't very clear.

Another thing I should say is that I'm trying to avoid having automation
that manipulates the git tree (even adding tags) since we have no
permission model for that and kernel.org trees are supposed to be
controlled by people, afaict.


With that in mind, I think I'd like to have the following:

 * A file in the tree, that indicates the "usable kernel version".
   Currently, that would be 4.19-rc5. This lets us have *some*
   resemblance of tracking what we're doing ...

 * A script that runs every once a while (ok, this is deliberately
   vague), checking compilation against all linux.git tags that are
   newer or equal to the one in the file.
   Typically the nicest thing to do here would be to store the result in
   git notes, but like I said above, I don't want any automation to have
   (full) access to the tree, and I don't think kernel.org can split the
   permissions.
   Thus, I think this should do two things:
    - store the results locally, maybe sqlite or so, to avoid doing
      duplicate work
    - send out the results to the list, with links to logs (or
      attached? better for archiving, but could be big though)

We were also thinking about having tags, but given the git permissions
thing we can't create those automatically ... I suppose somebody could
add them after the emails?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
