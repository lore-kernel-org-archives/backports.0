Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35505 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbcFCS4O (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 3 Jun 2016 14:56:14 -0400
Received: by mail-wm0-f43.google.com with SMTP id a136so8861621wme.0
        for <backports@vger.kernel.org>; Fri, 03 Jun 2016 11:56:13 -0700 (PDT)
Subject: Re: [PATCH] backports: update devcoredump patch
To: Johannes Berg <johannes@sipsolutions.net>,
	backports@vger.kernel.org
References: <1464702541-20621-1-git-send-email-johannes@sipsolutions.net>
 <1464703413.3076.31.camel@sipsolutions.net>
 <67751df1-34ee-6e9f-3dd5-7b9a8400f25e@broadcom.com>
 <1464979700.2224.7.camel@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5751D2C9.6080301@broadcom.com> (sfid-20160603_205616_410732_5FA3B4F9)
Date: Fri, 3 Jun 2016 20:56:09 +0200
MIME-Version: 1.0
In-Reply-To: <1464979700.2224.7.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 03-06-16 20:48, Johannes Berg wrote:
> 
>> You already have something that is working? Otherwise, I have to dive
>> in to fix my nightly builds.
>>
> 
> Don't know if you got my other mail - at least the list seems to have
> rejected it.

I think I got it around 11am.

> No, I don't really - this one was giving compiler warnings. I *think*
> that was because it simply didn't work, but I'm not entirely sure.

I guess I could take your patch as I only need it to build but have to
remove -Werror option for that. My nightly testing does not invoke the
devcoredump explicitly. It will when our 802.11 psm hangs.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
