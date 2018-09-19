Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.43.62]:50882 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731191AbeISO0c (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 19 Sep 2018 10:26:32 -0400
Message-ID: <1537346968.10305.4.camel@sipsolutions.net> (sfid-20180919_104941_132846_721229CC)
Subject: Re: .coredump spatch
From: Johannes Berg <johannes@sipsolutions.net>
To: Hauke Mehrtens <hauke@hauke-m.de>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: aspriel@gmail.com, John Crispin <john@phrozen.org>
Date: Wed, 19 Sep 2018 10:49:28 +0200
In-Reply-To: <a1e69bd7-132b-124b-d36c-b9cae361a9ff@hauke-m.de>
References: <a1e69bd7-132b-124b-d36c-b9cae361a9ff@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2018-09-17 at 23:39 +0200, Hauke Mehrtens wrote:
> The device structure now has this .coredump member which is also used by
> some wireless drivers, see here for example:
> https://git.kernel.org/linus/8e072168f75ebce85b96cbcefea2b10ddbd5913f
> 
> I tried to create a spatch for this

How did you try? This seems to work for me:

@@
identifier drv, fn;
@@
static struct pci_driver drv = {
	.driver = {
+#if LINUX_VERSION_IS_GEQ(4,16,0)
		.coredump = fn,
+#endif
		...
	},
	...
};

@@
identifier drv, fn;
@@
 static struct pci_driver drv = {
+#if LINUX_VERSION_IS_GEQ(4,16,0)
	.driver.coredump = fn,
+#endif
	...
 };

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
