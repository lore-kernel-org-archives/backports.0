Return-path: <backports-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:51327 "EHLO hauke-m.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030833AbbD1U3H (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 28 Apr 2015 16:29:07 -0400
Message-ID: <553FED90.9030301@hauke-m.de> (sfid-20150428_222909_614906_6D8B8824)
Date: Tue, 28 Apr 2015 22:29:04 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Eliad Peller <eliad@wizery.com>, Mathy Vanhoef <vanhoefm@gmail.com>
CC: Arend van Spriel <arend@broadcom.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>, backports@vger.kernel.org
Subject: Re: [PATCH] backports: fix high RC version parsing in dependency
 library
References: <553ECCC6.2060604@gmail.com>	<553F4460.8000505@broadcom.com>	<CAFXAJYzqao1QJc46XmdSohW=7ROo2DXWFT6DBDVmUd=wS+1dPQ@mail.gmail.com> <CAB3XZEcKBYpxZ8EZnBQX+q1mcX6myLwgzKu=tXKPcESX1bFzsw@mail.gmail.com>
In-Reply-To: <CAB3XZEcKBYpxZ8EZnBQX+q1mcX6myLwgzKu=tXKPcESX1bFzsw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 04/28/2015 02:25 PM, Eliad Peller wrote:
> On Tue, Apr 28, 2015 at 1:26 PM, Mathy Vanhoef <vanhoefm@gmail.com> wrote:
>> On Tue, Apr 28, 2015 at 10:27 AM, Arend van Spriel <arend@broadcom.com> wrote:
>>> On 04/28/15 01:56, Mathy Vanhoef wrote:
>>>>
>>>> This updates the dependency library to handle RC versions up to 39. For
>>>> example, coccinelle version "1.0.0" is now correctly treated as being
>>>> higher
>>>> than version "1.0.0-rc24".
>>>
>>>
>>> This one is duplicate to the patch Eliad submitted [1]. Any reason for
>>> choosing rc 40?
>>
>> I missed that patched. My reasoning was that previously at least the Linux
>> kernel went up to rc 39 with 2.6.39. So 40 should be a good limit to support
>> most cases.
>>
> note that 39 in this case is the "sublevel", not the "extraversion".
> 
> Eliad.

I will take your patch Eliad. There are so many magic numbers in this
code it probably has to get cleaned up, a warning for such a case like
we have it now would also be nice.

Hauke

