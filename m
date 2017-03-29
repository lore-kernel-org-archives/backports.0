Return-path: <backports-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34472 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbdC2JKf (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 29 Mar 2017 05:10:35 -0400
Received: by mail-it0-f68.google.com with SMTP id e75so8617208itd.1
        for <backports@vger.kernel.org>; Wed, 29 Mar 2017 02:10:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490777532.7948.15.camel@sipsolutions.net>
References: <CAN+BLYH=tkxSxJSv995+n83Zon0kqweNb6X8nWeKuLFtCepSmQ@mail.gmail.com>
 <1490777532.7948.15.camel@sipsolutions.net>
From: =?UTF-8?B?5ZCz6YeN5q+F?= <uranus0206@gmail.com>
Date: Wed, 29 Mar 2017 17:10:12 +0800
Message-ID: <CAN+BLYE43ZAGg=Ke0LkeZeWLk5412Ui8ZLMbT5m51O-rsKQ4Cw@mail.gmail.com> (sfid-20170329_111131_859041_383C84C8)
Subject: Re: Question of backports
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Johannes:
Thanks for your help. And i am successfully port to linux 4.2.

BR Chung-I

On Wed, Mar 29, 2017 at 4:52 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Fri, 2017-03-24 at 18:36 +0800, =E5=90=B3=E9=87=8D=E6=AF=85 wrote:
>> Hi:
>> I am confuse with backports' parameter. First i found the mail list
>> of
>> http://lists.infradead.org/pipermail/ath10k/2017-March/009458.html
>> And i follow the attachment to patch backports' git.
>> I am success full create the backports-output, but some parameters
>> confused me.
>> The parameter "--git-revision next-20170310". Is it says i am using
>> tag next-20170310 of source linux-next?
>> Currently my git of backports is point at master.
>> When i use the command in maillist to generate backport-output.
>> What target of kernel version am i going to backport to ?
>> kernel of tag next-20170310(linux-next) to which kernel version?
>> If my backports git is point at tag v4.4.2 and --git-version is point
>> at v4.11. Can i say i am backporting from 4.11 to 4.4.2?
>
> --git-revision is for the kernel source you want to use.
>
> backports has its own tagging/branching, intended to match the *source*
> kernel.
>
> the *target* kernel, the one you compile against, shouldn't matter at
> all and support (roughly) 3.0-current.
>
> johannes



--=20
Wu Chung-I
--
To unsubscribe from this list: send the line "unsubscribe backports" in
