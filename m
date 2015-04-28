Return-path: <backports-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33283 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932657AbbD1K0z (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 Apr 2015 06:26:55 -0400
Received: by pacwv17 with SMTP id wv17so138424071pac.0
        for <backports@vger.kernel.org>; Tue, 28 Apr 2015 03:26:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <553F4460.8000505@broadcom.com>
References: <553ECCC6.2060604@gmail.com> <553F4460.8000505@broadcom.com>
From: Mathy Vanhoef <vanhoefm@gmail.com>
Date: Tue, 28 Apr 2015 12:26:34 +0200
Message-ID: <CAFXAJYzqao1QJc46XmdSohW=7ROo2DXWFT6DBDVmUd=wS+1dPQ@mail.gmail.com> (sfid-20150428_122657_777692_71C2E47A)
Subject: Re: [PATCH] backports: fix high RC version parsing in dependency library
To: Arend van Spriel <arend@broadcom.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 28, 2015 at 10:27 AM, Arend van Spriel <arend@broadcom.com> wrote:
> On 04/28/15 01:56, Mathy Vanhoef wrote:
>>
>> This updates the dependency library to handle RC versions up to 39. For
>> example, coccinelle version "1.0.0" is now correctly treated as being
>> higher
>> than version "1.0.0-rc24".
>
>
> This one is duplicate to the patch Eliad submitted [1]. Any reason for
> choosing rc 40?

I missed that patched. My reasoning was that previously at least the Linux
kernel went up to rc 39 with 2.6.39. So 40 should be a good limit to support
most cases.

Kr,
Mathy

> Regards,
> Arend
>
> [1] http://mid.gmane.org/1430126344-1068-1-git-send-email-eliad@wizery.com
>
>
>> Signed-off-by: Mathy Vanhoef<vanhoefm@gmail.com>
>> ---
>>   lib/bpreqs.py |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/bpreqs.py b/lib/bpreqs.py
>> index 6c46670..4399c6d 100644
>> --- a/lib/bpreqs.py
>> +++ b/lib/bpreqs.py
>> @@ -98,7 +98,7 @@ class Req:
>>                   if (rc == ""):
>>                       rc = 0
>>                   else:
>> -                    rc = int(rc) - 20
>> +                    rc = int(rc) - 40
>>                   extra = int(rc)
>>               else:
>>                   extra = int(rel_specs['EXTRAVERSION']) + 10
>
>
