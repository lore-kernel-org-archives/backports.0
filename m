Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35938 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbdFNR2k (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 14 Jun 2017 13:28:40 -0400
Received: by mail-wr0-f174.google.com with SMTP id 36so9867338wry.3
        for <backports@vger.kernel.org>; Wed, 14 Jun 2017 10:28:40 -0700 (PDT)
Subject: Re: [PATCH] backport: handle change in netdevice destructor usage
To: Johannes Berg <johannes@sipsolutions.net>
Cc: backports@vger.kernel.org
References: <1497258385-5116-1-git-send-email-arend.vanspriel@broadcom.com>
 <1497387587.6068.15.camel@sipsolutions.net>
 <5d265e01-bd12-801b-b604-ef7107e9373c@broadcom.com>
 <1497446815.9377.0.camel@sipsolutions.net>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <079165f7-cccb-8712-7090-a9b9ed929dba@broadcom.com> (sfid-20170614_192843_129996_610C5674)
Date: Wed, 14 Jun 2017 19:28:37 +0200
MIME-Version: 1.0
In-Reply-To: <1497446815.9377.0.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 14-06-17 15:26, Johannes Berg wrote:
> On Wed, 2017-06-14 at 15:25 +0200, Arend van Spriel wrote:
>> On 13-06-17 22:59, Johannes Berg wrote:
>>> On Mon, 2017-06-12 at 10:06 +0100, Arend van Spriel wrote:
>>>> This patch deals with changes made in struct net_device by commit
>>>> cf124db566e6 ("net: Fix inconsistent teardown and release of
>>>> private
>>>> netdev state."). This only looks for instances that need
>>>> free_netdev() call, ie. struct net_device::needs_free_netdev ==
>>>> true.
>>>
>>> Come to think of it, isn't this missing the part where we now call
>>> priv_destructor when registering fails or something?
>>
>> Ah. I should have studied the patch better to see what behavioral
>> changes the commit imposed. 
> 
> Not sure, tbh. I just think there are issues there.
> 
>> So are you still considering the patch
>> despite the likely backport of commit cf124db566e6. I can do my
>> homework better and resubmit if needed.
> 
> Yeah I still think this backports patch makes sense, since I'm not sure
> I want to fix mac80211 that way (the bits in unregistering multiple
> netdevs are awkward) and brcmfmac would still need it.

So I changed the semantic patch as below, which fixes the error path
when register_netdevice() fails:

@@ -1884,6 +1889,7 @@ int ieee80211_if_add(struct ieee80211_lo

 		ret = register_netdevice(ndev);
 		if (ret) {
+			ieee80211_if_free(ndev);
 			free_netdev(ndev);
 			return ret;
 		}

Unfortunately, it also creates the following hunk:

@@ -1779,6 +1783,7 @@ int ieee80211_if_add(struct ieee80211_lo

 		ndev->tstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
 		if (!ndev->tstats) {
+			ieee80211_if_free(ndev);
 			free_netdev(ndev);
 			return -ENOMEM;
 		}

All ieee80211_if_free() does is freeing the tstats and it deals with
null pointers. So for mac80211 this is ok but not generically. Not sure
how to tackle this in a semantic patch.

Regards,
Arend
---
diff --git a/patches/0079-netdev-destructor.cocci
b/patches/0079-netdev-destructor.cocci
index d8a439d..71b5525 100644
--- a/patches/0079-netdev-destructor.cocci
+++ b/patches/0079-netdev-destructor.cocci
@@ -14,6 +14,15 @@ C(...)
 @r2 depends on r1@
 struct net_device *NDEV;
 identifier r1.D;
+@@
+
+-      free_netdev(NDEV);
++      D(NDEV);
++      free_netdev(NDEV);
+
+@r3 depends on r2@
+struct net_device *NDEV;
+identifier r1.D;
 identifier r1.C;
 fresh identifier E2 = "__" ## D;
 @@

--
To unsubscribe from this list: send the line "unsubscribe backports" in
