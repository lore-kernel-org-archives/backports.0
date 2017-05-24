Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36019 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031324AbdEXTgv (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 24 May 2017 15:36:51 -0400
Received: by mail-qt0-f179.google.com with SMTP id f55so164265950qta.3
        for <backports@vger.kernel.org>; Wed, 24 May 2017 12:36:50 -0700 (PDT)
Subject: Re: [PATCH] patches: add patch for compat/lib-rhashtable.c
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <1495226777-11429-1-git-send-email-arend.vanspriel@broadcom.com>
 <1495608375.2665.1.camel@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <0c32b99a-63c4-476c-85f2-67e63d4219bc@broadcom.com> (sfid-20170524_213742_521387_A0486567)
Date: Wed, 24 May 2017 21:36:46 +0200
MIME-Version: 1.0
In-Reply-To: <1495608375.2665.1.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 24-05-17 08:46, Johannes Berg wrote:
> On Fri, 2017-05-19 at 21:46 +0100, Arend van Spriel wrote:
>> The file compat/lib-rhashtable.c is a copy from the backported kernel
>> source lib/rhashtable.c. This patch reverts a recent change to that
>> file, ie. commit 43ca5bc4f72e ("lib/rhashtable.c: simplify a strange
>> allocation pattern"). It introduced the function
>> gfpflags_allow_blocking()
>> introduced in 4.4 kernel and kvmalloc() introduced in 4.12-rc1.
>> Looking
>> at those functions backporting them is complicated so instead add
>> this
>> patch that reverts the change for kernel prior to 4.12.
> 
> Thanks Arend!
> 
> Why do you think backporting it is complicated though?
> 
> kvmalloc() is just kvmalloc_node(), and if we disregard the
> __vmalloc_node_flags_caller() but - since kvmalloc() doesn't care about
> node anyway - just use __vmalloc() there, it should be easy? The
> pgprot_t argument is just PAGE_KERNEL, and the other stuff doesn't
> really matter.
> 
> gfpflags_allow_blocking() is a pretty simple inline, and even if we'd
> implement it to always return false we'd get the old rhashtable
> behaviour.

I was reading commit d0164adc89f6 ("mm, page_alloc: distinguish between
being unable to sleep, unwilling to slee...") which introduced
gfpflags_allow_blocking() and did a lot more stuff. So I could not
really determine the implications of backporting
gfpflags_allow_blocking(). We can indeed probably make it work for
rhashtable easily, but will that be appropriate if some other backport
code starts using it.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
