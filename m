Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D80C433FE
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0C4F60EDF
	for <backports@archiver.kernel.org>; Mon, 11 Oct 2021 22:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235547AbhJKWZC (ORCPT <rfc822;backports@archiver.kernel.org>);
        Mon, 11 Oct 2021 18:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbhJKWY6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 11 Oct 2021 18:24:58 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9575CC061749
        for <backports@vger.kernel.org>; Mon, 11 Oct 2021 15:22:57 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4HStbN1V8RzQkh6;
        Tue, 12 Oct 2021 00:22:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1633990974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4HUjwioWQ5uCcz+9I9wefD/lF9iTDXGquwcEhHDE+fg=;
        b=NNUKa0DbxtFelqQZ0x31isF8tfVQ/gFBMRYd31bi4NKoH7z6aBN6T5IR+ENyEKx45QEHjp
        Zewrgm+eZiHaDPgMDUJEScqb9OnHZXtv8FrXiBz/WoRy76z0eyKZMBGF4OUh9dF+Q9TFmU
        R3gm8g3y/GSEdAyP4T4FpqiDujNH9iS+vVJEzFaimiqnDvMFYkNQOf0ZU0NfDDPIV/6TC/
        Mbw24RU/dJHX8BJsSLVJYfv64F71mkEn36uUPhkrxCbnpSQ39T18wZenOheH976kjArN0T
        KsTOFNfHMg2xRuGHRzLoBMdwQmxnB2OmGNhuN8VKhRQarzVSY49+RUp9P/8EfA==
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     backports@vger.kernel.org
Cc:     johannes.berg@intel.com, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 03/14] backprots: Add *.mod to .gitignore
Date:   Tue, 12 Oct 2021 00:22:16 +0200
Message-Id: <20211011222227.1189850-4-hauke@hauke-m.de>
In-Reply-To: <20211011222227.1189850-1-hauke@hauke-m.de>
References: <20211011222227.1189850-1-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 72BD01898
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The kernel build creates *.mod files now.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 backport/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/.gitignore b/backport/.gitignore
index 83054b63..f9d53260 100644
--- a/backport/.gitignore
+++ b/backport/.gitignore
@@ -11,6 +11,7 @@ Kconfig.versions
 *.cmd
 *.tmp
 *.ver
+*.mod
 modules.order
 backport-include/backport/autoconf.h
 modules
-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
