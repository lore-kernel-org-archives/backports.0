Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.152]:36430 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab3GUGfV (ORCPT
	<rfc822;backports@vger.kernel.org>); Sun, 21 Jul 2013 02:35:21 -0400
Message-ID: <1374388514.8376.1.camel@jlt4.sipsolutions.net> (sfid-20130721_083525_753419_550833C2)
Subject: Re: [RFC/RFT] backport: backport sprintf-style workqueue naming
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Date: Sun, 21 Jul 2013 09:35:14 +0300
In-Reply-To: <51E5A066.8070009@hauke-m.de>
References: <1373979477-11133-1-git-send-email-johannes@sipsolutions.net>
	 <51E5A066.8070009@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2013-07-16 at 21:35 +0200, Hauke Mehrtens wrote:

> > -#ifndef alloc_ordered_workqueue
> > -#define alloc_ordered_workqueue(name, flags) create_singlethread_workqueue(name)
> > +#if LINUX_VERSION_CODE < KERNEL_VERSION(3,3,0)
> > +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36)
> 
> Why not do a check for #ifndef WQ_UNBOUND that way we do not get that
> many problems when someone tries a kernel that already backported this.

It's an enum, so that won't work.


> The #undef destroy_workqueue in compat-3.3.c does not look nice to me.
> 
> What about this and then call orig_destroy_workqueue(wq)?
> 
> static inline void orig_destroy_workqueue(struct workqueue_struct *wq)
> {
> 	destroy_workqueue(wq);
> }
> #define destroy_workqueue(wq) backport_destroy_workqueue(wq)

Why? I don't see a reason to expose this to users of the API.

johannes

