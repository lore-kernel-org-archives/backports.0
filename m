Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:58459 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab3EVMGl (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 22 May 2013 08:06:41 -0400
Message-ID: <1369224397.8207.8.camel@jlt4.sipsolutions.net> (sfid-20130522_140643_224557_5535259E)
Subject: Re: [PATCH 8/9] lib/bpkup.py: add or own kernel uploader helper lib
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Date: Wed, 22 May 2013 14:06:37 +0200
In-Reply-To: <1369222478-30577-9-git-send-email-mcgrof@do-not-panic.com> (sfid-20130522_133524_991548_92C698F7)
References: <1369222478-30577-1-git-send-email-mcgrof@do-not-panic.com>
	 <1369222478-30577-9-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130522_133524_991548_92C698F7)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-05-22 at 04:34 -0700, Luis R. Rodriguez wrote:

> +def put(tar_bz2=None, signed_tar=None, path=None):
> +    cmd = ['kup', 'put', tar_bz2, signed_tar, path]

Without even looking, the =None here can't be right since if you don't
pass any of these args, it'll just get completely confused and probably
crash trying to pass None as an argument? Seems you should just require
all these args.

johannes

