Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:59195 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760541Ab3DBHtK (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 2 Apr 2013 03:49:10 -0400
Message-ID: <1364888940.8204.1.camel@jlt4.sipsolutions.net> (sfid-20130402_094915_944850_C135D6F2)
Subject: Re: [PATCH] compat: backport kernel dma-buf implementation
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, daniel.vetter@ffwll.ch,
	airlied@redhat.com, sumit.semwal@linaro.org, rob.clark@linaro.org
Date: Tue, 02 Apr 2013 09:49:00 +0200
In-Reply-To: <1364865614-31844-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20130402_032026_500145_209762EB)
References: <1364865614-31844-1-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130402_032026_500145_209762EB)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>


> dma-buf was added via commit d15bd7ee on v3.3 but completed
> in a more sound fassion in later kernels, you should preferably
> be at v3.5 a least, so we take the latest dma-buf implementation
> and port it for usage on kernels [3.0-3.4]. We take the
> implementation as of next-20130328.

I'm curious about that approach -- I noticed it a few times already,
e.g. with CONFIG_AVERAGE, however...

If you don't mangle symbols (you don't), then wouldn't this cause
linking errors when you try to load compat.ko on say kernel 3.0?

johannes


