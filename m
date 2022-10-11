Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62535C4332F
	for <backports@archiver.kernel.org>; Tue, 11 Oct 2022 21:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiJKVEy (ORCPT <rfc822;backports@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJKVEx (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 11 Oct 2022 17:04:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B441115D
        for <backports@vger.kernel.org>; Tue, 11 Oct 2022 14:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=Le9uqRzCtR0A3OYa86sIL1KCdhdtMeF9aYhMYWbY4PY=; t=1665522291; x=1666731891; 
        b=NCfTv3NZU3Bc/UbvebgKRTtjRGR4j6v7nk13xtt4jfB/aEcVHXwpCHdPABwEDf5EzC07TnfHvep
        TQiUD9TVKvfB3wxWE2oTu8xQM0H2fu7JK29rV5m79qHhZUwSYXKgDXFJjSAj37QTceILCEJ2QAAN9
        wyT9esmkzY8S/j/hLtvcQdzAHsO6GD/oH5qzJLsm0k3N0Fi9coBWTTNv95l5Rs+V0UmT/nEcvZnAq
        BRDTHY/1H5eVdFrUfbInwlwZnNCl5Sx5nRn5giqrk8kKuMTNNKg3joCobQfH6qvMCxpj9YTKpaOyS
        2P34voC/6cuYx1dFZm5Bq9W05bi11x8/olEA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oiMQi-0045LP-1T;
        Tue, 11 Oct 2022 23:04:48 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     backports@vger.kernel.org
Cc:     nbd@nbd.name
Subject: [PATCH 00/38] backports updates
Date:   Tue, 11 Oct 2022 23:04:08 +0200
Message-Id: <20221011210446.144768-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

So Felix inspired me to take a look at this ...

This is pretty much not cleaned up, but it's what we have internally
now for iwlwifi.

johannes


--
To unsubscribe from this list: send the line "unsubscribe backports" in
