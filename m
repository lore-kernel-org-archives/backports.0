Return-path: <backports-owner@vger.kernel.org>
Received: from mail-yh0-f45.google.com ([209.85.213.45]:34843 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbaBXTGE (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 24 Feb 2014 14:06:04 -0500
Received: by mail-yh0-f45.google.com with SMTP id i57so5761074yha.18
        for <backports@vger.kernel.org>; Mon, 24 Feb 2014 11:06:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <530794B3.50502@hauke-m.de>
References: <CAEsx0Y8=+OcFi3ymv1TADr-rdjB=5WWOY=JTq6DYcN5bkR6-Dw@mail.gmail.com>
	<530794B3.50502@hauke-m.de>
Date: Mon, 24 Feb 2014 11:06:02 -0800
Message-ID: <CAEsx0Y_32TRmETdjiJ2Y5HRjSOcG=mAY0_3CBRhaVLiU3yvz3A@mail.gmail.com> (sfid-20140224_200606_876655_9DBA772B)
Subject: Re: Missing Symbol in mac80211.ko
From: Daniel Schultze <kinglag@gmail.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
To: unlisted-recipients:; (no To-header on input)
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Feb 21, 2014 at 10:02 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> On 02/14/2014 10:38 PM, Daniel Schultze wrote:
>> Developers,
>>
>> While trying to upgrade from backports v3.11.8 to v3.13.2 I ran into
>> this warning:
>>
>> WARNING: "atomic64_set"
>> [/home/dschultze/dump/ltib-trunk/rpm/BUILD/backports-3.13.2-1/net/mac80211/mac80211.ko]
>> undefined!
>>
>> I have verified that the kernel (v2.6.31, arm) does indeed have a
>> definition for this function but for some reason mac80211.ko cannot
>> see it. I was able to use the following patch as a hack to provide an
>> implementation for mac80211.ko.
>>
>
> Hi Daniel,
>
> could you try the attached patch. Some old kernel versions are missing
> the implementations for these atomic64 operations and we already added
> some of them, but atomic64_set() was missing.
>
> Hauke

Thank you Hauke,

The patch looks good. I will test it on my stuff this week.

-Dan
