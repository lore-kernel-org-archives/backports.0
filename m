Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FEEC4167E
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJKVFZ (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJKVFF (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:05:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7874E20BD8
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=RRTIOn6m3iOX+yq0CE05lkLv2Ooq50gGvj98b6ViYIE=;
        t=1665522301; x=1666731901; b=Eck+EESsC5W+JSO/6dyuSNVadPq54quC3kbNzFBfpC0Gb1k
        bq/ufLVuOYGuSGBiKO/beriy6nJemZUBHUZ5B59xBrHx44hmjF/4eLuuhvZwljAFKMKRX4VegefKa
        03nbPHsIgcadetNvL5GSkK1+AJ9ddG2eO7q2k00ckzshkc8X/5QqPb0IqP704i7lUTUIRewj+hfFD
        yrFeCogFnwgaJsxLkpT+szLRqNsfiA1LomHPRdyGz+WXbcWxb+0DtrZWlkPQyTIHfbs9rwS0DbVDy
        935GVcGIAaH7Umz63lFkO3vEO297oayhTOudaZN5CNPLTsdwyb7OF9vzj522Hg8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQs-0045LP-2i;
        Tue, 11 Oct 2022 23:04:58 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 34/38] backports: add id_2 argument to find_asymmetric_key()
Date:   Tue, 11 Oct 2022 23:04:42 +0200
Message-Id: <20221011230356.c5a37c34a011.I0bc338dbb6b1c91bdd54cf656ab41d09f05b8248@changeid>
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
 backport/backport-include/keys/asymmetric-type.h | 1 +
 backport/compat/verification/key.c               | 1 +
 2 files changed, 2 insertions(+)

diff --git a/backport/backport-include/keys/asymmetric-type.h b/backport/backport-include/keys/asymmetric-type.h
index 5744de9cee0f..35ddd4008c60 100644
--- a/backport/backport-include/keys/asymmetric-type.h
+++ b/backport/backport-include/keys/asymmetric-type.h
@@ -30,6 +30,7 @@ asymmetric_key_generate_id(const void *val_1, size_t len_1,
 extern struct key *find_asymmetric_key(struct key *keyring,
 				       const struct asymmetric_key_id *id_0,
 				       const struct asymmetric_key_id *id_1,
+				       const struct asymmetric_key_id *id_2,
 				       bool partial);
 #endif
 #endif /* __BP_ASYMMETRIC_TYPE_H */
diff --git a/backport/compat/verification/key.c b/backport/compat/verification/key.c
index 329f8b22e41f..f95aca4fca0e 100644
--- a/backport/compat/verification/key.c
+++ b/backport/compat/verification/key.c
@@ -129,6 +129,7 @@ EXPORT_SYMBOL_GPL(bp_key_create_or_update);
 struct key *find_asymmetric_key(struct key *keyring,
 				const struct asymmetric_key_id *id_0,
 				const struct asymmetric_key_id *id_1,
+				const struct asymmetric_key_id *id_2,
 				bool partial)
 {
 	struct key *key;
-- 
2.37.3

--
To unsubscribe from this list: send the line "unsubscribe backports" in
