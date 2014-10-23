Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:32984 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754284AbaJWUno (ORCPT <rfc822;backports@vger.kernel.org>);
	Thu, 23 Oct 2014 16:43:44 -0400
Message-ID: <54496879.3030406@hauke-m.de> (sfid-20141023_224347_584217_E7C44F86)
Date: Thu, 23 Oct 2014 22:43:37 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
CC: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: Tag to help count manual patch fixes
References: <CAB=NE6V=-Ef08L+7fA66a3DdZUa-WYUKBnhiuHE0bWH2VhDPbA@mail.gmail.com>
In-Reply-To: <CAB=NE6V=-Ef08L+7fA66a3DdZUa-WYUKBnhiuHE0bWH2VhDPbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10/23/2014 10:26 PM, Luis R. Rodriguez wrote:
> I propose we we a tag to help count the amount of times we actually
> have to do work in between release to fix patch manually. Not sure
> what to use though, any ideas?
> 
> Manually-fixed ?
> 
> The use case? Well it would help us let keep count for starters and
> see if things increase / decrease over time. This can also be used I
> suppose by some tool to extract these patches and perhaps in the
> future see if there's way to address these sorts of patches
> automatically somehow.
> 
> Are the possible gains worth it?
> 
>   Luis

>From my experience making the patches apply isn't a big problem any
more. All the patches that broke often in the early days are now using
coccinelle or are removed because they were only needed for the older
kernel versions.

For the last releases I needed most of the time for backporting new some
functions which are newly used and for understanding why some stuff
breaks with some older kernels.

Hauke
