Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:42800 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756120AbdJLWFK (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 12 Oct 2017 18:05:10 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <johannes@sipsolutions.net>)
        id 1e2lbI-0007LD-Km
        for backports@vger.kernel.org; Fri, 13 Oct 2017 00:05:08 +0200
Message-ID: <1507845908.1998.78.camel@sipsolutions.net> (sfid-20171013_000514_660535_9D47C209)
Subject: Re: [PATCH 5/5] backports: add signature verification code
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Fri, 13 Oct 2017 00:05:08 +0200
In-Reply-To: <1507844540.1998.77.camel@sipsolutions.net> (sfid-20171012_234223_926621_6E791A9A)
References: <20171012210025.7490-1-johannes@sipsolutions.net>
         <20171012210025.7490-5-johannes@sipsolutions.net>
         (sfid-20171012_230042_844657_1EE6AD34) <1507844540.1998.77.camel@sipsolutions.net>
         (sfid-20171012_234223_926621_6E791A9A)
Content-Type: text/plain
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Might be that this leaks memory - will need to investigate.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
