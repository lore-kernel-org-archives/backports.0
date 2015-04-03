Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:39432 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751430AbbDCVgk (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 3 Apr 2015 17:36:40 -0400
Message-ID: <551F07E5.4000204@hauke-m.de> (sfid-20150403_233642_295195_D66B43D2)
Date: Fri, 03 Apr 2015 23:36:37 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Luca Coelho <luca@coelho.fi>, backports@vger.kernel.org
CC: johannes@sipsolutions.net, arend@broadcom.com, mcgrof@suse.com
Subject: Re: [PATCH] backports: add support for 4.x kernels
References: <1424956829.1885.27.camel@sipsolutions.net> <1425460010-16275-1-git-send-email-luca@coelho.fi>
In-Reply-To: <1425460010-16275-1-git-send-email-luca@coelho.fi>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 03/04/2015 10:06 AM, Luca Coelho wrote:
> From: Luciano Coelho <luciano.coelho@intel.com>
> 
> Adjust the kernel version parsing and list of backport files
> generation for 4.x kernels.
> 
> Signed-off-by: Luciano Coelho <luciano.coelho@intel.com>
> ---
> I was working on the same thing and Johannes told me that Arend had a
> similar patch.  Maybe this one can be used?
> 
>  backport/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thank you for the patch it was applied to backports.

Hauke
