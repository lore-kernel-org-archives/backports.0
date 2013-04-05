Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:42733 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161777Ab3DEOSB (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 5 Apr 2013 10:18:01 -0400
Message-ID: <1365171473.8515.31.camel@jlt4.sipsolutions.net> (sfid-20130405_161803_663626_542A435C)
Subject: Re: [ANN] new backports project
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: Andy Gospodarek <andy@greyhouse.net>,
	Phil Perry <phil@pendre.co.uk>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Fri, 05 Apr 2013 16:17:53 +0200
In-Reply-To: <1365156746.8515.22.camel@jlt4.sipsolutions.net> (sfid-20130405_121249_783924_CFDD248C)
References: <1364908781.8204.14.camel@jlt4.sipsolutions.net>
	 <1364923241.8204.15.camel@jlt4.sipsolutions.net>
	 <515B4994.3030309@pendre.co.uk>
	 <1364937780.8204.18.camel@jlt4.sipsolutions.net>
	 <CAB=NE6VDAekd_a--iFocHGWxdzhVXbQrBcV1HD+kHvbL68r4iw@mail.gmail.com>
	 <20130405021259.GM27415@gospo.rdu.redhat.com>
	 <CAB=NE6VOZpEYC=OLJ7KsMq3xwXdEqVeKxvLCOZTOCuEOUwijMQ@mail.gmail.com>
	 (sfid-20130405_043012_934520_0A2CB82F) <1365156746.8515.22.camel@jlt4.sipsolutions.net>
	 (sfid-20130405_121249_783924_CFDD248C)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, 2013-04-05 at 12:12 +0200, Johannes Berg wrote:

> config BACKPORT_BUILD_HDMI
> 	...
> 	#backport-C-file drivers/video/hdmi.c
> 	#backport-H-file include/linux/hdmi.h

If we generate the makefile line for this automatically, we'll have to
be careful, some things should be built-in:

compat-$(CPTCFG_BACKPORT_BUILD_HDMI) += hdmi.o

while others should be modules

obj-$(CPTCFG_BACKPORT_BUILD_AVERAGE) += average.o


I think the way to distinguish this would be to check whether the
BACKPORT_BUILD_* option is "bool" (built-in or not present) or tristate
(will be made modular only)

johannes

