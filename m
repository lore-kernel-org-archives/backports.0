Return-Path: <SRS0=sLXW=R6=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8844FC43381
	for <backports@archiver.kernel.org>; Wed, 27 Mar 2019 03:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5420B2082F
	for <backports@archiver.kernel.org>; Wed, 27 Mar 2019 03:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpjN+MDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbfC0DAs (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 26 Mar 2019 23:00:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41942 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbfC0DAs (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 26 Mar 2019 23:00:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id y5so2583346plk.8
        for <backports@vger.kernel.org>; Tue, 26 Mar 2019 20:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=dKo7rVoejxdcBkNRrhSZ4RX7rbifQH3e4i2kLtITSLs=;
        b=QpjN+MDVeXG8iUbAwjHl9VAyXgyVXT2nJHLkvOJYULUTwvaiWv7XzpM/Mp4yfPWVIE
         T4+JMWnuDIMa0taIfIEZxKjJ16Xpfm22uDF2zgB56lOkio84LZ7ogrSSuIGbOxA78NL7
         ugl5c+uyItcqG3qnrdt1z7USdc0CH9sixgUyCg+x9lwivklKO24EW5gFrvbXFyLcfuZ5
         Rfr70XxAr3/Ggl5NJVQwmIu0JAGRNEv1Cum+6qwMHcKzvlMBFI3jcWtnsV/FRaXkRL3u
         dSZuXlyQU1I/U3qR7FxHi5IRb95lIwQxYOCqSL8hB+HorV+EsRaH0p/4iIS04dMyo89I
         wVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=dKo7rVoejxdcBkNRrhSZ4RX7rbifQH3e4i2kLtITSLs=;
        b=lGFlBQY2ryHjhtJ8YgWwio64c1dA/ckdnzkUjwQxsSbPO8dXltkiUzoufa7yM/W6sX
         vCHVYcuoq/La0YKqtjfUOEQQ+P7I6M5XAM87XJ7uUAtLsDvZB1mSfphZQkKNfd7GQc0N
         +cEAbd15KIK6OMiXPVALACWdcMazyfNtuKI8F5f2uKy83Q/mhbj9stbOhswjboaa1cNq
         gvUmYCnT5elwXSOt/bYZX4I3vdQ8r+5aQhK/w/LQ4W6BeLa/ts5HOIG3Y4LVKJmfyLE+
         Y4fLTzgcU/4hKHV3xnwa2GNbNGQeTJaDYS8q1pMZt7riUxDnqgPO48FVt/wmg3/AEzuy
         jDoQ==
X-Gm-Message-State: APjAAAUJiEtMrHlFVs20pJ5QNLaJa+l2Dj2yjuNrlOt7m/LCNVTS+5Xu
        ozTfYf5DQxuDRmH+MPCsw6X57Q3X+Dw=
X-Google-Smtp-Source: APXvYqylsR803UgQH4EbG0PzHcdJaNTfQBd9OaK32etZeUZb6lYWu6kfZ9GxgBAFilDrOXyGoaVIPQ==
X-Received: by 2002:a17:902:e5:: with SMTP id a92mr34213984pla.326.1553655647852;
        Tue, 26 Mar 2019 20:00:47 -0700 (PDT)
Received: from localhost (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id v1sm6786917pff.81.2019.03.26.20.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 20:00:46 -0700 (PDT)
From:   AceLan Kao <acelan.kao@canonical.com>
To:     hauke@hauke-m.de, mcgrof@kernel.org, backports@vger.kernel.org
Subject: [PATCH v3 0/3] backports: to make iwlwifi backported from v5.1-rc1 can be compiled
Date:   Wed, 27 Mar 2019 11:00:41 +0800
Message-Id: <20190327030044.28263-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Trying to backport iwlwifi driver from v5.1-rc1, and did some necessary
modifications.

== ckmake-report.log ==

1   3.10.108            [  FAIL  ]
2   3.11.10             [  FAIL  ]
3   3.12.74             [  FAIL  ]
4   3.13.11             [  FAIL  ]
5   3.14.79             [  FAIL  ]
6   3.15.10             [  FAIL  ]
7   3.16.63             [  FAIL  ]
8   3.17.8              [  FAIL  ]
9   3.18.136            [  FAIL  ]
10  3.19.8              [  FAIL  ]
11  4.0.9               [  FAIL  ]
12  4.1.52              [  FAIL  ]
13  4.2.8               [  LINK  ]
14  4.3.6               [  LINK  ]
15  4.4.176             [  OK  ]
16  4.5.7               [  OK  ]
17  4.6.7               [  FAIL  ]
18  4.7.10              [  FAIL  ]
19  4.8.17              [  FAIL  ]
20  4.9.162             [  FAIL  ]
21  4.10.17             [  FAIL  ]
22  4.11.12             [  FAIL  ]
23  4.12.14             [  OK  ]
24  4.13.16             [  OK  ]
25  4.14.105            [  OK  ]
26  4.15.18             [  OK  ]
27  4.16.18             [  OK  ]
28  4.17.19             [  OK  ]
29  4.18.20             [  OK  ]
30  4.19.28             [  OK  ]
31  4.20.15             [  OK  ]
32  5.0.1               [  OK  ]

AceLan Kao (3):
  backports: remove mt76.patch
  backports: update backport/backport-include/net/netlink.h
  backports: fix compilation error against v4.4 kernel

 backport/backport-include/net/netlink.h       | 18 +++++++++++++-----
 patches/0013-fix-makefile-includes/mt76.patch | 10 ----------
 patches/lib-refcount.patch                    |  6 +++++-
 3 files changed, 18 insertions(+), 16 deletions(-)
 delete mode 100644 patches/0013-fix-makefile-includes/mt76.patch

-- 
2.17.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
