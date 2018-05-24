Return-path: <backports-owner@vger.kernel.org>
Received: from mail-he1eur01on0127.outbound.protection.outlook.com ([104.47.0.127]:45152
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965530AbeEXNkm (ORCPT <rfc822;backports@vger.kernel.org>);
        Thu, 24 May 2018 09:40:42 -0400
From: Omer Efrat <omer.efrat@tandemg.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: PCI MSI API support in backports
Date: Thu, 24 May 2018 13:40:38 +0000
Message-ID: <HE1PR0202MB2954E60E8F7C06ED8EEEC5E59A6A0@HE1PR0202MB2954.eurprd02.prod.outlook.com> (sfid-20180524_154320_049952_B1050A84)
References: <HE1PR0202MB2954B6138062CFAF4D2D2BA59A6B0@HE1PR0202MB2954.eurprd02.prod.outlook.com>,<5B055CE7.4000000@broadcom.com>
In-Reply-To: <5B055CE7.4000000@broadcom.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 5/23/2018 3:21 PM, Arend van Spriel wrote:
> Well. I think what you are missing is a wireless driver in linux=20
> upstream. We backport on a as-needed basis so the reason is probably=20
> that none of the upstream drivers require the pci_alloc_irq_vectors()=20
> function. So what wireless driver are we talking about here. Is it a=20
> proprietary driver?

Yes, we are talking about a proprietary driver.
Does that mean I should just add pci_alloc_irq_vectors function myself and =
send it here as a patch?

Best regards,
Omer Efrat.=
--
To unsubscribe from this list: send the line "unsubscribe backports" in
