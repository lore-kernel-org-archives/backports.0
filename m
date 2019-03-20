Return-Path: <SRS0=IQna=RX=vger.kernel.org=backports-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2DEC43381
	for <backports@archiver.kernel.org>; Wed, 20 Mar 2019 02:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7A52184D
	for <backports@archiver.kernel.org>; Wed, 20 Mar 2019 02:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfCTCea convert rfc822-to-8bit (ORCPT
        <rfc822;backports@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:34:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57861 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfCTCe3 (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 19 Mar 2019 22:34:29 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1h6R3k-0005j1-3a
        for backports@vger.kernel.org; Wed, 20 Mar 2019 02:34:28 +0000
Received: by mail-wr1-f71.google.com with SMTP id u16so371006wrr.5
        for <backports@vger.kernel.org>; Tue, 19 Mar 2019 19:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g+UV1gdgezk6zxSdac0OQB4FXafCozjqgJtpFR+SNxQ=;
        b=fTz54zGMArcmRGJVVytpriEBwAI8fs/wiD+n3/mimB+Ohs0wvwbCtONIYzR/7MT5JZ
         9sTpO2lyFvmT1uFoSy687ODgnyXc7K3V0JiGrD0JQoW2d/TUXqI8VG+8Juibe+e492DU
         pKRTsF4ohLjVEkpH0LQZlBnpuTpSwsPnaSRx6igS94WfKZ9woRQFpiL3ZptYXwEaQvkW
         JGNJ3iVfJNGF5sGpfAJy1xqxHsGbBX7GPYd3yOMpVXVW4a6QLIsO4V7I1OJvQlPNPV81
         +DQ1sJFFc+PIts0VKPaeX80C/erqOmyzM23QrR/PZnAZxjWZh76noVji/jhGFxIzVDXm
         YmOA==
X-Gm-Message-State: APjAAAUcrYjjZe1IXi91bsNhJ6vUeVSTqq9USNzSNCkAkLTNoqYry45I
        HnrU3Kwd0BMDupaskivthZdtxZPHwpOWBRBIVFVreGLPSyvCCJ56OLavgNEhj3vlh8AlZZ5hAz6
        PejA06u9lYzi734g50rrNoe8ihnkzH9tc3KxBdf96674VbADSw5TiEA==
X-Received: by 2002:a1c:2c4:: with SMTP id 187mr5914422wmc.77.1553049267296;
        Tue, 19 Mar 2019 19:34:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzXYIkmkbt04rQklQE3/G7KrYh5SPXyIe6eO8USAc23itLBf4v1IQmq0ck30nosKlc4kDhPllpmnHkAu4Dw/8c=
X-Received: by 2002:a1c:2c4:: with SMTP id 187mr5914412wmc.77.1553049267107;
 Tue, 19 Mar 2019 19:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190319060915.19849-1-acelan.kao@canonical.com>
 <20190319060915.19849-3-acelan.kao@canonical.com> <c1efbd7a-7bce-2c34-8be8-946c77eecd8e@hauke-m.de>
In-Reply-To: <c1efbd7a-7bce-2c34-8be8-946c77eecd8e@hauke-m.de>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Wed, 20 Mar 2019 10:34:15 +0800
Message-ID: <CAFv23Qmrf69RD2wzsTkMHsVR++ZDT-vFJjzPMgCHConM6_-bmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] backports: update backport/backport-include/net/netlink.h
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: backports-owner@vger.kernel.org
Precedence: bulk
List-ID: <backports.vger.kernel.org>
X-Mailing-List: backports@vger.kernel.org

Right, I'll submit v2 soon.

Hauke Mehrtens <hauke@hauke-m.de> 於 2019年3月20日 週三 上午5:50寫道：
>
> On 3/19/19 7:09 AM, AceLan Kao wrote:
> > Add new macros introduced from
> >    23323289b154 netlink: reduce NLA_POLICY_NESTED{,_ARRAY} arguments
> >
> > Signed-off-by: AceLan Kao <acelan.kao@canonical.com>
> > ---
> >  backport/backport-include/net/netlink.h | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/backport/backport-include/net/netlink.h b/backport/backport-include/net/netlink.h
> > index 4af73631..6f6630ae 100644
> > --- a/backport/backport-include/net/netlink.h
> > +++ b/backport/backport-include/net/netlink.h
> > @@ -59,10 +59,14 @@ struct backport_nla_policy {
> >  #define NLA_POLICY_ETH_ADDR          NLA_POLICY_EXACT_LEN(ETH_ALEN)
> >  #define NLA_POLICY_ETH_ADDR_COMPAT   NLA_POLICY_EXACT_LEN_WARN(ETH_ALEN)
> >
> > -#define NLA_POLICY_NESTED(maxattr, policy) \
> > +#define _NLA_POLICY_NESTED(maxattr, policy) \
> >       { .type = NLA_NESTED, .validation_data = policy, .len = maxattr }
> > -#define NLA_POLICY_NESTED_ARRAY(maxattr, policy) \
> > +#define _NLA_POLICY_NESTED_ARRAY(maxattr, policy) \
> >       { .type = NLA_NESTED_ARRAY, .validation_data = policy, .len = maxattr }
> > +#define NLA_POLICY_NESTED(policy) \
> > +     _NLA_POLICY_NESTED(ARRAY_SIZE(policy) - 1, policy)
> > +#define NLA_POLICY_NESTED_ARRAY(policy) \
> > +     _NLA_POLICY_NESTED_ARRAY(ARRAY_SIZE(policy) - 1, policy)
> >
> >  #define __NLA_ENSURE(condition) (sizeof(char[1 - 2*!(condition)]) - 1)
> >  #define NLA_ENSURE_INT_TYPE(tp)                              \
> >
>
> This is only added for kernel < 4.20, there is a ifdef around, there is
> also a backport needed for kernel 4.20 till 5.0.
>
> Hauke
--
To unsubscribe from this list: send the line "unsubscribe backports" in
