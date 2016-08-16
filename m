Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:39308 "EHLO
	farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751266AbcHPTSA (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 16 Aug 2016 15:18:00 -0400
Message-ID: <1471375075.9777.590.camel@coelho.fi> (sfid-20160816_211802_145193_72074C1F)
From: Luca Coelho <luca@coelho.fi>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>, hauke@hauke-m.de
Cc: backports@vger.kernel.org
Date: Tue, 16 Aug 2016 22:17:55 +0300
In-Reply-To: <d6080ced-2956-5b96-9d03-31be637ac47b@broadcom.com>
References: <1471339244-12868-1-git-send-email-luca@coelho.fi>
	 <d6080ced-2956-5b96-9d03-31be637ac47b@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backports: genetlink: define GENL_UNS_ADMIN_PERM as
 GENL_ADMIN_PERM
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2016-08-16 at 21:12 +0200, Arend Van Spriel wrote:
> On 16-8-2016 11:20, Luca Coelho wrote:
> > 
> > From: Luca Coelho <luciano.coelho@intel.com>
> > 
> > Older kernels don't have support for GENL_UNS_ADMIN_PERM.  So, if
> > it
> > is not defined, use the previous GENL_ADMIN_PERM permission
> > instead.
> 
> I posted a patch for this May 17.

Argh, this was again from my "deafness" window.  I googled and only
found your v1, which was NAKed by Johannes.  Missed v2, sorry.


> > 
> > Change-Id: I4c845de0d5b326aff8400df22a23595ef9cd12aa
> 
> and this is gerrit noise :-)

Gr.  And now I am growling. :P

About your patch, why didn't you add to uapi/linux/ as I did? I saw you
mentioned some inclusion problems, but I didn't run into any.

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
