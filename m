Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:36433 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab3GUGhI (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 21 Jul 2013 02:37:08 -0400
Message-ID: <1374388626.8376.2.camel@jlt4.sipsolutions.net> (sfid-20130721_083710_744397_749B6444)
Subject: Re: [PATCH v2 10/10] backports: lib/kconfig.py - fix src line regexp
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org, jani.nikula@intel.com
Date: Sun, 21 Jul 2013 09:37:06 +0300
In-Reply-To: <1374272009-26152-11-git-send-email-mcgrof@do-not-panic.com> (sfid-20130720_001611_669391_8F766FF3)
References: <1374272009-26152-1-git-send-email-mcgrof@do-not-panic.com>
	 <1374272009-26152-11-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20130720_001611_669391_8F766FF3)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-07-19 at 15:13 -0700, Luis R. Rodriguez wrote:

> -src_line = re.compile(r'^source\s+"?(?P<src>[^\s"]*)"?\s*$')
> +src_line = re.compile(r'^[\s]*source\s+"?(?P<src>[^\s"]*)"?\s*$')

Looks fine, not that I understand why you added [] when you have just a
single character in there? Might be better to just write "\s*" (without
the quotes, obviously)

johannes

