Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:50934 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755212AbaBUSCm (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 21 Feb 2014 13:02:42 -0500
Message-ID: <530794B3.50502@hauke-m.de> (sfid-20140221_190244_805512_2D7497CB)
Date: Fri, 21 Feb 2014 19:02:27 +0100
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Daniel Schultze <kinglag@gmail.com>, backports@vger.kernel.org
Subject: Re: Missing Symbol in mac80211.ko
References: <CAEsx0Y8=+OcFi3ymv1TADr-rdjB=5WWOY=JTq6DYcN5bkR6-Dw@mail.gmail.com>
In-Reply-To: <CAEsx0Y8=+OcFi3ymv1TADr-rdjB=5WWOY=JTq6DYcN5bkR6-Dw@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------030905090201000408010603"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030905090201000408010603
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/14/2014 10:38 PM, Daniel Schultze wrote:
> Developers,
> 
> While trying to upgrade from backports v3.11.8 to v3.13.2 I ran into
> this warning:
> 
> WARNING: "atomic64_set"
> [/home/dschultze/dump/ltib-trunk/rpm/BUILD/backports-3.13.2-1/net/mac80211/mac80211.ko]
> undefined!
> 
> I have verified that the kernel (v2.6.31, arm) does indeed have a
> definition for this function but for some reason mac80211.ko cannot
> see it. I was able to use the following patch as a hack to provide an
> implementation for mac80211.ko.
> 

Hi Daniel,

could you try the attached patch. Some old kernel versions are missing
the implementations for these atomic64 operations and we already added
some of them, but atomic64_set() was missing.

Hauke

--------------030905090201000408010603
Content-Type: text/x-patch;
 name="0002-backports-add-atomic64_set.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-backports-add-atomic64_set.patch"

>From 966462037efecbead20898633ea55b6c5e90b9a5 Mon Sep 17 00:00:00 2001
From: Hauke Mehrtens <hauke@hauke-m.de>
Date: Fri, 21 Feb 2014 18:59:25 +0100
Subject: [PATCH 2/3] backports: add atomic64_set()

---
 backport/compat/compat_atomic.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/backport/compat/compat_atomic.c b/backport/compat/compat_atomic.c
index b8565aa..ae5eb1e 100644
--- a/backport/compat/compat_atomic.c
+++ b/backport/compat/compat_atomic.c
@@ -17,6 +17,16 @@ long long atomic64_read(const atomic64_t *v)
 }
 EXPORT_SYMBOL_GPL(atomic64_read);
 
+void atomic64_set(atomic64_t *v, long long i)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+	v->counter = i;
+	spin_unlock_irqrestore(&lock, flags);
+}
+EXPORT_SYMBOL_GPL(atomic64_set);
+
 long long atomic64_add_return(long long a, atomic64_t *v)
 {
     unsigned long flags;
-- 
1.7.10.4


--------------030905090201000408010603--
