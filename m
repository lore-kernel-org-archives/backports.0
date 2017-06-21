Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:34004 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbdFUVu1 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 21 Jun 2017 17:50:27 -0400
Received: by mail-wr0-f173.google.com with SMTP id 77so152669860wrb.1
        for <backports@vger.kernel.org>; Wed, 21 Jun 2017 14:50:26 -0700 (PDT)
Subject: Re: [PATCH V2] backport: handle change in netdevice destructor usage
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <1498078699-27809-1-git-send-email-arend.vanspriel@broadcom.com>
 <1498079928.9688.2.camel@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <2ed2b0d7-7e5a-48b3-e8b1-d52ac644293d@broadcom.com> (sfid-20170621_235051_706676_1408B0CE)
Date: Wed, 21 Jun 2017 23:50:22 +0200
MIME-Version: 1.0
In-Reply-To: <1498079928.9688.2.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>



On 21-06-17 23:18, Johannes Berg wrote:
> Perhaps that can be fixed as such:
> 
>> +@r2 depends on r1@
>> +identifier r1.D, r1.C;
>> +fresh identifier E = "__" ## D;
> 
> attribute __maybe_unused;
> 
>> +@@
>> +
>> ++#if LINUX_VERSION_IS_LESS(4,13,0)
>> ++static void E(struct net_device *ndev)
> 
> __maybe_unused

Ok. I clearly made a mistake in #else of the macro:

+#if LINUX_VERSION_IS_LESS(4,13,0)
+#define netdev_set_priv_destructor(_dev, _destructor) \
+	(_dev)->destructor = __ ## _destructor
+#else
+	(_dev)->needs_free_netdev = true;
+	if (_destructor != free_netdev)
+		(_dev)->priv_destructor = _destructor;
+#endif

So I will fix that, but I do not quite understand your comment.
Expanding the macro in spatch output for net/mac80211/iface.c:

+#if LINUX_VERSION_IS_LESS(4,13,0)
+static void __ieee80211_if_free(struct net_device *ndev)
+{
+	ieee80211_if_free(ndev);
+	free_netdev(ndev);
+}
+#endif
+
 static void ieee80211_if_setup(struct net_device *dev)
 {
 	ether_setup(dev);
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->netdev_ops = &ieee80211_dataif_ops;
-	dev->needs_free_netdev = true;
-	dev->priv_destructor = ieee80211_if_free;
+#if LINUX_VERSION_IS_LESS(4,13,0)
+       dev->destructor = __ieee80211_if_free
+#else
+       dev->needs_free_netdev = true;
+       if (ieee80211_if_free != free_netdev)
+               dev->priv_destructor = ieee80211_if_free;
+#endif
 }

So __ieee80211_if_free is only defined for lower kernels and it is only
used for lower kernels. Adding the __ieee80211_if_free depends on r1 in
the semantic patch.

So I will send a V3 fixing the macro in netdevice.h, but I don't think
we need the maybe_unused attribute.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
