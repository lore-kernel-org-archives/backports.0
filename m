Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:44217 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754024Ab3DMXyK (ORCPT
	<rfc822;backports@vger.kernel.org>); Sat, 13 Apr 2013 19:54:10 -0400
From: Johannes Berg <johannes@sipsolutions.net>
To: backports@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT 05/42] backports: fix dma-buf backport patch
Date: Sun, 14 Apr 2013 01:53:25 +0200
Message-Id: <1365897243-31214-6-git-send-email-johannes@sipsolutions.net> (sfid-20130414_015415_279646_A6C2531E)
In-Reply-To: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
References: <1365897243-31214-1-git-send-email-johannes@sipsolutions.net>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

From: Johannes Berg <johannes.berg@intel.com>

The patched backported dma-buf code uses the "current" macro
to determine task information, so it needs to include sched.h.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 patches/backport-adjustments/dma-buf.patch | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/patches/backport-adjustments/dma-buf.patch b/patches/backport-adjustments/dma-buf.patch
index 06ed9f6..789a108 100644
--- a/patches/backport-adjustments/dma-buf.patch
+++ b/patches/backport-adjustments/dma-buf.patch
@@ -1,12 +1,13 @@
 --- a/compat/drivers-base-dma-buf.c
 +++ b/compat/drivers-base-dma-buf.c
-@@ -27,6 +27,9 @@
+@@ -27,6 +27,10 @@
  #include <linux/dma-buf.h>
  #include <linux/anon_inodes.h>
  #include <linux/export.h>
 +#include <linux/file.h>
 +#include <linux/fdtable.h>
 +#include <linux/bitops.h>
++#include <linux/sched.h>
  
  static inline int is_dma_buf_file(struct file *);
  
-- 
1.8.0

