Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37EEC43219
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJKVFV (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJKVFC (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:02 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B46371B9
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=r54dB7yH7/Alfgl6fWoSgD9hH2jKMeU+KlnossxwTXk=;
        t=1665522300; x=1666731900; b=wOKILsT+kEEVPMIBFkufsrV7+9reEB2DID243vzPgYQR7T/
        GfePkoY1qSbbuPmch+Yz9T+H7ESFWWQwK4IVchTvLfQsf6+c6dG4lCVu8782uW7Fiy3BPk2/pXuh4
        qNAC+8rj/2v1IWwLHme4+6cM/g373xfh62w7Bi7t+gZ+wpmnkUBPFSFsr8OdV8JviNA5d4WnPO93t
        zfeutG+sWcZsM9iNZbDLBzqSe7uHktsIBuIAkEzV18wmy6yigCP9DTxtUXuHT/0m768nk8BGOLZCD
        4+aRQ6ns9P45VnVWBcEb4yZxtyMntcyM6+VgRcBUXwdqUXNqgwSwHPBbIAhwx3yw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQr-0045LP-2g;
        Tue, 11 Oct 2022 23:04:57 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 31/38] backports: add NLA_POLICY_MIN_LEN()
Date:   Tue, 11 Oct 2022 23:04:39 +0200
Message-Id: <20221011230356.9bce661edbc9.I7e4b8c603be22ac6eee54cbc7b229d3b630f8498@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221011210446.144768-1-johannes@sipsolutions.net>
References: <20221011210446.144768-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 backport/backport-include/net/netlink.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
index e94f32626782..e78a0ff7971c 100644
--- a/backport/backport-include/net/netlink.h
+++ b/backport/backport-include/net/netlink.h
@@ -264,6 +264,8 @@ nla_validate_nested_deprecated(const struct nlattr *start, int maxtype,
 	return __nla_validate_nested(start, maxtype, policy,
 				     NL_VALIDATE_LIBERAL, extack);
 }
+
+#define NLA_POLICY_MIN_LEN(_len)	{ .type = NLA_MIN_LEN, .len = _len }
 #endif /* < 5.2 */
 
 #if LINUX_VERSION_IS_LESS(5,6,0)
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
