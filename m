Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50259 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeDBRT6 (ORCPT
        <rfc822;backports@vger.kernel.org>); Mon, 2 Apr 2018 13:19:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id t67so7202551wmt.0
        for <backports@vger.kernel.org>; Mon, 02 Apr 2018 10:19:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALM_QrUuDH7dUU9vhyCtx-szsgraMM_=93fcW2PEgu_VagRnpA@mail.gmail.com>
References: <CAAEAJfB76xseRqnYQfRihXY6g0Jyqwt8zfddU1W7CXDg3xEFFg@mail.gmail.com>
 <CALM_QrUuDH7dUU9vhyCtx-szsgraMM_=93fcW2PEgu_VagRnpA@mail.gmail.com>
From: Steve deRosier <derosier@gmail.com>
Date: Mon, 2 Apr 2018 10:19:17 -0700
Message-ID: <CALLGbR+g_nWvZUqQeGeCL7NOUG-ErSuc2ov-DWpx1gRkOdpmeA@mail.gmail.com> (sfid-20180402_192001_252132_D821BB7C)
Subject: Re:
To: Ratheendran R <ratheendran.s@gmail.com>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        backports@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

I apologize for the resend... backports ML didn't pick it up because
apparently there's no way to set my tablet's email client to NOT send
HTML emails. Live and learn.

Hi Ratheendran,

On Mon, Apr 2, 2018 at 4:21 AM Ratheendran R <ratheendran.s@gmail.com> wrot=
e:
>
> Hi All,
>
> I am doing a mt7601 backport 4.14 on linux 2.6.37 kernel.
>
> Now when I build the backorts aganist the 2.6.37 linux build I am
> getting the below error.
> 'error: bit-field =E2=80=98<anonymous>=E2=80=99 width not an integer cons=
tant'
>
> compilation error actuals
> /home/hitem//software/source/wifi-drivers/backports-4.14-rc2-1/drivers/ne=
t/wireless/mediatek/mt7601u/main.c:181:3:
> error: bit-field =E2=80=98<anonymous>=E2=80=99 width not an integer const=
ant
> /home/hitem//software/source/wifi-drivers/backports-4.14-rc2-1/drivers/ne=
t/wireless/mediatek/mt7601u/main.c:
> In function =E2=80=98mt7601u_set_rts_threshold=E2=80=99:
> /home/hitem//software/source/wifi-drivers/backports-4.14-rc2-1/drivers/ne=
t/wireless/mediatek/mt7601u/main.c:329:2:
> error: bit-field =E2=80=98<anonymous>=E2=80=99 width not an integer const=
ant
> make[8]: *** [/home/hitem//software/source/wifi-drivers/backports-4.14-rc=
2-1/drivers/net/wireless/mediatek/mt7601u/main.o]
> Error 1


In order to backport 4.14, I assume you=E2=80=99re using a current backport=
s
build. I=E2=80=99m sorry to tell you, but the current version of backports
isn=E2=80=99t supported to backport that far. The backports wiki say we
support only back to 3.0, and IIRC, in more recent descusions, we
abandoned support even back that far. Though I honestly don=E2=80=99t recal=
l
to which version we=E2=80=99re testing for anymore.

No one ever likes this answer (including me), but perhaps you might
consider upgrading your base kernel release. 2.6.37 was released eight
years ago and 37 major version releases happened between there and
4.14. Your version of the kernel is missing support for some major
features and gobs of security fixes. It=E2=80=99ll be hard work to push it
forward eight years, but once you get there, keeping the kernel
up-to-date is pretty easy.

You might get it to work against such an old kernel, but it might take
a bit of work and ingenuity.

Good luck,
- Steve

--
Steve deRosier
Cal-Sierra Consulting LLC
https://www.cal-sierra.com/
--
To unsubscribe from this list: send the line "unsubscribe backports" in
