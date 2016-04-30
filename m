Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49496 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbcD3Pe4 (ORCPT <rfc822;backports@vger.kernel.org>);
	Sat, 30 Apr 2016 11:34:56 -0400
Subject: Re: compilation issues with 3.1.0
To: Emmanuel Grumbach <egrumbach@gmail.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
References: <CANUX_P3KuZRvqNY7jUfptZxFCz5Hb=7UKPAXafL_tW3P3=Ln4Q@mail.gmail.com>
From: Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <5724D09B.70607@hauke-m.de> (sfid-20160430_173500_307573_8990213B)
Date: Sat, 30 Apr 2016 17:34:51 +0200
MIME-Version: 1.0
In-Reply-To: <CANUX_P3KuZRvqNY7jUfptZxFCz5Hb=7UKPAXafL_tW3P3=Ln4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 03/14/2016 12:03 PM, Emmanuel Grumbach wrote:
> Hi,
> 
> One of my colleagues has issues with 3.1.0:
> it can't find dma_common_get_sgtable.
> 
> HAVE_GENERIC_DMA_COHERENT is set, and hence
> BPAUTO_BUILD_DMA_SHARED_HELPERS is not set.
> Because of that, dma_common_get_sgtable isn't defined.
> 
> Sorry for the stupid question, but I can't think on how
> dma_common_get_sgtable should be declared on 3.1 since it doesn't
> exist in the base kernel obviously. Maybe that helper is supposed to
> be used only in code that should be under ifdef?
> 
> thanks...
Hi,

I think there was a problem in an older backports version with that. on
kernel <= 3.5 this is needed always and on kernel >= 3.6 && <= 3.8 this
is needed when HAVE_GENERIC_DMA_COHERENT is not set.

I want to remove this completely and make the media stuff depend on
kernel 3.8, to reduce the work need for maintenance.

Hauke

--
To unsubscribe from this list: send the line "unsubscribe backports" in
