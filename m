Return-path: <backports-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34924 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbaEBIgc (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 2 May 2014 04:36:32 -0400
Received: by mail-wg0-f43.google.com with SMTP id l18so3227191wgh.2
        for <backports@vger.kernel.org>; Fri, 02 May 2014 01:36:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140502013948.GH957@garbanzo.do-not-panic.com>
References: <CAFjWW+ZsCZpmh-CVWX9Y+73tOAS5JG5f7mvrr8biAVgN_a+Fng@mail.gmail.com>
	<20140502013948.GH957@garbanzo.do-not-panic.com>
Date: Fri, 2 May 2014 01:36:30 -0700
Message-ID: <CAFjWW+ZzSvWzAWOC3dzDPujszXYs-pHkSr7wNiLJwwc3a-+-wQ@mail.gmail.com> (sfid-20140502_103635_395744_B87B3AFC)
Subject: Re: 3.14-1 Compile Problem for 2.6.39.4 Kernel
From: Aaron Hamilton <aaron@logicdatasystems.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

If I recall correctly, I was able to get this to compile by enabling
CONFIG_CRYPTO_CCM in my kernel. Without it, it won't compile.

On Thu, May 1, 2014 at 6:39 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> On Tue, Apr 29, 2014 at 02:39:11AM -0700, Aaron Hamilton wrote:
>> In trying to compile backports-3.14-1 with a 2.6.39.4 kernel, I get
>> the following compilation errors:
>>
>> backport-include/linux/compat.h:18: error: expected ';', ',' or ')'
>> before '*' token
>>
>> If I comment out line 18 in compat.h which just reads "extern int
>> compat_put_timespec(const struct timespec*, void __user *)", then I
>> get past that error.
>>
>> Next, things get stuck on compat/crypto-ccm.c on lines 250 and 255,
>> stating "too few arguments to function 'scatterwalk_map'" and "too few
>> arguments to function 'scatterwalk_unmap'".
>>
>> My kernel headers indicate this function takes two parameters and I
>> can't find anything in backports that specify otherwise. Am I missing
>> something?
>
> Yeah odd, I see what you are seeing but then I looked at upstream
> v3.14.2 code and see only one argument.
>
> The commit that caused this change:
>
> mcgrof@ergon ~/linux-stable (git::linux-3.14.y)$ git describe --contains f0dfc0b0
> v3.4-rc1~174^2~50
>
> So its been there for a while now, so surprised we haven't had to
> resolve this earlier, we also don't have patches that modify this so
> its a bit unclear how this has happened. The backports file versions
> does have:
>
> BACKPORTS_VERSION="v3.14-1-0-g369d49a"
> BACKPORTED_KERNEL_VERSION="v3.14-0-g455c6fd"
> BACKPORTED_KERNEL_NAME="Linux"
>
> And v3.14-0-g455c6fd is == v3.14
>
> The upstream code for v3.14 on crypto/ccm.c has scatterwalk_map() with
> one argument. What we do is copy it over directly from the upstream
> source the only patch we have to modify it is within the backports
> git tree we use patches/backport-adjustments/crypto-ccm.patch, this
> however does not touch scatterwalk_map() usage...
>
> This *should* have triggered a compile failure when we had tested this..
> Going to run another test now.
>
>   Luis
