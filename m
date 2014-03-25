Return-path: <backports-owner@vger.kernel.org>
Received: from sabertooth02.qualcomm.com ([65.197.215.38]:28282 "EHLO
	sabertooth02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbaCYJfR (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 25 Mar 2014 05:35:17 -0400
From: Kalle Valo <kvalo@qca.qualcomm.com>
To: Vu Hai NGUYEN <vh.nguyen@actiasodielec.fr>
CC: "ath10k@lists.infradead.org" <ath10k@lists.infradead.org>,
	"Patrick CARNEIRO RODRIGUEZ" <p.carneiro@actiasodielec.fr>,
	<backports@vger.kernel.org>
Subject: Re: RE : Compilation backport ath10k
References: <EE97821C81277E459BEA5C6384C6F241012D6BF72CC8@srvexch01.SODIELEC.local>
	<87lhvy3ewa.fsf@kamboji.qca.qualcomm.com>
	<EE97821C81277E459BEA5C6384C6F241012D6BF72CC9@srvexch01.SODIELEC.local>
Date: Tue, 25 Mar 2014 11:35:11 +0200
In-Reply-To: <EE97821C81277E459BEA5C6384C6F241012D6BF72CC9@srvexch01.SODIELEC.local>
	(Vu Hai NGUYEN's message of "Tue, 25 Mar 2014 10:12:59 +0100")
Message-ID: <8738i639kg.fsf@kamboji.qca.qualcomm.com> (sfid-20140325_103519_783788_74B82363)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Vu Hai NGUYEN <vh.nguyen@actiasodielec.fr> writes:

> After 3 steps above I can obtain 6 module .ko of the driver ath10k
> which have vermagic: 3.2.55
>
> Now when I try to compile ath10k on the kernel 3.2.36 (provided by
> marvell for my pc cible), I repeat 3 steps above but there is some
> warnings in 3th step when I run the command make (you can see it below
> my signature) and I obtain only 2 modules: cfg80211.ko compat.ko
>
> So I supposs that the my kernel 3.2.36 provided from marvell miss
> library to compiled ath10k. Do you guys have some ideas how to fix it?

[...]

> .config:142:warning: symbol value 'm' invalid for OPROFILE
> .config:497:warning: symbol value 'm' invalid for INET_TUNNEL
> .config:498:warning: symbol value 'm' invalid for INET_XFRM_MODE_TRANSPORT
> .config:499:warning: symbol value 'm' invalid for INET_XFRM_MODE_TUNNEL
> .config:500:warning: symbol value 'm' invalid for INET_XFRM_MODE_BEET
> .config:502:warning: symbol value 'm' invalid for INET_DIAG

Thank you, I understand the problem much better now. I'm no backports
expert so I can't really help with this but I'm guessing that the vendor
kernel contains changes which break backports, just like you said.

You might get better help from the backports mailing list, CCed. For
people new to the thread, here's the link to the original mail.

http://lists.infradead.org/pipermail/ath10k/2014-March/001595.html

-- 
Kalle Valo
