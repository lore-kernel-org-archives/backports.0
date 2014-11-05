Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:60163 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752385AbaKEHzg (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 5 Nov 2014 02:55:36 -0500
Message-ID: <1415174133.2589.7.camel@sipsolutions.net> (sfid-20141105_085537_941800_F3EF2FAD)
Subject: Re: [PATCH v2 07/13] backports: split Kconfig into Kconfig.package
 and Kconfig.sources
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, linux-kernel@vger.kernel.org,
	yann.morin.1998@free.fr, mmarek@suse.cz, sassmann@kpanic.de,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Date: Wed, 05 Nov 2014 08:55:33 +0100
In-Reply-To: <1415157517-15442-8-git-send-email-mcgrof@do-not-panic.com> (sfid-20141105_042130_254010_EF0D1758)
References: <1415157517-15442-1-git-send-email-mcgrof@do-not-panic.com>
	 <1415157517-15442-8-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20141105_042130_254010_EF0D1758)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2014-11-04 at 19:18 -0800, Luis R. Rodriguez wrote:

> +++ b/backport/Kconfig.package
> @@ -0,0 +1,32 @@
> +mainmenu "Backports from $BACKPORTED_KERNEL_NAME $BACKPORTED_KERNEL_VERSION (backports $BACKPORTS_VERSION)"
> +
> +config BACKPORT_DIR
> +	string
> +	option env="BACKPORT_DIR"
> +config BACKPORTS_VERSION
> +	string
> +	option env="BACKPORTS_VERSION"
> +config BACKPORTED_KERNEL_VERSION
> +	string
> +	option env="BACKPORTED_KERNEL_VERSION"
> +config BACKPORTED_KERNEL_NAME
> +	string
> +	option env="BACKPORTED_KERNEL_NAME"
> +
> +# some hacks for when we use backports to generate a package
> +# to build modules out of tree.
> +#ignore-parser-package

Here you're splitting it, and I think you should just add something to
this file to ignore it instead of the "#ignore-parser-package" thing.

johannes

