Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:41194 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab3FFEqr (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 6 Jun 2013 00:46:47 -0400
Received: by mail-lb0-f171.google.com with SMTP id v5so2635915lbc.2
        for <backports@vger.kernel.org>; Wed, 05 Jun 2013 21:46:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370348512-15068-1-git-send-email-johannes@sipsolutions.net>
References: <1370348512-15068-1-git-send-email-johannes@sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Wed, 5 Jun 2013 21:46:25 -0700
Message-ID: <CAB=NE6VF+3jYea3T6iDJD7aBHCkMnt7=TTi3bXjHQ-twMtojWg@mail.gmail.com> (sfid-20130606_064649_075621_879A86F0)
Subject: Re: [PATCH] gentree/git-tracker: make python 3 compatible
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>,
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Jun 4, 2013 at 5:21 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Make the python scripting compatible with python 3
> (as tested with python 3.3). The patch library was
> a bit tricky.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Thanks, applied and pushed!

  Luis
