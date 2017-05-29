Return-path: <backports-owner@vger.kernel.org>
Received: from mailta.tecnoaccion.com.ar ([200.51.197.4]:41920 "EHLO
        mailta.tecnoaccion.com.ar" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbdE2PMz (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 29 May 2017 11:12:55 -0400
Received: from [192.168.59.121] (static.43.247.104.190.cps.com.ar [190.104.247.43] (may be forged))
        (authenticated bits=0)
        by mailta.tecnoaccion.com.ar (8.14.4/8.14.4) with ESMTP id v4TEhmYF012972
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
        for <backports@vger.kernel.org>; Mon, 29 May 2017 11:44:00 -0300
To: backports@vger.kernel.org
From: "Mario J. Rugiero" <mrugiero@tecnoaccion.com.ar>
Subject: Possible bug on brcmfmac compat driver
Message-ID: <627ced49-bbf5-3344-c900-bdf77710e489@tecnoaccion.com.ar> (sfid-20170529_171301_267226_965F5392)
Date: Mon, 29 May 2017 11:43:48 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

When trying to build the SDIO support for this driver, I get a 
redefinition of the function brcmf_proto_bcdc_detach.

Apparently, CPTCFG_BRCMFMAC_PROTO_BCDC is defined for the makefile, but 
the flag is not being passed to the compilers, so bcdc.h defines the 
stubs instead of declaring the functions to be defined in bcdc.c.

--
To unsubscribe from this list: send the line "unsubscribe backports" in
