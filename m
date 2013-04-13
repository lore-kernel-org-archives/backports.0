Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:43792 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab3DMU7f (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 16:59:35 -0400
Message-ID: <1365886772.1089.4.camel@jlt4.sipsolutions.net> (sfid-20130413_225937_628163_44155AA7)
Subject: Re: [PATCH 4/7] gentree.py: add support to explicitly disable a
 config
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Sat, 13 Apr 2013 22:59:32 +0200
In-Reply-To: <1365862424-6530-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20130413_161410_391045_B8C3CA17)
References: <1365862424-6530-1-git-send-email-mcgrof@do-not-panic.com>
	 <1365862424-6530-5-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130413_161410_391045_B8C3CA17)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2013-04-13 at 07:13 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> At times we may want to disable a config option completely.
> Add support for this. All you have to is list the config
> on the depdependencies file with DISABLE instead of a kernel
> version.

Applied, but

> +            if (dep == "DISABLE"):

I removed those parentheses

> +		    new.append('BACKPORT_KERNEL_%s' % dep.replace('.', '_'))

and made this just "BACKPORT_DISABLED_KCONFIG_OPTION" instead of using
"dep"

johannes

