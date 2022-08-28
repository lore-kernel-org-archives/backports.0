Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AF0ECAAD5
	for <backports@archiver.kernel.org>; Sun, 28 Aug 2022 14:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiH1OXj (ORCPT <rfc822;backports@archiver.kernel.org>);
        Sun, 28 Aug 2022 10:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiH1OXj (ORCPT
        <rfc822;backports@vger.kernel.org>); Sun, 28 Aug 2022 10:23:39 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E76192AC
        for <backports@vger.kernel.org>; Sun, 28 Aug 2022 07:23:37 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id g5-20020a4ac4c5000000b0044af7c8c4b3so1084640ooq.1
        for <backports@vger.kernel.org>; Sun, 28 Aug 2022 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=zYJOH+OofDXb3hw4UkX/+KOtAeI6eoGamp7EUY4RLAs=;
        b=MNvRQprdW5KxdI4pcAJNqQ7ozkCDs4pflVxvq3NgyoLkmXNlyiLm9/aTtaQ5f0xGhH
         G8MCpWG5VTiKpXaG4zLTFgcn24dKTUcci0BqO4OIu+niwOZ8Wz0De4cFJPmgtzloKN0f
         TiT4ipyXPJ1sxcWpSZVtb01R0W3U+HRxGilSgGdU2mrTr+n0WfmHfa6V3xg0wEf/1aur
         qHQhw5EbT2SM0SONYvafAywh/1l5ys+N7UVgzhPM70/1kXcZwRjzAmDLkPbMAj2vFoNJ
         uQe72mzGfsgHH5HHxlClqT8LKYh9pJaJV9ZvuOw2+iR0oN5SM59hQMhPvcxdCnEcc4Cy
         Sm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zYJOH+OofDXb3hw4UkX/+KOtAeI6eoGamp7EUY4RLAs=;
        b=HTYhYbreznArNXxxGjCcFX6a9h0h/TZaReORz4UQQWzMKZPOCKAKqheCEQQyWqkx2U
         iTK3v5+pEkPYo0bO0QhzFbFUYQqfGhUY8fKbBpEb5NrnjHMK/NV4/RcrdA2uiMOy32nM
         vHR0F+NPRefk4eQpxo+egoJxNoqTWUKFABwGCLJQGeiZOGFkx3PGIRCHPHkYIMv4CPkC
         DfO6vRFcAgEGcWTpOYGLv0uMMe7JVSnxBshwt6hTeG0052zEOa0LJatSwKEgQh9xFgVb
         JbhDIkbl40HdYDyhXOst7bYCRuXB09aOWN5fKKmSYBJqXUgsptNoUZmIHPZeQX+tb34b
         8IDw==
X-Gm-Message-State: ACgBeo3HyiJvyGd5buNuI1b2QrepFTNiep45aoLO9lLSsLXYhBa0tjk3
        hXb3VJFRVODbPt5hjNTzuMjm/1D1irHBXgzIsjuFtSDZ9SU=
X-Google-Smtp-Source: AA6agR5GMROx8SEoRnlHWNMG05T1W1mChP0aYu4s6zUFY15qs0SDoLfqjZDS6SAkmtNW8Xk9FZkCL/YcXR3gjDamjYk=
X-Received: by 2002:a4a:abcf:0:b0:428:47bc:4bc0 with SMTP id
 o15-20020a4aabcf000000b0042847bc4bc0mr4213992oon.15.1661696616385; Sun, 28
 Aug 2022 07:23:36 -0700 (PDT)
MIME-Version: 1.0
From:   andy huang <jchuang1977@gmail.com>
Date:   Sun, 28 Aug 2022 22:23:25 +0800
Message-ID: <CAB0h_JxCSZCVNnL+9kcJ401Dtnp6e8BbG-8_1bsM8_e9WopL8Q@mail.gmail.com>
Subject: About the ath11k driver support DBDC chip in openwrt router
To:     backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Hi,

    Recently I want to use WCN6856 on ARM64 platform (kernel 5.4) with
ath11k backports version 5.15.8-1 .

But we can=E2=80=99t bring up 2 radio interfaces concurrently,  once we bri=
ng
up the 5G interface at first then get the =E2=80=9Cdevice busy=E2=80=9D err=
or message
when bring up 2.4G radio.

     But WCN6856 is a DBDC chip, suppose I can bring up two radios in
the same time for AP mode.

      Is it the limitation of driver or HW ?   And how do I fix this issue =
?
Thanks for your time.



Best,

Andy
--
To unsubscribe from this list: send the line "unsubscribe backports" in
