Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:33964 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932858Ab3HHGhd (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 8 Aug 2013 02:37:33 -0400
Message-ID: <1375943844.8186.0.camel@jlt4.sipsolutions.net> (sfid-20130808_083734_786296_3B87DD26)
Subject: Re: Issue reading kernel config
From: Johannes Berg <johannes@sipsolutions.net>
To: Jonathan Bagg <jbagg@lenbrook.com>
Cc: backports@vger.kernel.org
Date: Thu, 08 Aug 2013 08:37:24 +0200
In-Reply-To: <5202AF0E.9010201@lenbrook.com> (sfid-20130807_223322_404420_CA68A7F6)
References: <1375338204-2021-8-git-send-email-sujith@msujith.org>
	 <1375370826-1387-1-git-send-email-sujith@msujith.org>
	 <51FA8ECD.7070401@lenbrook.com> <20130801174749.GC10904@shaftnet.org>
	 <51FAB31F.6050207@lenbrook.com> <5202A643.8080404@lenbrook.com>
	 <5202AF0E.9010201@lenbrook.com> (sfid-20130807_223322_404420_CA68A7F6)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Wed, 2013-08-07 at 16:33 -0400, Jonathan Bagg wrote:
> So I had a look at the Kconfig file and realised it isn't a kernel 
> config.  If I add
> 
> config BT
>      def_bool y
> 
> under the "# some hacks ..." section, I can enable BT drivers in 
> backports in the menuconfig.  So if a kconfig depends on an external 
> config, there is no way to feed in a kernel config to backports?  you 
> list external config under "# some hacks ..." section?

The script should create a dummy Kconfig.kernel from your
kernel's .config, and read that for the dependencies from the kernel.

johannes

