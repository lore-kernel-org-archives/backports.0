Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:64401 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932961Ab3DBTEr (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 2 Apr 2013 15:04:47 -0400
Received: by mail-lb0-f178.google.com with SMTP id q13so828412lbi.9
        for <backports@vger.kernel.org>; Tue, 02 Apr 2013 12:04:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364923241.8204.15.camel@jlt4.sipsolutions.net>
References: <1364908781.8204.14.camel@jlt4.sipsolutions.net> <1364923241.8204.15.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Tue, 2 Apr 2013 12:04:25 -0700
Message-ID: <CAB=NE6U0Y5muk84EAvzaLARPOQ__0prgT1Fsdcb2AMBBgDS+FA@mail.gmail.com> (sfid-20130402_210454_285515_27A9362B)
Subject: Re: [ANN] new backports project
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 2, 2013 at 10:20 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
>
>>  * Redhat kernel backport support -- this should be fairly easy
>
> I addressed this, but I'm unsure of it and don't have a way to test it,
> so any testing would be appreciated (as it is in general, of course)

FWIW the LINUX_BACKPORT() stuff replaced RHEL specific changes, that
is, LINUX_BACKPORT() stuff extended the work that folks used to add
RHEL support making it more generic. This helps try to avoid clashes
with *any* Linux distribution trying to cherry pick features from the
kernel, so long as they don't use the same prefix for exported
symbols. I wonder if there's any more need for RHEL / SUSE specific
kernel checks now after LINUX_BACKPORT() stuff.

  Luis
