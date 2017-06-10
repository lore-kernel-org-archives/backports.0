Return-path: <backports-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:35036 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751137AbdFJTn0 (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 10 Jun 2017 15:43:26 -0400
Received: by mail-qt0-f176.google.com with SMTP id w1so98686307qtg.2
        for <backports@vger.kernel.org>; Sat, 10 Jun 2017 12:43:26 -0700 (PDT)
Subject: Re: Possible bug on brcmfmac compat driver
To: "Mario J. Rugiero" <mrugiero@tecnoaccion.com.ar>,
        backports@vger.kernel.org
References: <627ced49-bbf5-3344-c900-bdf77710e489@tecnoaccion.com.ar>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <56a4dee3-566e-3f44-bad3-22c61dbe8836@broadcom.com> (sfid-20170610_214328_503498_12824C4E)
Date: Sat, 10 Jun 2017 21:43:22 +0200
MIME-Version: 1.0
In-Reply-To: <627ced49-bbf5-3344-c900-bdf77710e489@tecnoaccion.com.ar>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 29-05-17 16:43, Mario J. Rugiero wrote:
> When trying to build the SDIO support for this driver, I get a
> redefinition of the function brcmf_proto_bcdc_detach.
> 
> Apparently, CPTCFG_BRCMFMAC_PROTO_BCDC is defined for the makefile, but
> the flag is not being passed to the compilers, so bcdc.h defines the
> stubs instead of declaring the functions to be defined in bcdc.c.

Not sure what is happening. Can you try:

$ make V=1

and share the output in this email thread.

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
