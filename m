Return-path: <backports-owner@vger.kernel.org>
Received: from mail2.candelatech.com ([208.74.158.173]:43468 "EHLO
        mail2.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbeGPUpy (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 16 Jul 2018 16:45:54 -0400
Subject: Re: What distro can run recent backports?
To: Johannes Berg <johannes@sipsolutions.net>,
        backports@vger.kernel.org
References: <1ea772b3-612a-aa1e-8088-069864dc0920@candelatech.com>
 <1531770284.3265.0.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Message-ID: <2823e04b-0434-42eb-12be-4e7a8e2d35b8@candelatech.com> (sfid-20180716_221657_132797_5B3F9974)
Date: Mon, 16 Jul 2018 13:16:52 -0700
MIME-Version: 1.0
In-Reply-To: <1531770284.3265.0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07/16/2018 12:44 PM, Johannes Berg wrote:
> On Mon, 2018-07-16 at 10:49 -0700, Ben Greear wrote:
>> Hello,
>>
>> I'm trying to make backports work with my 4.16-ct kernel.  I tried Fedora-27, but it has
>> some bug relate to spatch so it cannot run there.
>
> I think it's an upstream spatch bug. You could use an older version and
> revert the recent genl_const patch.
>
> I'm on F27 but haven't gotten it to work recently (and am out for the
> next ~4 weeks)
>
> johannes

Thanks, I did try reverting the patch, and that got me farther, and after
more hacking on some incompatible patches and some Kconfig issues,
I got it to start building, and then it blew up all over the place.

This patch is part of what I used, by the way:

https://www.spinics.net/lists/backports/msg04115.html

It seems like a fragile house of cards, and I think maybe I should just
go back to manually copying files around and then fixing the incompatibilities.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

--
To unsubscribe from this list: send the line "unsubscribe backports" in
