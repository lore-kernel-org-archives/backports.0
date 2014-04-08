Return-path: <backports-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:59841 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755932AbaDHP4u (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 8 Apr 2014 11:56:50 -0400
Message-ID: <53441C3D.8060509@iki.fi> (sfid-20140408_175653_327341_AFA745E2)
Date: Tue, 08 Apr 2014 18:56:45 +0300
From: Antti Palosaari <crope@iki.fi>
MIME-Version: 1.0
To: Mauro Carvalho Chehab <m.chehab@samsung.com>,
	"Luis R. Rodriguez" <mcgrof@do-not-panic.com>
CC: backports@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/12] backports: disable DVB_RTL2832 and DVB_USB_RTL28XXU
References: <1396927943-25589-1-git-send-email-mcgrof@do-not-panic.com> <1396927943-25589-9-git-send-email-mcgrof@do-not-panic.com> <20140408094352.202fabb3@samsung.com>
In-Reply-To: <20140408094352.202fabb3@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Moikka!

On 08.04.2014 15:43, Mauro Carvalho Chehab wrote:
> Em Mon, 07 Apr 2014 20:32:19 -0700
> "Luis R. Rodriguez" <mcgrof@do-not-panic.com> escreveu:
>
>> Commit bcf43393 as of linux-next next-20140320 added this Makefile
>> header extension:
>>
>> ccflags-y += -I$(srctree)/drivers/staging/media/rtl2832u_sdr
>>
>> This ends up calling a staging exported symbol rtl2832_sdr_attach().
>> Let's not pollute driver code with staging code or dependencies.
>>
>> Folks, can this be cleaned up? This sets a precedent for doing more
>> of this, and this can get hairy. Its also not fair for folks who
>> don't want to carry over any staging code. This forces them to, and
>> its not just a header file, its a full exported symbol. What about
>> synchronization with differen trees? Was this addressed with Greg?
>
> The SDR code is at staging not because it has low quality, but because
> we're still testing the SDR API before setting it into a stone.
>
> The rtl2832u can operate in two modes: DVB-T and SDR. On DVB-T,
> the hardware collects samples of a tuned channel and decodes it
> with a hardware decoder, sending to userspace a MPEG TS stream.
>
> On SDR, the hardware decoder is disabled, and the raw samples
> are sent to userspace.
>
> Yet, I agree that, if the SDR code is disabled, the rtl2832_sdr_attach()
> should not be called. However, the code seems to be doing it
> already. Take a look at drivers/staging/media/rtl2832u_sdr/rtl2832_sdr.h:
>
> #if IS_ENABLED(CONFIG_DVB_RTL2832_SDR)
> extern struct dvb_frontend *rtl2832_sdr_attach(struct dvb_frontend *fe,
> 	struct i2c_adapter *i2c, const struct rtl2832_config *cfg,
> 	struct v4l2_subdev *sd);
> #else
> static inline struct dvb_frontend *rtl2832_sdr_attach(struct dvb_frontend *fe,
> 	struct i2c_adapter *i2c, const struct rtl2832_config *cfg,
> 	struct v4l2_subdev *sd)
> {
> 	dev_warn(&i2c->dev, "%s: driver disabled by Kconfig\n", __func__);
> 	return NULL;
> }
> #endif
>
> Antti, please correct if I'm wrong, but the rtl2832u_tuner_attach()
> code seems to not expect that the attach code succeeds. So, the only thing
> that will happen DVB_RTL2832_SDR is disabled is that warning saying that
> SDR is disabled will be sent to dmesg.

That is what happen and IIRC I tested it too once.

> So, I don't see why to disable the entire driver due to that. Instead,
> Just revert changeset bcf43393579e at the backport trees should be enough,
> if don't want to backport the SDR driver.

I will look if I can make mainline rtl28xxu driver compile without a 
staging directory (as that new SDR extension is on staging directory 
currently).


regards
Antti

>
> Regards,
> Mauro
>
>> commit bcf43393579e3d4069e75a9200a87703185bcf11
>> Author: Antti Palosaari <crope@iki.fi>
>> Date:   Tue Sep 10 00:13:57 2013 -0300
>>
>>      [media] rtl28xxu: attach SDR extension module
>>
>>      With that extension module it supports SDR.
>>
>>      Signed-off-by: Antti Palosaari <crope@iki.fi>
>>      Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
>>
>> Cc: Antti Palosaari <crope@iki.fi>
>> Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
>> ---
>>   dependencies | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/dependencies b/dependencies
>> index 6193ed1..b85268d 100644
>> --- a/dependencies
>> +++ b/dependencies
>> @@ -185,8 +185,13 @@ VIDEO_RENESAS_VSP1 3.6
>>   # This was added as of 3.7. Although we should be able to only enable
>>   # this for 3.7 DVB_USB_RTL28XXU ends up selecting DVB_RTL2832 and
>>   # that seems to currently require pegging both.
>> -DVB_RTL2832 3.7
>> -DVB_USB_RTL28XXU 3.7
>> +#
>> +# DVB_USB_RTL28XXU has a nasty ccflag usage thoug that includes staging
>> +# headers introduced via commit bcf43393:
>> +# ccflags-y += -I$(srctree)/drivers/staging/media/rtl2832u_sdr
>> +# Let's not support this nastiness.
>> +DVB_RTL2832 DISABLE
>> +DVB_USB_RTL28XXU DISABLE
>>
>>   # struct gpio_chip only got the required members in 2.6.28
>>   BCMA_DRIVER_GPIO 2.6.28
>
>


-- 
http://palosaari.fi/
