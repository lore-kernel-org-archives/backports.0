Return-Path: <SRS0=louc=RS=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45501C43381
	for <backports@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F23A21871
	for <backports@archiver.kernel.org>; Fri, 15 Mar 2019 14:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfCOOd0 (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:33:26 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44012 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729221AbfCOOd0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 15 Mar 2019 10:33:26 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@coelho.fi>)
        id 1h4ntj-0004kR-Rp; Fri, 15 Mar 2019 16:33:24 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     backports@vger.kernel.org
Cc:     Luca Coelho <luciano.coelho@intel.com>
Date:   Fri, 15 Mar 2019 16:33:12 +0200
Message-Id: <20190315143318.4714-1-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH 0/6] backport: some patches from our internal tree 2019-03-15
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Hi,

These are a few new patches that we had pending in our internal tree.
They update some things for v5.0, fix some bugs and add things needed
by iwlwifi.

Please review.


Cheers,
Luca.


Johannes Berg (1):
  backports: genetlink: avoid NULL dereference

Luca Coelho (5):
  backport: add v5.* to the Makefile
  backports: update iwlwifi pci device removal patch for v5.0
  backport: add atomic_fetch_add_unless()
  backport: add include ftrace_event.h back to backport-4.0.c
  backport: fix handling of nospec.h for 4.15.0 and 4.15.1

 backport/Makefile                             | 5 +++--
 backport/backport-include/linux/atomic.h      | 9 +++++++++
 backport/backport-include/linux/nospec.h      | 3 ++-
 backport/compat/backport-4.0.c                | 1 +
 backport/compat/backport-genetlink.c          | 9 +++------
 patches/0085-iwlwifi-pci-device-removal.patch | 8 ++++----
 6 files changed, 22 insertions(+), 13 deletions(-)

-- 
2.20.1

--
To unsubscribe from this list: send the line "unsubscribe backports" in
