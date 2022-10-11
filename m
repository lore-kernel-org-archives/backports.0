Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB07C433FE
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJKVFW (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJKVFC (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0C23C8C6
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BY7llortZjgCGmz7Lx3REkFiY29q3jdcrgQAJ0JJEmk=;
        t=1665522300; x=1666731900; b=ihBvSmdkqSQN7cJMUcDFRvd22/iasFpeYWmlUeNX2G4bUHa
        ZFoeKXyVZkBJiuUcvsidgttMn8rQz0xwj0qsFaZlWmoyjzPZ3wiRitans5t/f3DPuLledklZmCv59
        WwXV9mWNhJt6Fn57xmK+UMXIWds+V0yl6fSOW4equVN0re/c/7tCt0l0NOP8VBulBTr5F5a2QUkHy
        XbQXdg9jPFZ6wXI/ESCWqONRBHYNM+g2iGBY1qu2Idjzxrbf68iMugBm3GFf7tc9YcLgOl6QQEiVO
        I7zFSvHSkPpbuW/PF9vkjpkiAKpHV7lox/RGdIIzFFKEddotJv9Qyu68JjT7YmOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQs-0045LP-0O;
        Tue, 11 Oct 2022 23:04:58 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 32/38] backports: add netlink length validation for 13
Date:   Tue, 11 Oct 2022 23:04:40 +0200
Message-Id: <20221011230356.b644475cebaf.Ie5f51a2a3b67734956f49ea9c1e1091f60400cdf@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is needed for EHT.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/netlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index e78a0ff7971c..0de0de5ff8ad 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -561,6 +561,7 @@ int nla_validate_min_len_##n(const struct nlattr *attr,			\
 }
 
 MIN_LEN_VALIDATION(2)
+MIN_LEN_VALIDATION(13)
 MIN_LEN_VALIDATION(16)
 MIN_LEN_VALIDATION(42)
 
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
