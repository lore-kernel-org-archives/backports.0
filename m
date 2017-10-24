Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([144.76.63.242]:33792 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932173AbdJXLMm (ORCPT
        <rfc822;backports@vger.kernel.org>); Tue, 24 Oct 2017 07:12:42 -0400
Message-ID: <1508843560.2639.28.camel@sipsolutions.net> (sfid-20171024_131243_858493_ECB135F8)
Subject: Re: Compiling error of backport-4.12.c
From: Johannes Berg <johannes@sipsolutions.net>
To: =?UTF-8?Q?=E5=90=B3=E9=87=8D=E6=AF=85?= <uranus0206@gmail.com>,
        backports@vger.kernel.org
Date: Tue, 24 Oct 2017 13:12:40 +0200
In-Reply-To: <CAN+BLYGmKpHm+iJOMynv6Qhvyh=ECaJnAM96QiU=LptiisW0xw@mail.gmail.com> (sfid-20171024_123805_971082_E604BA18)
References: <CAN+BLYGmKpHm+iJOMynv6Qhvyh=ECaJnAM96QiU=LptiisW0xw@mail.gmail.com>
         (sfid-20171024_123805_971082_E604BA18)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, 2017-10-24 at 18:37 +0800, 吳重毅 wrote:
> 
> /home/chungyi/backport_test/compat/backport-4.12.c:49:27: error:
> lvalue required as left operand of assignment
>    genl_info_userhdr(info) = ERR_PTR(-ENOMEM);
>                            ^

Huh, my mistake, I'll fix that.

johannes
--
To unsubscribe from this list: send the line "unsubscribe backports" in
