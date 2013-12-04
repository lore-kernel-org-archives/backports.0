Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:48245 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3LDRS0 (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 4 Dec 2013 12:18:26 -0500
Date: Wed, 4 Dec 2013 09:18:22 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Matt Walker <matt.g.d.walker@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, backports@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/input/mouse: add support for newer elantech
 touchpads (released ca. August 2013);
Message-ID: <20131204171820.GE8838@core.coreip.homeip.net> (sfid-20131204_181829_378503_4A028C70)
References: <CA+X2d=Ar93dXujLt8xNeh9tNmEX9HU+VgVSqWsdGtKLvk=Rdyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+X2d=Ar93dXujLt8xNeh9tNmEX9HU+VgVSqWsdGtKLvk=Rdyg@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Dec 03, 2013 at 12:42:34PM -0500, Matt Walker wrote:
> From: Matt Walker <matt.g.d.walker@gmail.com>
> 
> Added detection for newer Elantech touchpads, so that kernel doesn't
> fall-back to default PS/2 driver. Supports touchpads released after
> ~August 2013.  Fixes bug:
> https://lists.launchpad.net/kernel-packages/msg18481.html
> 
> Tested-by: Matt Walker <matt.g.d.walker@gmail.com> on an Acer Aspire S7-392-6302

That should be "Signed-off-by: ...". Could you please add your sign off
and resend so I can apply?

Thanks.

-- 
Dmitry
