Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:63238 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaEBBGV (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 1 May 2014 21:06:21 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so3915119pdj.29
        for <backports@vger.kernel.org>; Thu, 01 May 2014 18:06:20 -0700 (PDT)
Date: Thu, 1 May 2014 18:06:15 -0700
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Arend van Spriel <arend@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Subject: Re: [PATCH V2] backports: lib: remove raising ExecutionError
 exception
Message-ID: <20140502010615.GC957@garbanzo.do-not-panic.com> (sfid-20140502_030623_428485_0E334B26)
References: <1398422668-11735-1-git-send-email-arend@broadcom.com>
 <1398765498-6957-1-git-send-email-arend@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398765498-6957-1-git-send-email-arend@broadcom.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 29, 2014 at 11:58:18AM +0200, Arend van Spriel wrote:
> In spatch a ExecutionError was raised, but that causes the thread
> to finish without closing the outfile and more importantly without
> putting (ret, fn) tuple on the return queue. This results in the
> threaded_spatch routine to get stuck on the ret_q.get() call. This
> patch removes raising the ExecutionError and just return the tuple.
> The non-zero return code will result in ExecutionErrorThread exception
> anyway.
> 
> Signed-off-by: Arend van Spriel <arend@broadcom.com>
> ---
> A bit late but here is the rebased version.

Thanks! Perhaps you're on an outdated tree, the latest tree is:

git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git

I rebased your patch to fit on top of that though so no need to send
another patch, thanks a lot!

  Luis
