Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:52068 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727865AbeIXP1f (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 24 Sep 2018 11:27:35 -0400
Message-ID: <35ba5fc4e8af0c2240ba3bc871acbbce70d5c501.camel@coelho.fi> (sfid-20180924_112629_223626_48E61520)
From: Luca Coelho <luca@coelho.fi>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Mon, 24 Sep 2018 12:26:24 +0300
In-Reply-To: <60c22894-4313-fb34-598c-208b8e78b830@hauke-m.de>
References: <20180920112842.27198-1-luca@coelho.fi>
         <60c22894-4313-fb34-598c-208b8e78b830@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 00/14] backport: updates for 4.19
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-09-23 at 16:14 +0200, Hauke Mehrtens wrote:
> On 09/20/2018 01:28 PM, Luca Coelho wrote:
> > From: Luca Coelho <luciano.coelho@intel.com>
> > 
> > Hi,
> > 
> > I finally found the time to go through the backports I had made for
> > our internal tree and send them upstream.
> 
> Thank you for the patches. I had some comments, but in general they
> look good.

Than you too for yours! :)


> > We've compile tested this on some old kernels, but the list is far
> > from being comprehensive.
> 
> Which kernel versions do you support internally?
> 
> I tested this with some kernel versions and saw many problems with <
> 4.0 but I do not really care about them any more. The problems where
> mostly not caused by these patches.

I don't really remember... I should write them down next time.  But at
least 4.4, 3.18... 3.14 IIRC.  We have many build machines with
different kernels and I only really notice them when something fails.

--
Cheers,
Luca.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
