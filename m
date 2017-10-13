Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:49140 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbdJMJlD (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 13 Oct 2017 05:41:03 -0400
Message-ID: <1507887661.2551.42.camel@sipsolutions.net> (sfid-20171013_114105_108065_2F7508A2)
Subject: Re: [PATCH] backports: no longer support kernels < 3.10
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Date: Fri, 13 Oct 2017 11:41:01 +0200
In-Reply-To: <97250f48-ae56-e53a-fb57-1cbfc6470b77@broadcom.com> (sfid-20171013_114006_373388_CC6C091D)
References: <20171013092641.9113-1-johannes@sipsolutions.net>
         <97250f48-ae56-e53a-fb57-1cbfc6470b77@broadcom.com>
         (sfid-20171013_114006_373388_CC6C091D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-10-13 at 11:40 +0200, Arend van Spriel wrote:
> 
> > @@ -52,7 +54,7 @@ class backport_kernel_updater:
> >   
> >       @classmethod
> >       def _get_ubuntu_ppa_mainline_kernels(cls):
> > -        base = 'http://kernel.ubuntu.com/~kernel-ppa/mainline/'
> > +        base = KPATH
> 
> I guess this is not directly related to this change, right?

Oh, oops, yeah. I just thought I wanted to use the existing variable,
I'll split it out to another patch.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
