Return-path: <backports-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:28398 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387617AbeITWIF (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 20 Sep 2018 18:08:05 -0400
Message-ID: <e41a4ec0443c1f9afafbcc6090f48ca1bc50743f.camel@intel.com> (sfid-20180920_182843_392514_FECC55D8)
Subject: Re: [PATCH 12/14] backport: update lib-rhashtable.c
From: Luciano Coelho <luciano.coelho@intel.com>
To: backports@vger.kernel.org
Date: Thu, 20 Sep 2018 19:23:48 +0300
In-Reply-To: <20180920112842.27198-13-luca@coelho.fi>
References: <20180920112842.27198-1-luca@coelho.fi>
         <20180920112842.27198-13-luca@coelho.fi>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2018-09-20 at 14:28 +0300, Luca Coelho wrote:
> From: Luca Coelho <luciano.coelho@intel.com>
> 
> The bucket_table_alloc() function was reworked, so update the patch
> accordingly.  It's much simpler now, if !GFP_KERNEL, we just fail
> (like we used to).  This is not a problem because we only use this
> function with GFP_KERNEL anyway.
> 
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---

As Johannes pointed out, this patch is not needed, so please ignore
it. 

The reason I kept it is because I mistakenly didn't add the kvzalloc()
backport to one of our internal tree generations and had to keep the
this patch after I rebased on top of Felix's patch that removed this
entirely.

--
Cheers,
Luca.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
