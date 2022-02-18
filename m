Return-Path: <backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A9CC433EF
	for <backports@archiver.kernel.org>; Fri, 18 Feb 2022 21:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbiBRV6u (ORCPT <rfc822;backports@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:58:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240066AbiBRV6t (ORCPT
        <rfc822;backports@vger.kernel.org>); Fri, 18 Feb 2022 16:58:49 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2084D60DBE
        for <backports@vger.kernel.org>; Fri, 18 Feb 2022 13:58:32 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m14so7888918lfu.4
        for <backports@vger.kernel.org>; Fri, 18 Feb 2022 13:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yFyc/k2kyNpki/8Zv9FR2+5zEzXg2TxGbVbTY7NG5tk=;
        b=DLEN3PaS/onUhqlW/Qo+em5hoMX7368KrdWDlRcu+LOSiztXGmbECV6PioXO4xTezD
         1vzUC325kNxpDbVG+rJ2FvQ9947ay75wWv3jZFqS0AqGR9QpRWhvnezVqIpejZBuqbMs
         oG84DbPRXVgjXYQumiEPq5dqH702PelnBuJpmJC62ngombqxTCDA2sIVBctcDpzsrI47
         2J0F0BnZeGEnU/527i/FwKA5HzJABT0OSQRR3e+F9O0KChZg+oIicQC0SAMzHrUpsT6T
         3iW0BlNjNThz81sItFJbhrQyKeUcu3j1sQzlV0Mp33opCC2JL8stOcF2qsgr4YNWKVLK
         Mwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yFyc/k2kyNpki/8Zv9FR2+5zEzXg2TxGbVbTY7NG5tk=;
        b=5gArpWHVFTP0wRQUG1tm7f5gGw8pgdODlzkP4tIcDXiHc3LFsa91mUdKxaW4GoRa1A
         QahjtQ7cRwpPVTidFb8E2VP/B7CVNgN/C6iBP6dUiSLSgZ/BWPVPeitPCaGpidbAuM5b
         sZFvokkaSx+WD1Ze9xOOxeqxDzx9lJwVrIxos1XlJfEdLw00D/e+1uVj4pBP41Mu+DuO
         S7YORYLoV5Y6cHCFQxLf2ig7UYm2fQcf9e8qOiTcH5L5nEWDN95kDgig7rkeNmq/chdf
         9p/ZdRjYpPNzFb9vGR/T5aNLCUTGrWelKV12PE4+ZJulZfpv78nBzeT/e1pSYZnpMLWR
         SZTA==
X-Gm-Message-State: AOAM533AOeHC+b7X//90iXIWSFfmi8GDREUXFp5/gmyg33bXOfHZmQ3U
        n5WuqxKjJ1qnHcRnZKbPYWm6AZRQ8XY7BLuV82qnUBq4
X-Google-Smtp-Source: ABdhPJzXF661XAqy4kNwjDcV9/FdNcM1TJcruxh+agGM4hLYpnqOCmdr7vDmGi4PdWy3mQ9cavQrDC3LyMd1tGMpSsE=
X-Received: by 2002:ac2:410d:0:b0:443:7e85:2a4 with SMTP id
 b13-20020ac2410d000000b004437e8502a4mr6780519lfi.220.1645221510395; Fri, 18
 Feb 2022 13:58:30 -0800 (PST)
MIME-Version: 1.0
References: <20220218191038.42064-1-Mathy.Vanhoef@kuleuven.be> <c6a849a834d6aaf4bf523ad1c0729cb76e44c449.camel@sipsolutions.net>
In-Reply-To: <c6a849a834d6aaf4bf523ad1c0729cb76e44c449.camel@sipsolutions.net>
From:   Mathy Vanhoef <vanhoefm@gmail.com>
Date:   Fri, 18 Feb 2022 22:58:19 +0100
Message-ID: <CAFXAJYz-1AmXn1FDH8DGZxKSafkR=kiq5G-YQhuNse4pHniFqQ@mail.gmail.com>
Subject: Re: [PATCH] backports: Update hwsim defconfig
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

> > -CPTCFG_CFG80211_WEXT=y
> > +CPTCFG_CFG80211_WEXT=n
>
> But does that even work? I thought it had to be like this:
>
> >  # CPTCFG_MAC80211_RC_PID is not set
> >

I think you're right, specifying "=n" is the wrong way.

Somehow doing that did disable WEXT for me, but that likely was
specific to my setup.
--
To unsubscribe from this list: send the line "unsubscribe backports" in
