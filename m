Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34219C433F5
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C46A60EB4
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhJKWZB (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbhJKWY6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:24:58 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887F6C061570
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:22:57 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HStbK3xprzQk3F;
        Tue, 12 Oct 2021 00:22:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WeXfAEuDSu961s35Xj1cshsTySmk4xllb7Z6OQrN7io=;
        b=rWSDzUyIwsyE3s6ZIkWoYWuq3iG3eJZ00puCOWgACCSn1fbxwO6Pk1uXXCtUNn277pXnl9
        9i/cCdDyGLhB4sjDZFz3u6UgwWgd6dKLLlIQW2YV/MP6jAtLrkUz/VMEcj5Ne83SzmnDfQ
        zIZp7sm55i6wQdDaSf6v6cuxopWoTdUb5b23QLqcw2W3sNlJWjOuA5WclTMJr3A7Xp97tm
        cZtcRnmQZ4jZYjXp0kJ7PC5By/1MdBdVcH0tNHBzb4FyKEQzXWxaT4bfbKJFOAG5CMZOnj
        KDZgQXW4gP0wjstlaUzlMeiNmG5GsUX596BQEZtljK/N5fbSsJ46Dy+FujDlGw==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/14] backports: Add support deb with zstd compression
Date:   Tue, 12 Oct 2021 00:22:14 +0200
Message-Id: <20211011222227.1189850-2-hauke@hauke-m.de>
In-Reply-To: <20211011222227.1189850-1-hauke@hauke-m.de>
References: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 896A518B4
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The recent mainline .deb files from Ubuntu are using zstd compression.
The default python tarfile API does not support zstd compression. Use
the zpystd package from pip to decompress the stream and then use
tarfile to unpack it.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 devel/backports-update-manager | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/devel/backports-update-manager b/devel/backports-update-manager
index 4d63de8c..9177be76 100755
--- a/devel/backports-update-manager
+++ b/devel/backports-update-manager
@@ -5,6 +5,7 @@ from urllib.request import urlopen
 from urllib.parse import urljoin
 import tarfile, tempfile
 import fileinput, subprocess
+from pyzstd import ZstdFile
 source_dir = os.path.abspath(os.path.dirname(__file__))
 sys.path.append(source_dir + '/../')
 from lib import bpar as ar
@@ -541,8 +542,14 @@ class backport_kernel_updater:
                 sys.stdout.write("%s - extracting new %s ...\n" % (kver.get('ver'), target))
                 data, dpath = tempfile.mkstemp(prefix=tmp_prefix)
                 ar.print_data(target, data)
-                tar = tarfile.open(name=dpath, mode='r')
-                tar.extractall(path=tmpdir_path, members=bk_tar_members(tar))
+                try:
+                   tar = tarfile.open(name=dpath, mode='r')
+                   tar.extractall(path=tmpdir_path, members=bk_tar_members(tar))
+                except (tarfile.ReadError):
+                   zstd_file = ZstdFile(dpath)
+                   tar = tarfile.open(fileobj=zstd_file, mode='r')
+                   tar.extractall(path=tmpdir_path, members=bk_tar_members(tar))
+                   zstd_file.close()
                 os.unlink(dpath)
 
                 self.sanitize_and_install_kernel_dirs(tmpdir_path)
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
