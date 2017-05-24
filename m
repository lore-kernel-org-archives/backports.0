Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:49324 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934406AbdEXGqS (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 24 May 2017 02:46:18 -0400
Message-ID: <1495608375.2665.1.camel@sipsolutions.net> (sfid-20170524_084622_671320_F3C6A2B4)
Subject: Re: [PATCH] patches: add patch for compat/lib-rhashtable.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Wed, 24 May 2017 08:46:15 +0200
In-Reply-To: <1495226777-11429-1-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170519_224637_347450_368DFBBA)
References: <1495226777-11429-1-git-send-email-arend.vanspriel@broadcom.com>
         (sfid-20170519_224637_347450_368DFBBA)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2017-05-19 at 21:46 +0100, Arend van Spriel wrote:
> The file compat/lib-rhashtable.c is a copy from the backported kernel
> source lib/rhashtable.c. This patch reverts a recent change to that
> file, ie. commit 43ca5bc4f72e ("lib/rhashtable.c: simplify a strange
> allocation pattern"). It introduced the function
> gfpflags_allow_blocking()
> introduced in 4.4 kernel and kvmalloc() introduced in 4.12-rc1.
> Looking
> at those functions backporting them is complicated so instead add
> this
> patch that reverts the change for kernel prior to 4.12.

Thanks Arend!

Why do you think backporting it is complicated though?

kvmalloc() is just kvmalloc_node(), and if we disregard the
__vmalloc_node_flags_caller() but - since kvmalloc() doesn't care about
node anyway - just use __vmalloc() there, it should be easy? The
pgprot_t argument is just PAGE_KERNEL, and the other stuff doesn't
really matter.

gfpflags_allow_blocking() is a pretty simple inline, and even if we'd
implement it to always return false we'd get the old rhashtable
behaviour.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
