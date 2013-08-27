Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:55071 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab3H0PvS (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 27 Aug 2013 11:51:18 -0400
Received: by mail-la0-f52.google.com with SMTP id ev20so3566330lab.25
        for <backports@vger.kernel.org>; Tue, 27 Aug 2013 08:51:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1377618602.20012.10.camel@jlt4.sipsolutions.net>
References: <1377258238-3880-1-git-send-email-johannes@sipsolutions.net>
 <CAB=NE6VBhHkfFPd-kBKfscy2P=EVQ7jNevYQ5nVU2y_aFsCP-Q@mail.gmail.com> <1377618602.20012.10.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 27 Aug 2013 08:50:56 -0700
Message-ID: <CAB=NE6X8je5=box6DzH0bz2k4NWCvN9a_oZ7XSARLOGmQYiuhA@mail.gmail.com> (sfid-20130827_175119_555657_9AEA6330)
Subject: Re: [RFC] remove support for kernel 2.6.24
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Aug 27, 2013 at 8:50 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Tue, 2013-08-27 at 08:48 -0700, Luis R. Rodriguez wrote:
>> On Fri, Aug 23, 2013 at 4:43 AM, Johannes Berg
>> <johannes@sipsolutions.net> wrote:
>> > From: Johannes Berg <johannes.berg@intel.com>
>> >
>> > By requiring 2.6.25 we can get rid of quite a lot of backport work.
>> > 2.6.25 was released more than five years ago (April 2011) and wasn't
>> > a long-term kernel either, so there's little point in supporting it
>> > now.
>> >
>> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>
>> I'm fine with this, please feel free to send as patch form unless you
>> want me to just accept it as is, I'd test compile it before
>> integration into the public tree.
>
> I think it's ok, the [rfc] was more for the fact of removing it rather
> than the contents.

OK I'll apply then, thanks.

 Luis
