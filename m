Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:36655 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964971Ab3DHU5f (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Apr 2013 16:57:35 -0400
Received: by mail-la0-f45.google.com with SMTP id fn20so2324344lab.4
        for <backports@vger.kernel.org>; Mon, 08 Apr 2013 13:57:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365454577.25475.27.camel@jlt4.sipsolutions.net>
References: <1365416773-12836-9-git-send-email-thierry.escande@linux.intel.com>
 <CAB=NE6WWA4r+FyqR484ZJJm_usrCRDOjzMut-6JawNXJXUNmvw@mail.gmail.com>
 <1365449679.25475.18.camel@jlt4.sipsolutions.net> <CAB=NE6X6+M2-eUeqTv-PAJDQ_VaLwUv3n94J1YTR+4CK7YYdaw@mail.gmail.com>
 <1365450036.25475.21.camel@jlt4.sipsolutions.net> <CAB=NE6XzZvJcGb4xLZN7QKrCiYDMN0JN=uU8VR5yGUkyWS9uTw@mail.gmail.com>
 <1365454577.25475.27.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Mon, 8 Apr 2013 13:57:13 -0700
Message-ID: <CAB=NE6XARg9-6j7BJ7J_=03pnKyOTZzd-TYWJp7j7Fo-3aEJ+g@mail.gmail.com> (sfid-20130408_225739_744192_78500958)
Subject: Re: [PATCH v3 8/8] build: add NFC defconfig file
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thierry Escande <thierry.escande@linux.intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Apr 8, 2013 at 1:56 PM, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Mon, 2013-04-08 at 13:51 -0700, Luis R. Rodriguez wrote:
>
>> > So the default is just whatever the default is in the Kconfig files,
>> > which is essentially everything else turned off.
>>
>> Odd, when I tried to do media with similar defconfig I got wireless
>> building :( but its great this was the goal, I'll try again.
>
> Did you create a new tree or rm .config first?

I've corrected my habbits now, git clean -f -x -d and always new tree generated.

  Luis
