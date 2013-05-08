Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:45967 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3EHAUB (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 7 May 2013 20:20:01 -0400
Received: by mail-lb0-f175.google.com with SMTP id w20so1337864lbh.20
        for <backports@vger.kernel.org>; Tue, 07 May 2013 17:19:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6WZoKOg2dt8W_Zv5syZyapGf3152x0k_PZyrp=UtYuAZA@mail.gmail.com>
References: <1367971269-25440-1-git-send-email-mcgrof@do-not-panic.com>
 <1367971269-25440-2-git-send-email-mcgrof@do-not-panic.com>
 <CAB=NE6Wi5B=OSp2BCZr6CqN7WdbBEN699W1KtCLqHoHjCxvknA@mail.gmail.com> <CAB=NE6WZoKOg2dt8W_Zv5syZyapGf3152x0k_PZyrp=UtYuAZA@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 7 May 2013 17:19:39 -0700
Message-ID: <CAB=NE6UD0h0VLTjuHDzuFuE6Z-pVpq2Aaof5KFHBds-iFfTAHA@mail.gmail.com> (sfid-20130508_022004_067878_4FE7E57F)
Subject: Re: [PATCH 2/2] backports: add pm patch for rtl8188ee
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, May 7, 2013 at 5:02 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> On Tue, May 7, 2013 at 5:02 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
>> On Tue, May 7, 2013 at 5:01 PM, Luis R. Rodriguez
>> <mcgrof@do-not-panic.com> wrote:
>>> 15  2.6.38              [  FAIL  ]
>>
>> I forgot to mention this was a permission issue on my end so I'm sure
>> it was a fluke.
>
> In other words, I think this should have passed so please consider merging.

And to be technically correct this patch should be merged first.

  Luis
