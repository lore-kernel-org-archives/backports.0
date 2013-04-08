Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:53854 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763317Ab3DHTnC (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Apr 2013 15:43:02 -0400
Message-ID: <1365450160.25475.22.camel@jlt4.sipsolutions.net> (sfid-20130408_214306_186387_1B8AB39F)
Subject: Re: [PATCH v3 4/8] backport module_i2c_driver helper macro
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: Thierry Escande <thierry.escande@linux.intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Mon, 08 Apr 2013 21:42:40 +0200
In-Reply-To: <CAB=NE6XWEhPAHkMfhp5N3Vc-vk1VVMQ06Egm8Sfe=wwDraQRRw@mail.gmail.com> (sfid-20130408_213430_806496_41FB44BF)
References: <1365416773-12836-5-git-send-email-thierry.escande@linux.intel.com>
	 <CAB=NE6XWEhPAHkMfhp5N3Vc-vk1VVMQ06Egm8Sfe=wwDraQRRw@mail.gmail.com>
	 (sfid-20130408_213430_806496_41FB44BF)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-04-08 at 12:33 -0700, Luis R. Rodriguez wrote:
> On Mon, Apr 8, 2013 at 3:26 AM, Thierry Escande
> <thierry.escande@linux.intel.com> wrote:
> > Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
> > ---
> >  backport/include/linux/compat-3.3.h |   21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/backport/include/linux/compat-3.3.h b/backport/include/linux/compat-3.3.h
> > index 2af4a52..ce7e776 100644
> > --- a/backport/include/linux/compat-3.3.h
> > +++ b/backport/include/linux/compat-3.3.h
> > @@ -371,6 +371,27 @@ module_exit(__driver##_exit);
> >  #undef PCI_EXP_TYPE_RC_EC
> >  #define  PCI_EXP_TYPE_RC_EC    0xa     /* Root Complex Event Collector */
> >
> > +
> > +/* This backports:
> > + *
> > + * commit 7c92784a546d2945b6d6973a30f7134be78eb7a4
> > + * Author: Lars-Peter Clausen <lars@metafoo.de>
> > + * Date:   Wed Nov 16 10:13:36 2011 +0100
> > + *
> > + *     I2C: Add helper macro for i2c_driver boilerplate
> > + */
> > +/**
> > + * module_i2c_driver() - Helper macro for registering a I2C driver
> > + * @__i2c_driver: i2c_driver struct
> > + *
> > + * Helper macro for I2C drivers which do not do anything special in module
> > + * init/exit. This eliminates a lot of boilerplate. Each module may only
> > + * use this macro once, and calling it replaces module_init() and module_exit()
> > + */
> 
> #define module_i2c_driver LINUX_BACKPORT(module_i2c_driver)
> 
> > +#define module_i2c_driver(__i2c_driver) \

It's a macro, why even try this? I'm not even sure that'll _work_
correctly.

johannes

