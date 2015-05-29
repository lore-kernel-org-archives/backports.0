Return-path: <backports-owner@vger.kernel.org>
Received: from mail-vn0-f46.google.com ([209.85.216.46]:34271 "EHLO
	mail-vn0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755387AbbE2PBB (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 29 May 2015 11:01:01 -0400
MIME-Version: 1.0
In-Reply-To: <55687D72.3070904@melag.de>
References: <CAB=NE6UUTmMMB0La3OFe+hXpaZzdAwTs0QKBsTLSyrsSMFxJRg@mail.gmail.com>
	<55687D72.3070904@melag.de>
Date: Fri, 29 May 2015 17:01:00 +0200
Message-ID: <CAFLxGvz1-2sm74dmWZ4QpyC4TSubP4OHj=6Z8aVhvjqA2+WkZw@mail.gmail.com> (sfid-20150529_170110_200735_2FC1B087)
Subject: Re: Uses of Linux backports in the industry
From: Richard Weinberger <richard.weinberger@gmail.com>
To: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, May 29, 2015 at 4:53 PM, Enrico Weigelt, metux IT consult
<weigelt@melag.de> wrote:
> Am 29.05.2015 um 04:54 schrieb Luis R. Rodriguez:
> Actually, I really wonder why folks are sticking to ancient kernels on
> newer hardware.

Enterprise distribution kernels. Or "special" kernels like PREEMPT_RT.
Sometimes the vendor BSP is that horrid that a customer cannot afford
to forward port it
but wants recent stuff. So you need to backport...

-- 
Thanks,
//richard
