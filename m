Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:50317 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab3E1Su6 (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 May 2013 14:50:58 -0400
Received: by mail-wg0-f50.google.com with SMTP id k13so5573493wgh.17
        for <backports@vger.kernel.org>; Tue, 28 May 2013 11:50:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6Voe6E7hMsWfKyKETFhvQdiJ3xhECAfHePs1zRTCJh_jA@mail.gmail.com>
References: <1369318287-18024-1-git-send-email-johannes@sipsolutions.net> <CAB=NE6Voe6E7hMsWfKyKETFhvQdiJ3xhECAfHePs1zRTCJh_jA@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Tue, 28 May 2013 11:50:36 -0700
Message-ID: <CAB=NE6V1xkJz4mNO2JSeaOEsNC44yzUqsSv7BHJ8Lnx6MWuHhg@mail.gmail.com> (sfid-20130528_205100_498331_54E9CBE3)
Subject: Re: [PATCH] backport: move kconfig code to "kconf" directory
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, May 28, 2013 at 11:48 AM, Luis R. Rodriguez
<mcgrof@frijolero.org> wrote:
> On Thu, May 23, 2013 at 7:11 AM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> Having the kconfig code in a directory called "kconfig"
>> and having a file called "Kconfig" causes issues if the
>> code is ever stored on a case-insensitive filesystem.
>> Avoid these by just calling the kconfig directory kconf
>> instead.
>>
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>
> Thanks, applied and pushed!

I mistakenly applied v1, so I reverted it and later applied v2.
Applied and pushed.

  Luis
