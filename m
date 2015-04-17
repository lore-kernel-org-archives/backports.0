Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:34088 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbbDQSWX (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 17 Apr 2015 14:22:23 -0400
Received: by obfe9 with SMTP id e9so76503084obf.1
        for <backports@vger.kernel.org>; Fri, 17 Apr 2015 11:22:22 -0700 (PDT)
Message-ID: <55314F5C.3000907@lwfinger.net> (sfid-20150417_202225_365977_EA02E43C)
Date: Fri, 17 Apr 2015 13:22:20 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Johannes Berg <johannes@sipsolutions.net>
CC: Petr Vorel <petr.vorel@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: Possible to build-in backports modules into kernel
References: <20150417133004.GC16380@vorel-pc> <5531314D.1000706@lwfinger.net> <1429291720.1885.5.camel@sipsolutions.net> <CAB=NE6X=-PQR3=uxmHZL+Jf8muX6QmmTjKkBnKXUWDk1Bkeccw@mail.gmail.com>
In-Reply-To: <CAB=NE6X=-PQR3=uxmHZL+Jf8muX6QmmTjKkBnKXUWDk1Bkeccw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/17/2015 01:03 PM, Luis R. Rodriguez wrote:
> On Fri, Apr 17, 2015 at 10:28 AM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
>> Technically this is not true any more - the backports gentree.py script
>> now supports kernel integration where it copies the backport into
>> another kernel tree :)
>
> Indeed:
>
> https://backports.wiki.kernel.org/index.php/Documentation/integration

Just to clarify, the entire kernel will need to be built from some tree. In my 
reading of the original post, I got the impression that Petr wanted to use a 
pre-built kernel.

Larry


