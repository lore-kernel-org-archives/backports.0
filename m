Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34346 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeDDHb3 (ORCPT
        <rfc822;backports@vger.kernel.org>); Wed, 4 Apr 2018 03:31:29 -0400
Received: by mail-wm0-f54.google.com with SMTP id w2so14933743wmw.1
        for <backports@vger.kernel.org>; Wed, 04 Apr 2018 00:31:29 -0700 (PDT)
Subject: Re:
To: Steve deRosier <derosier@gmail.com>,
        Ratheendran R <ratheendran.s@gmail.com>
References: <CAAEAJfB76xseRqnYQfRihXY6g0Jyqwt8zfddU1W7CXDg3xEFFg@mail.gmail.com>
 <CALM_QrUuDH7dUU9vhyCtx-szsgraMM_=93fcW2PEgu_VagRnpA@mail.gmail.com>
 <CALLGbR+g_nWvZUqQeGeCL7NOUG-ErSuc2ov-DWpx1gRkOdpmeA@mail.gmail.com>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        backports@vger.kernel.org
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AC47F4E.60803@broadcom.com> (sfid-20180404_093132_541995_38FD0AD5)
Date: Wed, 4 Apr 2018 09:31:26 +0200
MIME-Version: 1.0
In-Reply-To: <CALLGbR+g_nWvZUqQeGeCL7NOUG-ErSuc2ov-DWpx1gRkOdpmeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 4/2/2018 7:19 PM, Steve deRosier wrote:
> I apologize for the resend... backports ML didn't pick it up because
> apparently there's no way to set my tablet's email client to NOT send
> HTML emails. Live and learn.
>
> Hi Ratheendran,
>
> On Mon, Apr 2, 2018 at 4:21 AM Ratheendran R <ratheendran.s@gmail.com> wrote:
>>
>> Hi All,
>>
>> I am doing a mt7601 backport 4.14 on linux 2.6.37 kernel.
>>
>> Now when I build the backorts aganist the 2.6.37 linux build I am
>> getting the below error.
>> 'error: bit-field ‘<anonymous>’ width not an integer constant'
>>
>> compilation error actuals
>> /home/hitem//software/source/wifi-drivers/backports-4.14-rc2-1/drivers/net/wireless/mediatek/mt7601u/main.c:181:3:
>> error: bit-field ‘<anonymous>’ width not an integer constant
>> /home/hitem//software/source/wifi-drivers/backports-4.14-rc2-1/drivers/net/wireless/mediatek/mt7601u/main.c:
>> In function ‘mt7601u_set_rts_threshold’:
>> /home/hitem//software/source/wifi-drivers/backports-4.14-rc2-1/drivers/net/wireless/mediatek/mt7601u/main.c:329:2:
>> error: bit-field ‘<anonymous>’ width not an integer constant
>> make[8]: *** [/home/hitem//software/source/wifi-drivers/backports-4.14-rc2-1/drivers/net/wireless/mediatek/mt7601u/main.o]
>> Error 1
>
>
> In order to backport 4.14, I assume you’re using a current backports
> build. I’m sorry to tell you, but the current version of backports
> isn’t supported to backport that far. The backports wiki say we
> support only back to 3.0, and IIRC, in more recent descusions, we
> abandoned support even back that far. Though I honestly don’t recall
> to which version we’re testing for anymore.

If my recollection is correct we currently support backports to 3.10 and 
above. Actually, it is in the README. Now the README also refers to the 
wiki for "more-up-to date" information, but for this particular piece of 
information that is not true.

> No one ever likes this answer (including me), but perhaps you might
> consider upgrading your base kernel release. 2.6.37 was released eight
> years ago and 37 major version releases happened between there and
> 4.14. Your version of the kernel is missing support for some major
> features and gobs of security fixes. It’ll be hard work to push it
> forward eight years, but once you get there, keeping the kernel
> up-to-date is pretty easy.
>
> You might get it to work against such an old kernel, but it might take
> a bit of work and ingenuity.

You could try to include mt7601 into a backports-3.14 package, which 
support backporting to 2.6.26. It depends what ieee80211_hw ops it 
implements and what linux infrastructure is used. The bitfields stuff 
would need backporting, which you can probably get from the latest 
backports package. It is going to be a lot more work to get it going so 
the easier path is upgrading your kernel.

Regards,
Arend

--
To unsubscribe from this list: send the line "unsubscribe backports" in
