Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:63900 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756060AbaDHDcs (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 23:32:48 -0400
Received: by mail-pa0-f52.google.com with SMTP id rd3so393713pab.39
        for <backports@vger.kernel.org>; Mon, 07 Apr 2014 20:32:47 -0700 (PDT)
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: backports@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH 04/12] backports: complete backport of frag size accessors
Date: Mon,  7 Apr 2014 20:32:15 -0700
Message-Id: <1396927943-25589-5-git-send-email-mcgrof@do-not-panic.com> (sfid-20140408_053254_987986_4B020071)
In-Reply-To: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

These are just helpers so carry them over, this was added via commit
9e903e0852 through v3.2. The skb frag size was in place for a long time but
was changed from __u16 to __u32 via commit a309bb072b through v2.6.23 and
since we backport for >= 2.6.25 just leave this as is. This was already
only partly backported, this adds the missing helpers.

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains 9e903e0852
v3.2-rc1~182^2~85

mcgrof@ergon ~/linux-next (git::master)$ git describe --contains a309bb072b
v2.6.23-rc2~35^2~11

commit 9e903e085262ffbf1fc44a17ac06058aca03524a
Author: Eric Dumazet <eric.dumazet@gmail.com>
Date:   Tue Oct 18 21:00:24 2011 +0000

    net: add skb frag size accessors

    To ease skb->truesize sanitization, its better to be able to localize
    all references to skb frags size.

    Define accessors : skb_frag_size() to fetch frag size, and
    skb_frag_size_{set|add|sub}() to manipulate it.

    Signed-off-by: Eric Dumazet <eric.dumazet@gmail.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

Cc: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 backport/backport-include/linux/skbuff.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/backport/backport-include/linux/skbuff.h b/backport/backport-include/linux/skbuff.h
index bc67f45..2f7d57b 100644
--- a/backport/backport-include/linux/skbuff.h
+++ b/backport/backport-include/linux/skbuff.h
@@ -313,6 +313,18 @@ static inline int skb_unclone(struct sk_buff *skb, gfp_t pri)
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(3,2,0)
 
+#define skb_frag_size_set LINUX_BACKPORT(skb_frag_size_set)
+static inline void skb_frag_size_set(skb_frag_t *frag, unsigned int size)
+{
+	frag->size = size;
+}
+
+#define skb_frag_size_add LINUX_BACKPORT(skb_frag_size_add)
+static inline void skb_frag_size_add(skb_frag_t *frag, int delta)
+{
+	frag->size += delta;
+}
+
 #define __skb_fill_page_desc LINUX_BACKPORT(__skb_fill_page_desc)
 /**
  * __skb_fill_page_desc - initialise a paged fragment in an skb
-- 
1.8.5.3

