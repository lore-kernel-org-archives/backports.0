Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:33421 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161134AbbE2Qdu (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 29 May 2015 12:33:50 -0400
Received: by iebgx4 with SMTP id gx4so66867210ieb.0
        for <backports@vger.kernel.org>; Fri, 29 May 2015 09:33:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1432882836.2104.1.camel@sipsolutions.net>
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>
 <1432882836.2104.1.camel@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 29 May 2015 09:33:29 -0700
Message-ID: <CAB=NE6UZBmYLEEXHMTt7WJt7ZKiDAE1LUDwkf13Gb43RbwzNYw@mail.gmail.com> (sfid-20150529_183353_448544_D2845EF3)
Subject: Re: Uses of Linux backports in the industry
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, May 29, 2015 at 12:00 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> -lkml, that list is overfull anyway ...
>
> On Thu, 2015-05-28 at 19:54 -0700, Luis R. Rodriguez wrote:
>> Me and Julia are working on a paper which evaluates use of Coccinelle
>> on backports, a preliminary draft of such paper can be found on github
>> [0]. We are making some tweaks to this, one of which is covering the
>> uses of Linux backports [1] in the industry, for this we'd like to try
>> to get feedback as to where and how folks are using backports. Please
>> let me and Julia know -- or if the information is not sensitive please
>> feel free to just reply to this thread and share with others. All
>> feedback is greatly appreciated. If you are OK in having us list or
>> generalize your usage please indicate so.
>
> We've just published one of our internal git trees that is actually
> based on backports:
> https://git.kernel.org/cgit/linux/kernel/git/iwlwifi/backport-iwlwifi.git/

Great thanks! Any chance you can elaborate a bit on how its used? Some
verbiage we can use perhaps to explain, in the context from silicon
manufacturing / testing / production, etc.

 Luis
