Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55756 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbeEWMWC (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 23 May 2018 08:22:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id a8-v6so8394176wmg.5
        for <backports@vger.kernel.org>; Wed, 23 May 2018 05:22:01 -0700 (PDT)
Subject: Re: PCI MSI API support in backports
To: Omer Efrat <omer.efrat@tandemg.com>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>
References: <HE1PR0202MB2954B6138062CFAF4D2D2BA59A6B0@HE1PR0202MB2954.eurprd02.prod.outlook.com>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5B055CE7.4000000@broadcom.com> (sfid-20180523_142321_633114_F6BE155F)
Date: Wed, 23 May 2018 14:21:59 +0200
MIME-Version: 1.0
In-Reply-To: <HE1PR0202MB2954B6138062CFAF4D2D2BA59A6B0@HE1PR0202MB2954.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 5/23/2018 1:39 PM, Omer Efrat wrote:
> Our wireless driver uses pci_alloc_irq_vectors function in order to allocate the pci irq vectors.
> (hardware supports MSI, with no MSIx support)
>
> When trying to backport from linux-stable v4.16 to v3.10.104, compilation fails.
> It seems that backports didn't backported pci_alloc_irq_vectors function (introduced at aff171641d181ea573380efc3f559c9de4741fc5 PCI: Provide sensible IRQ vector alloc/free routines), although MSIx APIs are supported in backports.
>
> Is that makes sense?
> Are changes to PCI driver being included in backports by their owners as a workflow?
> Is pci_alloc_irq_vectors function planned to be included in backports?
> Are we missing something?

Well. I think what you are missing is a wireless driver in linux 
upstream. We backport on a as-needed basis so the reason is probably 
that none of the upstream drivers require the pci_alloc_irq_vectors() 
function. So what wireless driver are we talking about here. Is it a 
proprietary driver?

Regards,
Arend

--
To unsubscribe from this list: send the line "unsubscribe backports" in
