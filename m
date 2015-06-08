Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35252 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbbFHUnj (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Jun 2015 16:43:39 -0400
Received: by iesa3 with SMTP id a3so1465863ies.2
        for <backports@vger.kernel.org>; Mon, 08 Jun 2015 13:43:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1433795473.10172.3.camel@sipsolutions.net>
References: <1433793702-21322-1-git-send-email-mcgrof@do-not-panic.com> <1433795473.10172.3.camel@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Mon, 8 Jun 2015 13:43:17 -0700
Message-ID: <CAB=NE6W68eikvWE+YKKSUC3_S_pTLY-cJq5hGeRkKp2mx9dRMA@mail.gmail.com> (sfid-20150608_224341_625171_CFB7036C)
Subject: Re: [PATCH] pycocci: sync pycocci with Coccinelle upstream
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	"cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Jun 8, 2015 at 1:31 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Mon, 2015-06-08 at 13:01 -0700, Luis R. Rodriguez wrote:
>> pycocci is now part of Coccinelle upstream. Coccinelle has a plan
>> to actually extend multithreaded support to enable us to not have
>> to script this out. Until then pyccoci is used and I'll sync both
>> solutions up as there is a bit of latency between a coccinelle release
>> and what we may need from pycocci.
>
> If it's upstream, do they ship it? If so it wouldn't be needed that we
> have a copy, it seems?

Indeed, Coccinelle 1.0 has pycocci except for this last patch I just
mentioned. I think it is important enough for our sake that the errors
are reported well, I think its fair to drop this in backports once
Coccinelle 1.1 is released and we can reasonably expect users to have
it installed.

 Luis
