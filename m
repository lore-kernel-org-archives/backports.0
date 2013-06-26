Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:62418 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab3FZQcS (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 26 Jun 2013 12:32:18 -0400
Received: by mail-la0-f46.google.com with SMTP id eg20so14038870lab.19
        for <backports@vger.kernel.org>; Wed, 26 Jun 2013 09:32:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1372147016.8372.0.camel@jlt4.sipsolutions.net>
References: <1369858414-4066-1-git-send-email-johannes@sipsolutions.net> <1372147016.8372.0.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 26 Jun 2013 09:31:56 -0700
Message-ID: <CAB=NE6UGi4Mr1syR+=Bb=ewZH00Q1irhn0eiNXUMsD34_BC=PA@mail.gmail.com> (sfid-20130626_183220_700142_97D5101E)
Subject: Re: [PATCH] backports: update output template .gitignore for kconfig move
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Jun 25, 2013 at 12:56 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Wed, 2013-05-29 at 22:13 +0200, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> I clearly forgot this during the Kconfig move, the .gitignore
>> that is in the output template directory (and used with the
>> git-tracker) needs to be updated for the kconf directory move.
>
> Luis, any reason you haven't applied this?

Sorry, nope I just I missed it, applied and pushed!

  Luis
