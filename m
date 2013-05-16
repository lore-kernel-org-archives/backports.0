Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:46935 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754664Ab3EPD5U (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 15 May 2013 23:57:20 -0400
Received: by mail-lb0-f173.google.com with SMTP id t10so2617662lbi.4
        for <backports@vger.kernel.org>; Wed, 15 May 2013 20:57:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6UiZPP02y126Qxc5c7q1wFer0_9cZLFP_QCQo_Z6uGJmQ@mail.gmail.com>
References: <1368440675-23190-1-git-send-email-mcgrof@do-not-panic.com>
 <1368603799.8359.5.camel@jlt4.sipsolutions.net> <CAB=NE6UiZPP02y126Qxc5c7q1wFer0_9cZLFP_QCQo_Z6uGJmQ@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 15 May 2013 20:56:58 -0700
Message-ID: <CAB=NE6Ut5CdpistLecYnbzK-t+Rymw-Gzhj=DdhYEcm8DGPBYw@mail.gmail.com> (sfid-20130516_055724_695310_3AD40D9F)
Subject: Re: [PATCH 0/3] backports: take up up to next-20130426
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, May 15, 2013 at 8:45 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> while nouveau fails and uses the later.

Actually I see now drivers that use either work so this seems to be
nouveau specific.

  Luis
