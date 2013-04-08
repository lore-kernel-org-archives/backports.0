Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:38464 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935713Ab3DHT2a (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Apr 2013 15:28:30 -0400
Received: by mail-lb0-f171.google.com with SMTP id v10so6130831lbd.16
        for <backports@vger.kernel.org>; Mon, 08 Apr 2013 12:28:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365416773-12836-1-git-send-email-thierry.escande@linux.intel.com>
References: <1365416773-12836-1-git-send-email-thierry.escande@linux.intel.com>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Mon, 8 Apr 2013 12:28:08 -0700
Message-ID: <CAB=NE6X_gaL99LLsB-FqDwShqZ08CCFR+4KjNuremdefO_O0Ug@mail.gmail.com> (sfid-20130408_212844_658236_AFD91CE7)
Subject: Re: [PATCH v3 0/8] backports: add NFC subsystem
To: Thierry Escande <thierry.escande@linux.intel.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Apr 8, 2013 at 3:26 AM, Thierry Escande
<thierry.escande@linux.intel.com> wrote:
> This adds support for NFC core and drivers backport down to v3.1. Prior kernel
> versions won't support it as is since PF_NFC net proto as been introduced in
> v3.1 and sock_register kernel api in prior kernels will fail for PF_NFC.
>
> $ckmake --defconfig nfc

I think using this makes sense for testing *your* development work but
for integration upstream I'd prefer to see a full ckmake test. We can
get you access to the build box to help with this, or Johannes can
also run it prior to integration.

  Luis
