Return-Path: <SRS0=IQna=RX=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CC8C43381
	for <backports@archiver.kernel.org>; Wed, 20 Mar 2019 02:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 974322184D
	for <backports@archiver.kernel.org>; Wed, 20 Mar 2019 02:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YC/3c3AE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCTCei (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:34:38 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:43629 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfCTCei (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Mar 2019 22:34:38 -0400
Received: by mail-pf1-f181.google.com with SMTP id c8so748767pfd.10
        for <backports@vger.kernel.org>; Tue, 19 Mar 2019 19:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=Uyj0pprn5vgGuJIO3CFzEzRSLB2yGUxl1TaDmvKfJh4=;
        b=YC/3c3AEzkvY38SBuluy9rkPWkYMOO1/eZBGYm7mDs/XQHNf860Q3o2JMeL+yw6nqy
         p+BJqwG+5pHGFztiT9NytMmrqULyDr++DukZD0DRHEx2ItGKnAkq9b0EE8cQbeV6fOJo
         oys6ujJ9a8yEP5wsqGc+/lglEIg1u+nVqfNMwWNoutda8xKj6X+/tRLhJH7AZXgpS6D6
         ityKFZ05M+aAaE5eyWdMJB0XEzFv32Ef+h4wWbggjVr3qXWzELLhMlj2ZWPphZeDoU3n
         RZ3RwO2bmyPRhDEqoewoPF69UIrLFEEvLKeuxtrPo6vRLdPTNgRxYsxRC9dE15ab97fW
         85MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=Uyj0pprn5vgGuJIO3CFzEzRSLB2yGUxl1TaDmvKfJh4=;
        b=O9Dzhbb+Yz2d8XnumdjC3ATh1OZDbudxLtRXMXzNJS2fRlEOiYi/zLUYeOKHN4JMDP
         I3rXYEgTSMbHdcEsbXzAG+gLz4MN64WeDe46jPYjs41p4a9xKI1UyxGgqdjoizmNV/Cq
         c7BcEuJSrbjxcfCrk0gZAnoASX01VeGn88LNy8XS9/kmDneEz0hNnZgG7uSFtyfdudEn
         AGhYM4RG+xw60ZfMqa94cLjK1sHZyKTGaBByTJA+DglZEHcZaESkEzD36Bmfvxugf4a2
         QmxUDbDHFKK5h6wtE1cg6bvth187WtlgMDdNSr/eH8ji2kIK7o48JhYmqvIBHBsFl6Db
         wcDw==
X-Gm-Message-State: APjAAAWhwXpN80yh8T1NznMHNLp8I8D0UZWBv1/qTW5rOu3iIN8N2DG+
        tX+rSYoj+8NQpebjbUTccxs=
X-Google-Smtp-Source: APXvYqwFX823EnTYDHPUcP7v9POdpbMGbkybq/7UJI+61ztBDba1VaxaD9T5c4mJkDKBJMmE0RFH9g==
X-Received: by 2002:a17:902:8a84:: with SMTP id p4mr5237111plo.2.1553049277165;
        Tue, 19 Mar 2019 19:34:37 -0700 (PDT)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id n65sm567539pfb.160.2019.03.19.19.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 19:34:36 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH 0/2] backports: to make iwlwifi compile under v5.1-rc1
Date:   Wed, 20 Mar 2019 10:34:32 +0800
Message-Id: <20190320023434.2804-1-acelan.kao@canonical.com>
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

 backport/backport-include/net/netlink.h       | 15 +++++++++++++++
 patches/0013-fix-makefile-includes/mt76.patch | 10 ----------
 2 files changed, 15 insertions(+), 10 deletions(-)
 delete mode 100644 patches/0013-fix-makefile-includes/mt76.patch

-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
