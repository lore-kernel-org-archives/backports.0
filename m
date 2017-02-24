Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:45480 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbdBXMaw (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 24 Feb 2017 07:30:52 -0500
Message-ID: <1487939443.2540.19.camel@sipsolutions.net> (sfid-20170224_133054_113403_81FF49D9)
Subject: Re: [PATCH] backports: add definitions S32_MAX and S32_MIN
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Fri, 24 Feb 2017 13:30:43 +0100
In-Reply-To: <c5eb014a-b922-f825-0319-af46d4864ab4@broadcom.com> (sfid-20170223_092759_188265_A4FEF280)
References: <1487801925-22641-1-git-send-email-arend.vanspriel@broadcom.com>
         <1487836149.18380.0.camel@sipsolutions.net>
         <c5eb014a-b922-f825-0319-af46d4864ab4@broadcom.com>
         (sfid-20170223_092759_188265_A4FEF280)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> I create a package nightly for our internal tree and wireless-testing
> and build for couple of target kernels to run some wifi tests on
> target systems. So I tend to hit issues pretty soon. Not covering all
> target kernels though.

Ok, that's nice. I'm torn between doing something that runs on our
existing infrastructure (easy, but internal) or building some kind of
infrastructure, likely on the build box we have from the LF... that's
harder but accessible to people other than me.

Or are there any alternatives? Perhaps if I put the scripts upstream
then it doesn't matter that I might actually be running it on our
internal infrastructure, since anyone can just take the scripts and run
them?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
