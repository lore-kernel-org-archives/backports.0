Return-path: <backports-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:60550 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbaLCMbx (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 3 Dec 2014 07:31:53 -0500
Message-ID: <547F0297.6030202@users.sourceforge.net> (sfid-20141203_133156_650130_22A56365)
Date: Wed, 03 Dec 2014 13:31:19 +0100
From: SF Markus Elfring <elfring@users.sourceforge.net>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>,
	Julia Lawall <julia.lawall@lip6.fr>
CC: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Coccinelle <cocci@systeme.lip6.fr>, backports@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [patch] CodingStyle: add some more error handling guidelines
References: <20141202085950.GA13434@mwanda>
In-Reply-To: <20141202085950.GA13434@mwanda>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

> diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
> index 9f28b14..9c8a234 100644
> --- a/Documentation/CodingStyle
> +++ b/Documentation/CodingStyle
> @@ -392,7 +392,12 @@ The goto statement comes in handy when a function exits from multiple
>  locations and some common work such as cleanup has to be done.  If there is no
>  cleanup needed then just return directly.
>  
> -The rationale is:
> +Choose label names which say what the goto does or why the goto exists.  An
> +[...]  Avoid
> +using GW-BASIC names like "err1:" and "err2:".  Also don't name them after the
> +goto location like "err_kmalloc_failed:"

I find this documentation approach not safe and clear enough so far.

* How should the reference to an other programming language help in the understanding
  of the recommended naming convention for jump labels?

* To which source code place should the word "location" refer to?
  - jump source
  - jump target

Regards,
Markus
