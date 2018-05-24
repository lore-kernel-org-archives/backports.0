Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55316 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034514AbeEXTbe (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 24 May 2018 15:31:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id a8-v6so8168056wmg.5
        for <backports@vger.kernel.org>; Thu, 24 May 2018 12:31:33 -0700 (PDT)
Subject: Re: PCI MSI API support in backports
To: Omer Efrat <omer.efrat@tandemg.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
References: <HE1PR0202MB2954B6138062CFAF4D2D2BA59A6B0@HE1PR0202MB2954.eurprd02.prod.outlook.com>
 <5B055CE7.4000000@broadcom.com>
 <HE1PR0202MB2954E60E8F7C06ED8EEEC5E59A6A0@HE1PR0202MB2954.eurprd02.prod.outlook.com>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5B071313.8060206@broadcom.com> (sfid-20180524_213322_279839_F2937A87)
Date: Thu, 24 May 2018 21:31:31 +0200
MIME-Version: 1.0
In-Reply-To: <HE1PR0202MB2954E60E8F7C06ED8EEEC5E59A6A0@HE1PR0202MB2954.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 5/24/2018 3:40 PM, Omer Efrat wrote:
> On 5/23/2018 3:21 PM, Arend van Spriel wrote:
>> Well. I think what you are missing is a wireless driver in linux
>> upstream. We backport on a as-needed basis so the reason is probably
>> that none of the upstream drivers require the pci_alloc_irq_vectors()
>> function. So what wireless driver are we talking about here. Is it a
>> proprietary driver?
>
> Yes, we are talking about a proprietary driver.
> Does that mean I should just add pci_alloc_irq_vectors function myself and send it here as a patch?

You could, but I asked about your driver because the backports project 
exports its symbols using EXPORT_SYMBOL_GPL(). This means that only 
GPL-compatible drivers can use it. This has been a conscious decision 
(see [1]).

Regards,
Arend

[1] https://backports.wiki.kernel.org/index.php/License
--
To unsubscribe from this list: send the line "unsubscribe backports" in
