Return-path: <backports-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33706 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965631AbbD1MZS (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 Apr 2015 08:25:18 -0400
Received: by igbpi8 with SMTP id pi8so87243347igb.0
        for <backports@vger.kernel.org>; Tue, 28 Apr 2015 05:25:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFXAJYzqao1QJc46XmdSohW=7ROo2DXWFT6DBDVmUd=wS+1dPQ@mail.gmail.com>
References: <553ECCC6.2060604@gmail.com>
	<553F4460.8000505@broadcom.com>
	<CAFXAJYzqao1QJc46XmdSohW=7ROo2DXWFT6DBDVmUd=wS+1dPQ@mail.gmail.com>
Date: Tue, 28 Apr 2015 15:25:17 +0300
Message-ID: <CAB3XZEcKBYpxZ8EZnBQX+q1mcX6myLwgzKu=tXKPcESX1bFzsw@mail.gmail.com> (sfid-20150428_142550_568902_9F0FA007)
Subject: Re: [PATCH] backports: fix high RC version parsing in dependency library
From: Eliad Peller <eliad@wizery.com>
To: Mathy Vanhoef <vanhoefm@gmail.com>
Cc: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Apr 28, 2015 at 1:26 PM, Mathy Vanhoef <vanhoefm@gmail.com> wrote:
> On Tue, Apr 28, 2015 at 10:27 AM, Arend van Spriel <arend@broadcom.com> wrote:
>> On 04/28/15 01:56, Mathy Vanhoef wrote:
>>>
>>> This updates the dependency library to handle RC versions up to 39. For
>>> example, coccinelle version "1.0.0" is now correctly treated as being
>>> higher
>>> than version "1.0.0-rc24".
>>
>>
>> This one is duplicate to the patch Eliad submitted [1]. Any reason for
>> choosing rc 40?
>
> I missed that patched. My reasoning was that previously at least the Linux
> kernel went up to rc 39 with 2.6.39. So 40 should be a good limit to support
> most cases.
>
note that 39 in this case is the "sublevel", not the "extraversion".

Eliad.
