Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:47005 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab3EMMCK (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 13 May 2013 08:02:10 -0400
Message-ID: <1368446524.8300.22.camel@jlt4.sipsolutions.net> (sfid-20130513_140231_639455_1C832DA7)
Subject: Re: [PATCH 01/12] backports: make compat module use
 subsys_initcall()
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, pstew@chromium.org
Date: Mon, 13 May 2013 14:02:04 +0200
In-Reply-To: <1368232023-23817-2-git-send-email-mcgrof@do-not-panic.com> (sfid-20130511_022718_965302_E9DED80D)
References: <1368232023-23817-1-git-send-email-mcgrof@do-not-panic.com>
	 <1368232023-23817-2-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130511_022718_965302_E9DED80D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-05-10 at 17:26 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
> 
> This is a no-op for the modular use case of the
> backports project but by enabling this it allows
> for developers a way to embed the backports releases
> onto a target source Linux directory, with obvious
> pending modifications, by adding our backport_init()
> onto the target kernel's init/main.c start_kernel().
> 
> Enable this theoretical use case. Hackers welcome to
> go play on this theoretical integration strategy now.

I applied all but this one, it caused a compiler warning that seemed
important (missing an include?)

/tmp/i/compat/main.c:83:1: warning: data definition has no type or
storage class [enabled by default]
/tmp/i/compat/main.c:83:1: warning: type defaults to ‘int’ in
declaration of ‘__exitcall’ [-Wimplicit-int]
/tmp/i/compat/main.c:83:1: warning: parameter names (without types) in
function declaration [enabled by default]
/tmp/i/compat/main.c:76:123: warning: ‘backport_exit’ defined but not
used [-Wunused-function]


johannes

