Return-path: <backports-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35135 "EHLO
	mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbcBHKjJ (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Feb 2016 05:39:09 -0500
Received: by mail-yw0-f181.google.com with SMTP id g127so98617073ywf.2
        for <backports@vger.kernel.org>; Mon, 08 Feb 2016 02:39:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454785925.2166.1.camel@sipsolutions.net>
References: <56B477EB.1010308@broadcom.com>
	<1454785873.2166.0.camel@sipsolutions.net>
	<1454785925.2166.1.camel@sipsolutions.net>
Date: Mon, 8 Feb 2016 11:31:28 +0100
Message-ID: <CAF7Mx6rgy002TmFW05TQo=R4b-GFhrKd3s6Bv7j8L9wLmHpGaw@mail.gmail.com> (sfid-20160208_113911_614095_A5308C99)
Subject: Re: backports build issue with 4.5-rc2
From: Arend Van Spriel <arend.van@broadcom.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Arend van Spriel <arend@broadcom.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Feb 6, 2016 at 8:12 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Sat, 2016-02-06 at 20:11 +0100, Johannes Berg wrote:
>> On Fri, 2016-02-05 at 11:22 +0100, Arend van Spriel wrote:
>> > I created a 4.5-rc2 package and am getting build error against
>> > 3.11
>> > kernel for cfg80211 and mac80211. Does anyone has patch for this
>> > already?
>> >
>>
>> Yes, I sent it on Dec 17th to this list :)
>>

We entered a brave new world last week and basically all email history
went down the drain.

> Ah, but only the BIT_ULL(), not the wireless_nlevent_flush(). The
> latter cannot be backported, you just have to declare an inline that
> does nothing.

I created a patch. Will send it.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
