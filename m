Return-path: <backports-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:45369 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbaBNViU (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 14 Feb 2014 16:38:20 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so12372880yhl.9
        for <backports@vger.kernel.org>; Fri, 14 Feb 2014 13:38:20 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 14 Feb 2014 13:38:19 -0800
Message-ID: <CAEsx0Y8=+OcFi3ymv1TADr-rdjB=5WWOY=JTq6DYcN5bkR6-Dw@mail.gmail.com> (sfid-20140214_223822_943709_7006CDD8)
Subject: Missing Symbol in mac80211.ko
From: Daniel Schultze <kinglag@gmail.com>
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Developers,

While trying to upgrade from backports v3.11.8 to v3.13.2 I ran into
this warning:

WARNING: "atomic64_set"
[/home/dschultze/dump/ltib-trunk/rpm/BUILD/backports-3.13.2-1/net/mac80211/mac80211.ko]
undefined!

I have verified that the kernel (v2.6.31, arm) does indeed have a
definition for this function but for some reason mac80211.ko cannot
see it. I was able to use the following patch as a hack to provide an
implementation for mac80211.ko.

diff -Nur backports-3.13.2-1-orig/net/mac80211/key.c
backports-3.13.2-1/net/mac80211/key.c
--- backports-3.13.2-1-orig/net/mac80211/key.c 2014-02-14
10:40:12.699276697 -0800
+++ backports-3.13.2-1/net/mac80211/key.c 2014-02-14 13:27:30.068628373 -0800
@@ -686,6 +686,16 @@
 }
 EXPORT_SYMBOL_GPL(ieee80211_gtk_rekey_notify);

+void atomic64_set(atomic64_t *v, long long i)
+{
+        unsigned long flags;
+//        spinlock_t *lock = lock_addr(v);
+
+//        spin_lock_irqsave(lock, flags);
+        v->counter = i;
+//        spin_unlock_irqrestore(lock, flags);
+}
+
 void ieee80211_get_key_tx_seq(struct ieee80211_key_conf *keyconf,
       struct ieee80211_key_seq *seq)
 {

I know that using this hack isn't the best way to go but I'm not sure
how to resolve the issue: why can't backports use the function and
exported symbol from the kernel?

Thank you,
Daniel Schultze
