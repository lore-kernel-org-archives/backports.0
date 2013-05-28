Return-path: <backports-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:39625 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856Ab3E1T44 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 15:56:56 -0400
Received: by mail-oa0-f51.google.com with SMTP id f4so10531966oah.38
        for <backports@vger.kernel.org>; Tue, 28 May 2013 12:56:56 -0700 (PDT)
Message-ID: <51A50C06.8060503@lwfinger.net> (sfid-20130528_215658_725355_DE2EB11D)
Date: Tue, 28 May 2013 14:56:54 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
CC: "Luis R. Rodriguez" <mcgrof@frijolero.org>,
	backports@vger.kernel.org
Subject: Re: Problem with backports git repo
References: <51A502AD.1060104@lwfinger.net>  (sfid-20130528_211707_085177_DE2DD9E0) <1369769122.8548.7.camel@jlt4.sipsolutions.net>  (sfid-20130528_212531_921012_9500F06E) <1369770189.8548.20.camel@jlt4.sipsolutions.net>
In-Reply-To: <1369770189.8548.20.camel@jlt4.sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 05/28/2013 02:43 PM, Johannes Berg wrote:
> On Tue, 2013-05-28 at 21:25 +0200, Johannes Berg wrote:
>> Hi Larry,
>>
>>> I just used 'git clone' to get a fresh copy of the repo. When I try 'make
>>> menuconfig', I get the following error:
>>>
>>> finger@larrylap:~/backports/backport> make menuconfig
>>
>> The docs haven't been updated, but this is just the skeleton, you're not
>> supposed to run anything in there. Go to the top-level first, and run
>
> Oh, n/m me, it seems this was just an accidental resend of your previous
> mail?

It was a resend, but I did not include the backports ML and I got no response.

Thanks for your input. I was able to build just file.

Larry


