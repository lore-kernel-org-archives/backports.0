Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:44589 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623AbaDFWTy (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 6 Apr 2014 18:19:54 -0400
Received: by mail-lb0-f169.google.com with SMTP id q8so4100582lbi.14
        for <backports@vger.kernel.org>; Sun, 06 Apr 2014 15:19:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1396701662-15165-22-git-send-email-mcgrof@do-not-panic.com>
References: <1396701662-15165-1-git-send-email-mcgrof@do-not-panic.com> <1396701662-15165-22-git-send-email-mcgrof@do-not-panic.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Sun, 6 Apr 2014 15:19:32 -0700
Message-ID: <CAB=NE6XKDDhZAJgHEZFH7J6tSAw9LpOoHc5dwYvow08fUiZfMA@mail.gmail.com> (sfid-20140407_002009_659021_BAB20196)
Subject: Re: [PATCH 21/27] backports: backport net_get_random_once()
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Alexander Smirnov <alex.bluesman.smirnov@gmail.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-zigbee-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Apr 5, 2014 at 5:40 AM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> +#define net_get_random_once LINUX_BACKPORT(net_get_random_once)
> +#define net_get_random_once(buf, nbytes)                               \

I had to remove the first define as its a double define, that means
unless we use a static inline we'll have a clash with folks who decide
to backport this on their own as well. I'd rather wait until we hit a
clash to see who backported this, the static keys and if differently
from our solution ;)

  Luis
