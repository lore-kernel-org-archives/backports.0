Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:38358 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750777AbdCJGgR (ORCPT <rfc822;backports@vger.kernel.org>);
        Fri, 10 Mar 2017 01:36:17 -0500
Message-ID: <1489127774.3038.1.camel@sipsolutions.net> (sfid-20170310_073618_166542_DA07A900)
Subject: Re: [PATCH 3/4] backports: introduce new definition for
 DECLARE_EWMA macro
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Fri, 10 Mar 2017 07:36:14 +0100
In-Reply-To: <1489064253-3652-4-git-send-email-arend.vanspriel@broadcom.com> (sfid-20170309_140611_189597_39E350D6)
References: <1489064253-3652-1-git-send-email-arend.vanspriel@broadcom.com>
         <1489064253-3652-4-git-send-email-arend.vanspriel@broadcom.com>
         (sfid-20170309_140611_189597_39E350D6)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2017-03-09 at 12:57 +0000, Arend van Spriel wrote:
> Since commit eb1e011a1474 ("average: change to declare precision,
> not factor") the definition of DECLARE_EWMA has changed so we
> need a backport for the new macro as it differs. Changing the
> strategy by checking the kernel version and #undef the macro to
> be sure we do not run into macro redefinition issue.

Good one. However, why not just add this file to copy-list and be done
with it? That way, the original one from the kernel will never be
included at all and we'll always have the right version. Not that I
think we'll change it much, but why not make it easier?

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
