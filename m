Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:34890 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756141Ab3HHMQY (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 8 Aug 2013 08:16:24 -0400
Message-ID: <1375964180.8186.3.camel@jlt4.sipsolutions.net> (sfid-20130808_141625_892184_55475FB8)
Subject: Re: Issue reading kernel config
From: Johannes Berg <johannes@sipsolutions.net>
To: Jonathan Bagg <jbagg@lenbrook.com>
Cc: backports@vger.kernel.org
Date: Thu, 08 Aug 2013 14:16:20 +0200
In-Reply-To: <520384E4.1010205@lenbrook.com>
References: <1375338204-2021-8-git-send-email-sujith@msujith.org>
	  <1375370826-1387-1-git-send-email-sujith@msujith.org>
	  <51FA8ECD.7070401@lenbrook.com> <20130801174749.GC10904@shaftnet.org>
	  <51FAB31F.6050207@lenbrook.com> <5202A643.8080404@lenbrook.com>
	  <5202AF0E.9010201@lenbrook.com>
	 (sfid-20130807_223322_404420_CA68A7F6) <1375943844.8186.0.camel@jlt4.sipsolutions.net>
	 <520384E4.1010205@lenbrook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2013-08-08 at 07:45 -0400, Jonathan Bagg wrote:

> > The script should create a dummy Kconfig.kernel from your
> > kernel's .config, and read that for the dependencies from the kernel.

> I'd like to figure out why it isn't working.  Which script reads the 
> kernel's .config?

It's an inline script in the Makefile, this part:

        @set -e ; if [ "$$(cat .kernel_config_md5 2>/dev/null)" != "$(CONFIG_MD5)" ]    ;\
        then                                                                            \ 
                echo -n "Generating local configuration database from kernel ..."       ;\
...


johannes

