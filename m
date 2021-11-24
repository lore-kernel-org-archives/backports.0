Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF66DC4167B
	for <backports@archiver.kernel.org>; Wed, 24 Nov 2021 06:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhKXGDo (ORCPT <rfc822;backports@archiver.kernel.org>);
        Wed, 24 Nov 2021 01:03:44 -0500
Received: from mail.adapt-ip.com ([107.194.246.123]:56676 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233764AbhKXGDm (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 24 Nov 2021 01:03:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 44F7A744D6B;
        Wed, 24 Nov 2021 05:55:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with LMTP id af4qMf8A0tgN; Wed, 24 Nov 2021 05:55:06 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (c-67-180-239-163.hsd1.ca.comcast.net [67.180.239.163])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id D6E54744D66;
        Wed, 24 Nov 2021 05:55:05 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     backports <backports@vger.kernel.org>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        Luis Rodriguez <mcgrof@kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 0/7] Resurrect backports Integration Mode
Date:   Tue, 23 Nov 2021 21:54:58 -0800
Message-Id: <20211124055505.1267128-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

The backports integration mode[0] seems to have suffered some bitrot and
doesn't currently work. Integration mode can be convenient in certain
use cases and build flows though, so this patch set tries to fixup the
integration mode.

These changes were developed and tested for backporting a v5.10
backports + linux branch to a v4.19 kernel. v5.15-rc6 backports + linux
was successfully built against v4.19.

0: https://backports.wiki.kernel.org/index.php/Documentation/integration

Thomas Pedersen (7):
  backport: refresh integration patch
  backport: resurrect integrations
  gentree: try to make patch operation idempotent in case of --clean
  gentree: do not prefix Kernel.local symbols
  lib/bpversion: calculate Kconfig.versions for next major version
  backport: expose BP_MODULES in package mode only
  kconfig: fix select conversion for BPAUTO_ symbols in integration mode

 backport/Kconfig.integrate                    | 11 ++--
 backport/Kconfig.package                      | 10 +--
 backport/Kconfig.package.hacks                |  9 +++
 backport/Kconfig.sources                      | 18 +++---
 backport/compat/Kconfig                       |  9 ---
 gentree.py                                    | 62 +++++++++++++------
 .../0001-enable-backports-built-in.patch      | 34 +++++-----
 lib/bpversion.py                              | 11 +++-
 lib/kconfig.py                                |  5 +-
 9 files changed, 96 insertions(+), 73 deletions(-)

-- 
2.30.2

--
To unsubscribe from this list: send the line "unsubscribe backports" in
