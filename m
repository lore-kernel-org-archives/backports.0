Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:52062 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbdE3HTL (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 30 May 2017 03:19:11 -0400
Message-ID: <1496128743.3327.1.camel@sipsolutions.net> (sfid-20170530_091926_146314_E309F7AB)
Subject: Re: [PATCH] patches: add patch for compat/lib-rhashtable.c
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Tue, 30 May 2017 09:19:03 +0200
In-Reply-To: <0c32b99a-63c4-476c-85f2-67e63d4219bc@broadcom.com> (sfid-20170524_213651_376796_A77DF7BA)
References: <1495226777-11429-1-git-send-email-arend.vanspriel@broadcom.com>
         <1495608375.2665.1.camel@sipsolutions.net>
         <0c32b99a-63c4-476c-85f2-67e63d4219bc@broadcom.com>
         (sfid-20170524_213651_376796_A77DF7BA)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2017-05-24 at 21:36 +0200, Arend van Spriel wrote:

> > kvmalloc() is just kvmalloc_node(), and if we disregard the
> > __vmalloc_node_flags_caller() but - since kvmalloc() doesn't care
> > about
> > node anyway - just use __vmalloc() there, it should be easy? The
> > pgprot_t argument is just PAGE_KERNEL, and the other stuff doesn't
> > really matter.
> > 
> > gfpflags_allow_blocking() is a pretty simple inline, and even if
> > we'd
> > implement it to always return false we'd get the old rhashtable
> > behaviour.
> 
> I was reading commit d0164adc89f6 ("mm, page_alloc: distinguish
> between
> being unable to sleep, unwilling to slee...") which introduced
> gfpflags_allow_blocking() and did a lot more stuff. So I could not
> really determine the implications of backporting
> gfpflags_allow_blocking(). We can indeed probably make it work for
> rhashtable easily, but will that be appropriate if some other
> backport code starts using it.

Huh, ok, that's a good point. I guess I'll take this for now.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
