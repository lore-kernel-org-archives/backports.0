Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:32914 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCUIUJ (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 21 Mar 2018 04:20:09 -0400
Message-ID: <1521620407.2645.14.camel@sipsolutions.net> (sfid-20180321_092011_219532_9770436D)
Subject: Re: [PATCH 00/14] backports: multiple fixes and Realtek drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Wed, 21 Mar 2018 09:20:07 +0100
In-Reply-To: <20180304225717.20890-1-hauke@hauke-m.de> (sfid-20180304_235752_107105_03B70118)
References: <20180304225717.20890-1-hauke@hauke-m.de>
         (sfid-20180304_235752_107105_03B70118)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-03-04 at 23:57 +0100, Hauke Mehrtens wrote:
> This fixes multiple smaller problems I found when using kernel 4.16-rc3 
> as a base. I am still getting many liker problems at the end, see this 
> result:
> 
I've applied all of these for now - we can sort out the timer thing
later if needed/possible.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
