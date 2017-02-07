Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:34112 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754212AbdBGWIq (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 7 Feb 2017 17:08:46 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.88)
        (envelope-from <johannes@sipsolutions.net>)
        id 1cbDwK-0004t2-Gq
        for backports@vger.kernel.org; Tue, 07 Feb 2017 23:08:44 +0100
Message-ID: <1486505323.18071.2.camel@sipsolutions.net> (sfid-20170207_230847_719595_5A85C1BC)
Subject: Re: [RFC] backports: always use new version compare macros
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Date: Tue, 07 Feb 2017 23:08:43 +0100
In-Reply-To: <20170207220716.7538-1-johannes@sipsolutions.net> (sfid-20170207_230730_189724_EB07AC60)
References: <20170207220716.7538-1-johannes@sipsolutions.net>
         (sfid-20170207_230730_189724_EB07AC60)
Content-Type: text/plain
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

It's some churn, but I think worthwhile - any objections?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
