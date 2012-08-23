MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1345721847-9279-1-git-send-email-ozancag@gmail.com>
References: <1345721847-9279-1-git-send-email-ozancag@gmail.com>
Date: Thu, 23 Aug 2012 18:31:30 +0500
Message-ID: <CAB=NE6U1h=5AH4KsO1VSx23QNxOpHrKyA-yPjVfS54kLMq54CQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] compat: Backport USB_VENDOR_AND_INTERFACE_INFO() macro
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Cc: backports@vger.kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Thu, Aug 23, 2012 at 3:37 PM, Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com=
> wrote:
> This backports:
>
> commit d81a5d1956731c453b85c141458d4ff5d6cc5366
> Author: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> Date:   Tue Jul 10 19:10:06 2012 -0300
>
>         USB: add USB_VENDOR_AND_INTERFACE_INFO() macro
>
> which is now used in btusb driver.
>
> $ git describe --contains d81a5d1956731c453b85c141458d4ff5d6cc5366
> v3.6-rc1~101^2~4
>
> Trying kernel 3.5.0-030500-generic [OK]
> Trying kernel 3.4.4-030404-generic [OK]
> Trying kernel 3.3.7-030307-generic [OK]
> Trying kernel 3.2.2-030202-generic [OK]
> Trying kernel 3.1.10-030110-generic [OK]
> Trying kernel 3.0.18-030018-generic [OK]
> Trying kernel 2.6.39-02063904-generic [OK]
> Trying kernel 2.6.38-02063808-generic [OK]
> Trying kernel 2.6.37-02063706-generic [OK]
> Trying kernel 2.6.36-02063604-generic [OK]
> Trying kernel 2.6.35-02063512-generic [OK]
> Trying kernel 2.6.34-02063410-generic [OK]
> Trying kernel 2.6.33-02063305-generic [OK]
> Trying kernel 2.6.32-02063255-generic [OK]
> Trying kernel 2.6.31-02063113-generic [OK]
> Trying kernel 2.6.30-02063010-generic [OK]
> Trying kernel 2.6.29-02062906-generic [OK]
> Trying kernel 2.6.28-02062810-generic [OK]
> Trying kernel 2.6.27-020627-generic [OK]
> Trying kernel 2.6.26-020626-generic [OK]
> Trying kernel 2.6.25-020625-generic [OK]
> Trying kernel 2.6.24-020624-generic [OK]
>
> Signed-off-by: Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com>

Awesome, thanks! Applied and pushed both patches.

  Luis
