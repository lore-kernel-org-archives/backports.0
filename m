Return-path: <backports-owner@vger.kernel.org>
Received: from mail-db5eur01on0104.outbound.protection.outlook.com ([104.47.2.104]:56416
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932543AbeEWLjJ (ORCPT <rfc822;backports@vger.kernel.org>);
        Wed, 23 May 2018 07:39:09 -0400
From: Omer Efrat <omer.efrat@tandemg.com>
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: PCI MSI API support in backports
Date: Wed, 23 May 2018 11:39:05 +0000
Message-ID: <HE1PR0202MB2954B6138062CFAF4D2D2BA59A6B0@HE1PR0202MB2954.eurprd02.prod.outlook.com> (sfid-20180523_134025_860338_4B4A861E)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Our wireless driver uses pci_alloc_irq_vectors function in order to allocat=
e the pci irq vectors.
(hardware supports MSI, with no MSIx support)

When trying to backport from linux-stable v4.16 to v3.10.104, compilation f=
ails.
It seems that backports didn't backported pci_alloc_irq_vectors function (i=
ntroduced at aff171641d181ea573380efc3f559c9de4741fc5 PCI: Provide sensible=
 IRQ vector alloc/free routines), although MSIx APIs are supported in backp=
orts.

Is that makes sense?
Are changes to PCI driver being included in backports by their owners as a =
workflow?
Is pci_alloc_irq_vectors function planned to be included in backports?
Are we missing something?

Best regards,
Omer Efrat.=
--
To unsubscribe from this list: send the line "unsubscribe backports" in
