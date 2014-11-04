Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:52599 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbaKDKFv (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 4 Nov 2014 05:05:51 -0500
Message-ID: <1415095517.2064.10.camel@sipsolutions.net> (sfid-20141104_110553_789077_A6DB6FF5)
Subject: Re: [PATCH v1 03/11] backports: allow for different backport prefix
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, linux-kernel@vger.kernel.org,
	yann.morin.1998@free.fr, mmarek@suse.cz, sassmann@kpanic.de,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Date: Tue, 04 Nov 2014 11:05:17 +0100
In-Reply-To: <1415090582-14129-4-git-send-email-mcgrof@do-not-panic.com> (sfid-20141104_094338_661432_D1F2BC2E)
References: <1415090582-14129-1-git-send-email-mcgrof@do-not-panic.com>
	 <1415090582-14129-4-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20141104_094338_661432_D1F2BC2E)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2014-11-04 at 00:42 -0800, Luis R. Rodriguez wrote:

> --- a/devel/ckmake
> +++ b/devel/ckmake
> @@ -165,6 +165,7 @@ def process_kernel(num, kset, cmdline_args):
>          all_config_name = os.path.join(work_dir, 'all.config')
>          all_config = open(all_config_name, 'w')
>          all_config.write("CPTCFG_CFG80211_INTERNAL_REGDB=n\n")
> +        all_config.write("CONFIG_BACKPORT_CFG80211_INTERNAL_REGDB=n\n")

don't you know the prefix here?

>          config_name = 'allnoconfig'
>          if cmdline_args.allyesconfig:
>              config_name = 'allyesconfig'
> @@ -173,6 +174,7 @@ def process_kernel(num, kset, cmdline_args):
>                  open(os.path.join(work_dir, 'defconfigs', cmdline_args.defconfig)).read())
>          else:
>              all_config.write("CPTCFG_BACKPORT_USERSEL_BUILD_ALL=y\n")
> +            all_config.write("CONFIG_BACKPORT_CFG80211_INTERNAL_REGDB=y\n")
>          all_config.close()

Not sure this part is right?

johannes

