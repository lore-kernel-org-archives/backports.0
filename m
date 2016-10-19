Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:34828 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938647AbcJSOOP (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 19 Oct 2016 10:14:15 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <johannes@sipsolutions.net>)
        id 1bwqpl-0003Oa-CC
        for backports@vger.kernel.org; Wed, 19 Oct 2016 15:23:05 +0200
Message-ID: <1476883383.10092.6.camel@sipsolutions.net> (sfid-20161019_161440_252869_0F97674C)
Subject: rename .local-symbols -> local-symbols?
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Wed, 19 Oct 2016 15:23:03 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Just assisted somebody on IRC who forgot to copy the file - likely
because it has a . in front and thus is hidden and isn't matched by the
usual * etc.

Should we consider renaming it during the generation? Wouldn't be a big
change, and we already ship a lot of strange files (Kconfig.*, etc.)
that people can't really do anything with, and still see.

Thoughts?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
