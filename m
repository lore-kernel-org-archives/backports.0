Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78616C64E7A
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179FA2085B
	for <backports@archiver.kernel.org>; Tue,  1 Dec 2020 22:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hauke-m.de header.i=@hauke-m.de header.b="jLPRnWV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgLAWFO (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgLAWFN (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 1 Dec 2020 17:05:13 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EF4C0613D6
        for <backports@vger.kernel.org>; Tue,  1 Dec 2020 14:04:33 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Clx335RsvzQlXQ;
        Tue,  1 Dec 2020 23:04:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1606860269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8E2dwQ73UX5ObszCQbSIGK2G4xLbdCDJWiCpOWHz3bU=;
        b=jLPRnWV05DfeVF5hc9l+JP6VBESOvDIE2KItrdUFHAdYwizJYFJL23ZgxOSN1dDCt0NNan
        rcQIh0DS9M//T2sGdp3OpzjvJCM+A0Fz8egEjUbMWFq6pQn4vL6f/uV4wDuzIwsFMlrpmg
        lQjeNWC2x+4qXLCEl3XHmXIPcEL1/alhpblZbZzhpN56xhGIC2zyTyqGfez/dYsnOlJ133
        4ikM0yps4v4emO0UKwHz1mnWCYNFSDuYoST3+5vnqLJGtfEkzrO+kAFm6B4WqZHBd/DUIB
        DWfbCeeUy4TefwrrMZUKgo9fnNfuiDyqzZxRxV81HjolRfV5zPiCD/kaaoXnLg==
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id uuYEi-dXOPim; Tue,  1 Dec 2020 23:04:28 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes@sipsolutions.net, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/30] backports: Adapt to changes in Ubuntu mainline URLs
Date:   Tue,  1 Dec 2020 23:03:46 +0100
Message-Id: <20201201220415.30582-2-hauke@hauke-m.de>
In-Reply-To: <20201201220415.30582-1-hauke@hauke-m.de>
References: <20201201220415.30582-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -4.07 / 15.00 / 15.00
X-Rspamd-Queue-Id: D0D581835
X-Rspamd-UID: 95a8e3
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The .deb files are now located in the /amd64/ sub folder.
Check not only for the _all header, but also check if there is at least
one _generic deb file. This was missing in some recent releases by
Ubuntu.

Reorder the __init__ function to be able to provide the arch to
_get_ubuntu_ppa_mainline_kernels().

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 44 ++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 15 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index dc969725..2ef82854 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -37,6 +37,21 @@ def make_version_tuple(ver):
             sver.append(-1)
     return sver
 
+def parse_ubuntu_ppa_page(version, baseurl):
+    html = urlopen(baseurl).read()
+    if b'Build for amd64 failed' in html:
+        return None
+    pkgs = re.findall(b'href="linux-headers-[^"]*-generic_[^"]*\.deb"', html)
+    if not pkgs:
+        return None
+    pkgs = re.findall(b'href="linux-headers-[^"]*_all\.deb"', html)
+    if not pkgs:
+        return None
+    pkgs = [p[6:-1] for p in pkgs]
+    pkgs.sort()
+    pkg = pkgs[-1].decode('ascii')
+    return (version, baseurl + pkg)
+
 class backport_kernel_updater:
     """
     This is the Linux kernel backports kernel updater. It ensures you
@@ -53,7 +68,7 @@ class backport_kernel_updater:
         sys.exit(1)
 
     @classmethod
-    def _get_ubuntu_ppa_mainline_kernels(cls):
+    def _get_ubuntu_ppa_mainline_kernels(cls, pkg_arch):
         base = KPATH
         html = urlopen(base).read()
         builds = re.findall(b'href="([-v.0-9a-z]*)/"', html)
@@ -96,17 +111,16 @@ class backport_kernel_updater:
             for version in subvers:
                 version = version[1]
 
-                html = urlopen(base + version + '/').read()
-                if b'Build for amd64 failed' in html:
-                    continue
-                pkgs = re.findall(b'href="linux-headers-[^"]*_all\.deb"', html)
-                if not pkgs:
-                    continue
-                pkgs = [p[6:-1] for p in pkgs]
-                pkgs.sort()
-                pkg = pkgs[-1].decode('ascii')
-                result.append((version, base + version + '/' + pkg))
-                break
+                baseurl = base + version + '/'
+                pkgs = parse_ubuntu_ppa_page(version, baseurl)
+                if pkgs:
+                    result.append(pkgs)
+                    break
+                baseurl = base + version + '/' + pkg_arch + '/'
+                pkgs = parse_ubuntu_ppa_page(version, baseurl)
+                if pkgs:
+                    result.append(pkgs)
+                    break
 
         result.sort(key = lambda x: make_version_tuple(x[0][1:]))
         return [x[1] for x in result]
@@ -116,7 +130,9 @@ class backport_kernel_updater:
                  reference=None):
         self.ksrc_base = ""
         self.ksrc_prefix = ""
-        self.kernel_urls = self._get_ubuntu_ppa_mainline_kernels()
+        sysname, nodename, release, version, self.machine = os.uname()
+        self.pkg_arch = self.pkg_arch(self.machine)
+        self.kernel_urls = self._get_ubuntu_ppa_mainline_kernels(self.pkg_arch)
         self.num_kernels = len(self.kernel_urls)
         self.git_trees = GIT_TREES
         self.git_trees_missing = list()
@@ -134,8 +150,6 @@ class backport_kernel_updater:
         self.reference = reference
         self.reference_git = None
         self.cwd = os.getcwd()
-        sysname, nodename, release, version, self.machine = os.uname()
-        self.pkg_arch = self.pkg_arch(self.machine)
         if self.root:
             self.ksrc_base = self.cwd + "/"
             self.ksrc_prefix = self.ksrc_base + BACKPORTS_KSRC_DIR
-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
