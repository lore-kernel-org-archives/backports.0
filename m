Return-path: <backports-owner@vger.kernel.org>
Received: from paleale.coelho.fi ([176.9.41.70]:38404 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751622AbdBFIwZ (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 6 Feb 2017 03:52:25 -0500
Message-ID: <1486371134.26003.126.camel@coelho.fi> (sfid-20170206_095311_323366_1DCB0279)
From: Luca Coelho <luca@coelho.fi>
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: backports@vger.kernel.org
Date: Mon, 06 Feb 2017 10:52:14 +0200
In-Reply-To: <def07450-4d61-7225-29f6-90eb952289d1@broadcom.com>
References: <1485870404-28663-1-git-send-email-arend.vanspriel@broadcom.com>
         <def07450-4d61-7225-29f6-90eb952289d1@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] backports: adjustments: fix devcoredump patch for
 class_groups
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, 2017-02-02 at 19:36 +0100, Arend Van Spriel wrote:
> On 31-1-2017 14:46, Arend van Spriel wrote:
> > Since...
> > 
> >   commit f76d25275c314defb684fdd692239507001774bc
> >   Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >   Date:   Mon Nov 28 16:41:58 2016 +0100
> > 
> >      driver core: devcoredump: convert to use class_groups
> > 
> > it is using struct class::class_groups. Update the devcoredump
> > patch file accordingly.
> > 
> > Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> > ---
> >  patches/backport-adjustments/devcoredump.patch | 43 +++++++++++++++++++++-----
> >  1 file changed, 35 insertions(+), 8 deletions(-)
> > 
> > diff --git a/patches/backport-adjustments/devcoredump.patch b/patches/backport-adjustments/devcoredump.patch
> > index f35e881..ab38ac6 100644
> > --- a/patches/backport-adjustments/devcoredump.patch
> > +++ b/patches/backport-adjustments/devcoredump.patch
> > @@ -10,7 +10,7 @@ index 240374f..8bb376b 100644
> >   
> >   static struct class devcd_class;
> >   
> > -@@ -40,6 +41,10 @@ static bool devcd_disabled;
> > +@@ -40,6 +41,10 @@
> >   /* if data isn't read by userspace after 5 minutes then delete it */
> >   #define DEVCD_TIMEOUT	(HZ * 60 * 5)
> >   
> > @@ -41,7 +41,7 @@ index 240374f..8bb376b 100644
> >   	device_del(&devcd->devcd_dev);
> >   	put_device(&devcd->devcd_dev);
> >   }
> > -@@ -115,6 +122,7 @@ static struct bin_attribute devcd_attr_data = {
> > +@@ -115,6 +122,7 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
> >   	.write = devcd_data_write,
> >   };
> >   
> > @@ -49,7 +49,7 @@ index 240374f..8bb376b 100644
> >   static struct bin_attribute *devcd_dev_bin_attrs[] = {
> >   	&devcd_attr_data, NULL,
> >   };
> > -@@ -126,6 +134,7 @@ static const struct attribute_group devcd_dev_group = {
> > +@@ -126,6 +134,7 @@ static ssize_t devcd_data_write(struct file *filp, struct kobject *kobj,
> >   static const struct attribute_group *devcd_dev_groups[] = {
> >   	&devcd_dev_group, NULL,
> >   };
> > @@ -57,17 +57,44 @@ index 240374f..8bb376b 100644
> >   
> >   static int devcd_free(struct device *dev, void *data)
> >   {
> > -@@ -170,7 +179,9 @@ static struct class devcd_class = {
> > +@@ -160,20 +169,35 @@ static ssize_t disabled_store(struct class *class, struct class_attribute *attr,
> > + 
> > + 	return count;
> > + }
> > ++#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 10, 0)
> > ++static struct class_attribute devcd_class_attrs[] = {
> > ++	__ATTR_RW(disabled),
> > ++	__ATTR_NULL
> > ++};
> > ++#else
> > + static CLASS_ATTR_RW(disabled);
> > + 
> > + static struct attribute *devcd_class_attrs[] = {
> > + 	&class_attr_disabled.attr,
> > + 	NULL,
> > + };
> > +-ATTRIBUTE_GROUPS(devcd_class);
> > ++static const struct attribute_group devcd_class_group = {
> > ++	.attrs = devcd_class_attrs,
> > ++};
> 
> This is actually not sufficient. Also need to add expansion of
> __ATTRIBUTE_GROUPS() macro. Did not hit this as it kicks in when
> backporting to 4.10+, which is not on my list yet ;-p

Thanks, Arend! I had something to "fix" this, but it was completely
b0rked for (at least) <= 3.14.  I'll try your patch now (at the moment I
don't care much about 4.10+ either).

--
Cheers,
Luca.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
