Return-path: <backports-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:57657 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751760AbeBSIIF (ORCPT <rfc822;backports@vger.kernel.org>);
        Mon, 19 Feb 2018 03:08:05 -0500
Message-ID: <1519027682.7832.80.camel@intel.com> (sfid-20180219_090807_148986_78C6FFBF)
Subject: Re: [PATCH 00/10] backport: updates for v4.16
From: Luciano Coelho <luciano.coelho@intel.com>
To: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org
Date: Mon, 19 Feb 2018 10:08:02 +0200
In-Reply-To: <c212f7c3-f5d6-543f-26ba-ef1c55221261@hauke-m.de>
References: <20180218132459.11011-1-luca@coelho.fi>
         <c212f7c3-f5d6-543f-26ba-ef1c55221261@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2018-02-18 at 17:11 +0100, Hauke Mehrtens wrote:
> On 02/18/2018 02:24 PM, Luca Coelho wrote:
> > From: Luca Coelho <luciano.coelho@intel.com>
> > 
> > Hi,
> > 
> > Here's a bunch of patches that we had pending in our internal
> > backports tree.  With this series at least iwlwifi can be fully
> > backported from v4.16 kernels.
> 
> Thanks for the patches they are looking good to me.
> 
> With which kernels have you tested these patches + iwlwifi?

I have compile-tested these patches with our internal iwlwifi tree
(which is essentially a backport from wireless-drivers-next and
contains iwlwifi, mac80211, cfg80211 and other small things) on 4.4,
4.14 and 4.15 (at least).  And we also have automated builds that
compile-test on these kernels: 3.10, 3.16, 3.18, 4.1, 4.4, 4.6 and 4.9.

We also have an old build machine that uses 3.8.  I have an extra patch
to hack the compilation on it, but I didn't send it upstream because we
agreed to support backports only on 3.10+.  And my patch just comments
out some stuff to make it compile...

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
