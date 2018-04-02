Return-path: <backports-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:37103 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754262AbeDBLUo (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 2 Apr 2018 07:20:44 -0400
Received: by mail-io0-f193.google.com with SMTP id y128so17558654iod.4
        for <backports@vger.kernel.org>; Mon, 02 Apr 2018 04:20:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAAEAJfB76xseRqnYQfRihXY6g0Jyqwt8zfddU1W7CXDg3xEFFg@mail.gmail.com>
References: <CAAEAJfB76xseRqnYQfRihXY6g0Jyqwt8zfddU1W7CXDg3xEFFg@mail.gmail.com>
From: Ratheendran R <ratheendran.s@gmail.com>
Date: Mon, 2 Apr 2018 16:50:43 +0530
Message-ID: <CALM_QrUuDH7dUU9vhyCtx-szsgraMM_=93fcW2PEgu_VagRnpA@mail.gmail.com> (sfid-20180402_132046_582361_4D42E159)
Subject: Re:
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi All,

I am doing a mt7601 backport 4.14 on linux 2.6.37 kernel.

Now when I build the backorts aganist the 2.6.37 linux build I am
getting the below error.
'error: bit-field =E2=80=98<anonymous>=E2=80=99 width not an integer consta=
nt'

compilation error actuals
/home/hitem//software/source/wifi-drivers/backports-4.14-rc2-1/drivers/net/=
wireless/mediatek/mt7601u/main.c:181:3:
error: bit-field =E2=80=98<anonymous>=E2=80=99 width not an integer constan=
t
/home/hitem//software/source/wifi-drivers/backports-4.14-rc2-1/drivers/net/=
wireless/mediatek/mt7601u/main.c:
In function =E2=80=98mt7601u_set_rts_threshold=E2=80=99:
/home/hitem//software/source/wifi-drivers/backports-4.14-rc2-1/drivers/net/=
wireless/mediatek/mt7601u/main.c:329:2:
error: bit-field =E2=80=98<anonymous>=E2=80=99 width not an integer constan=
t
make[8]: *** [/home/hitem//software/source/wifi-drivers/backports-4.14-rc2-=
1/drivers/net/wireless/mediatek/mt7601u/main.o]
Error 1


Can anyone let me know how to fix this.

Thanks in Advance.
Ratheendran

On 3/15/17, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:
> subscribe backports
> --
> To unsubscribe from this list: send the line "unsubscribe backports" in
>
--
To unsubscribe from this list: send the line "unsubscribe backports" in
