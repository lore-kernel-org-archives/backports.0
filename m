Return-path: <backports-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36851 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbcKYBY5 (ORCPT
        <rfc822;backports@vger.kernel.org>); Thu, 24 Nov 2016 20:24:57 -0500
Received: by mail-oi0-f41.google.com with SMTP id v84so66855170oie.3
        for <backports@vger.kernel.org>; Thu, 24 Nov 2016 17:24:57 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?Q?Franti=C5=A1ek_Hor=C3=ADnek?=
        <frantisekhorinek@gmail.com>
Date: Fri, 25 Nov 2016 02:24:56 +0100
Message-ID: <CAHU8GYNVMkbEH-Vp06DsKVV-x5nwfSMXL_fowOWMQoswTHfNyA@mail.gmail.com> (sfid-20161125_022459_769208_EDE7918F)
Subject: unknown symbol CRYPTO_GCM
To: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hello,

I am trying to install driver RTL8192CU but i was unable to locate the driv=
er.
I found out that RTL8192CU depends on RTL_CARDS and RTL_CARDS depends
on MAC80211.
MAC80211 is not visible in menu due its dependency on CRYPTO_GCM.

The problem is that symbol CRYPTO_GCM is unknown and therefor I can't enabl=
e it.

When I tried to create CRYPTO_GCM as bool the compilation failed:
/root/backports-4.2.6-1/compat/crypto-ccm.c: In function =E2=80=98crypto_cc=
m_init_tfm=E2=80=99:
/root/backports-4.2.6-1/compat/crypto-ccm.c:487:2: error: implicit
declaration of function =E2=80=98crypto_aead_set_reqsize=E2=80=99
[-Werror=3Dimplicit-function-declaration]
  crypto_aead_set_reqsize(__crypto_aead_cast(tfm),

there is also a warning before build:
warning: (MAC80211 && MAC802154) selects BPAUTO_CRYPTO_CCM which has
unmet direct dependencies (CRYPTO_AEAD && CRYPTO_CTR)

I am using backports-4.2.6-1 downloaded today (25. 11. 2016)

What should I do?

Thank you for your help.

--
Franti=C5=A1ek Hor=C3=ADnek
--
To unsubscribe from this list: send the line "unsubscribe backports" in
