Return-Path: <SRS0=hPYX=RW=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CBEC43381
	for <backports@archiver.kernel.org>; Tue, 19 Mar 2019 06:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8FC20989
	for <backports@archiver.kernel.org>; Tue, 19 Mar 2019 06:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7Abc27c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfCSGJS (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:09:18 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:34672 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSGJS (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Mar 2019 02:09:18 -0400
Received: by mail-pg1-f177.google.com with SMTP id v12so13174416pgq.1
        for <backports@vger.kernel.org>; Mon, 18 Mar 2019 23:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=gsSpzmzOg/1R/k2SmLSlqcfCvMCiIxBd84wwhVNjTqc=;
        b=V7Abc27ci/lKKmE9OKM7mi3xxvt0C2IU10akkqpwuJgaLhN9bwut5iyWCpCJjFcvPI
         PFS+wZpUtKlTckFfFB1OFRsFfB8N2WSt3l30b1+B/IHgqtXaRSkdXpCONZ0dizORkexp
         udg2c/8bfRki0H+mNsJ3KiqCutasbKjWRv66ThNRC0zp/VLOvQm2HYZz8TlI5u36rbAF
         HO5W7mCGkk4X8Vzh4/w+gTp4uI60i3ahb/KsXXwn0fPtdHH4LO/0J6DG+B8rbZ3rf6aH
         enMgnJrcCO+i8+pUzuGb0YH5+6VlzTe8ASRnJUgIrKiTnYa+kYs/8hiyIHf0zZ5voAGk
         Togg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=gsSpzmzOg/1R/k2SmLSlqcfCvMCiIxBd84wwhVNjTqc=;
        b=iKhWxtJlXBTK3+ubwaP9Da+ZiPoFmc/ex9FZANNpNJUbmE7zSqqIIbQGTnNhwTnenE
         SkRCQZJvxBzWoxuFJw6Zau0MpGlbLXAtaAU8meTCuDMUT4WqmOv4dfdYrbaf75j3oQBN
         5AGfqtHDtgkf3tyycCrXNKAvaKHJFJnrJC63qlJ4mlP+4hYKf3q+rCMVHYFLVYfeDtUE
         4L5VCervuji+A7FlMew9uF5wjSDbdMF8UlE9LgYYEMWEAPkApjPASoCV/fah/7gBEMfs
         Jp5UP285TLxGZSEPFi7jc+WHvXz6WlaOge+icpaMHt9egKz0HSp7sJX9wsaxUqU3MXQD
         tCaQ==
X-Gm-Message-State: APjAAAWPlhpId7EeXydyjugVZA7zemB9OuN9urgnZgotopdcpZLXcR5L
        S5BlOCNIgpqsiI1X5m67STLZERj52YE=
X-Google-Smtp-Source: APXvYqzvZa9p/GCadRA6jffiym6d2Lbi1sTtXcPsIm3z/g9qH7jIK3/GPgT8TTHYLfc1LxBsQ+Z3ig==
X-Received: by 2002:a62:5e46:: with SMTP id s67mr281148pfb.126.1552975757484;
        Mon, 18 Mar 2019 23:09:17 -0700 (PDT)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id k83sm14899755pfj.178.2019.03.18.23.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 23:09:16 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH 0/2] backports: to make iwlwifi compile under v5.1-rc1
Date:   Tue, 19 Mar 2019 14:09:13 +0800
Message-Id: <20190319060915.19849-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Trying to backport iwlwifi driver from v5.1-rc1, and did some necessary
modifications.

AceLan Kao (2):
  backports: remove mt76.patch
  backports: update backport/backport-include/net/netlink.h

 backport/backport-include/net/netlink.h       |  8 ++++++--
 patches/0013-fix-makefile-includes/mt76.patch | 10 ----------
 2 files changed, 6 insertions(+), 12 deletions(-)
 delete mode 100644 patches/0013-fix-makefile-includes/mt76.patch

-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
