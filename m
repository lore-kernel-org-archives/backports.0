Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:43655 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935970Ab3DJUNF (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 10 Apr 2013 16:13:05 -0400
Received: by mail-wg0-f43.google.com with SMTP id f12so944392wgh.22
        for <backports@vger.kernel.org>; Wed, 10 Apr 2013 13:13:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365601698.4235.19.camel@jlt4.sipsolutions.net>
References: <1365593728-5720-1-git-send-email-mcgrof@do-not-panic.com>
 <1365593728-5720-19-git-send-email-mcgrof@do-not-panic.com> <1365601698.4235.19.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 10 Apr 2013 13:12:43 -0700
Message-ID: <CAB=NE6WNrOdLYzu_Rf=RPCxPX5Oo1bK2CexnUc7c39KzsuXBQQ@mail.gmail.com> (sfid-20130410_221307_693160_967C28F1)
Subject: Re: [PATCH 18/18] backports: add update-initramfs support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, Apr 10, 2013 at 6:48 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2013-04-10 at 04:35 -0700, Luis R. Rodriguez wrote:
>
>> +KLIB=1
>
> pretty sure that should be "$1" or at least just $1 ?

Fuck sorry yes.

  Luis
