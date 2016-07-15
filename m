Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34895 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932537AbcGOK4P (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 15 Jul 2016 06:56:15 -0400
Received: by mail-pf0-f177.google.com with SMTP id c2so40634549pfa.2
        for <backports@vger.kernel.org>; Fri, 15 Jul 2016 03:56:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] backports: add definition for USB_SPEED_SUPER_PLUS
To: Hauke Mehrtens <hauke@hauke-m.de>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
References: <1465119005-4161-1-git-send-email-arend.vanspriel@broadcom.com>
 <5c4fbb51-7c91-fab5-a9b4-cc39304aff6f@hauke-m.de>
Cc: backports@vger.kernel.org
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <e342b267-32aa-f5f9-4575-b81a31e93ea0@broadcom.com> (sfid-20160715_125617_777321_A6B86FDC)
Date: Fri, 15 Jul 2016 12:56:06 +0200
MIME-Version: 1.0
In-Reply-To: <5c4fbb51-7c91-fab5-a9b4-cc39304aff6f@hauke-m.de>
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 10-7-2016 23:16, Hauke Mehrtens wrote:
> On 06/05/2016 11:30 AM, Arend van Spriel wrote:
>> Speed definition for usb3.1 has been added in 4.6 kernel. Add
>> definiton for older kernels.
>>
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> ---
>>  backport/backport-include/linux/usb/ch9.h | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/backport/backport-include/linux/usb/ch9.h b/backport/backport-include/linux/usb/ch9.h
>> index 135e24c..c42fc30 100644
>> --- a/backport/backport-include/linux/usb/ch9.h
>> +++ b/backport/backport-include/linux/usb/ch9.h
>> @@ -21,4 +21,8 @@ static inline int usb_endpoint_maxp(const struct usb_endpoint_descriptor *epd)
>>  }
>>  #endif /* < 3.2 */
>>  
>> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4,6,0)
>> +#define USB_SPEED_SUPER_PLUS	(USB_SPEED_SUPER + 1)
>> +#endif /* < 4.6 */
>> +
>>  #endif /* __BACKPORT__LINUX_USB_CH9_H */
>>
> 
> This is in a emum in the mainline kernel. I think this will cause some
> warnings when backporting it this way.

The way it is used in brcmfmac I do not get a warning, but I agree it
would not work if this value is used calling a function that expects
enum usb_device_speed. So how would you backport this?

Regards,
Arend
--
To unsubscribe from this list: send the line "unsubscribe backports" in
