Return-Path: <mcgrof+caf_=mcgrof=gmail.com@do-not-panic.com>
Return-Path: <vbmanu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAB=NE6UkcLZv9Wy2k3TTtj+bNZAV667Ejws4bFE=wbmqHBQeXA@mail.gmail.com>
References: <CAFbutietUh=r65eZM7tGG+ST3RhS+pB+RJrX=ZK0jZehEyYaNA@mail.gmail.com>
	<CAB=NE6VDJrNHr130gsiaoGcHOSpRadJYnJjE=qCNW3535LZX1g@mail.gmail.com>
	<CAFbutifjPK3gdYRAQhAeYMJEM5c8=N7_YpSYwTtRg1nZBoEGAA@mail.gmail.com>
	<CAB=NE6X=r=MNHXYCQrR9i4BxDfCVSzO7nF1Nq+n=vXvge-nR0w@mail.gmail.com>
	<CAB=NE6UkcLZv9Wy2k3TTtj+bNZAV667Ejws4bFE=wbmqHBQeXA@mail.gmail.com>
Date: Sat, 9 Mar 2013 02:41:51 +0100
Message-ID: <CAFbutic3M0=LKb=U45+PAxJZGziMxku_C6qcNLrX86R4F77vxA@mail.gmail.com>
Subject: Re: compat-driver doesn't compile
From: Manu <vbmanu@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <backports@vger.kernel.org>

>      >      | What kernel are you on?
>      >      |
>      >      | uname -r
>      >
>      > 3.6.11+

>      What is this + postfix here ? What distribution are you running? Is
>      this a vanilla kernel from kernel.org or some modified Linux
>      distribution kernel? When distributions decide they want to
>      incorporate some behavior from future kernels into older kernels they
>      break proper kernel backport detection / support and this requires
>      manual intervention on compat / compat-drivers. So for example RHEL
>      and SUSE kernels are supported on compat / compat-drivers. Other than
>      that we support vanilla kernels. The better you describe where your
>      kernel came from the better we are able to provide support. Also
>      please note that every single compat-drivers release come already
>      compile tested against all supported kernels: 2.6.24 - 3.9, so hearing
>      a compile issue is odd. One other possibility on a compile issue other
>      than a custom distro hacked kernel is a different kernel
>      configuration. Right now we use a basic desktop type like kernel
>      configuration for our tests.

I'm running Gentoo/arm on RaspberryPi Kernel. I'm not an expert, but I
think the error depends on PCI missing on arm architecture.

>
>      >     | Also please note that compat-drivers-3.9-rc1-1 is out too, you
>      > should upgrade.
>      > compat-drivers-3.9-rc1-2 # ./scripts/driver-select ath  # I need only ar5523
>
>      ar5523 didn't have its own driver-select menu entry but I just added
>      it, that will be part of the new release I'm about to announce, so
>      please use this next but in the meantime please verify the above.

Thanks you very much

2013/3/9 Luis R. Rodriguez <mcgrof@do-not-panic.com>:
> Forgot to add the list. Please never remove the list.
>
>   Luis
>
> On Fri, Mar 8, 2013 at 5:22 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
>> On Fri, Mar 8, 2013 at 4:05 PM, Manu <vbmanu@gmail.com> wrote:
>>>      | What kernel are you on?
>>>      |
>>>      | uname -r
>>>
>>> 3.6.11+
>>
>> What is this + postfix here ? What distribution are you running? Is
>> this a vanilla kernel from kernel.org or some modified Linux
>> distribution kernel? When distributions decide they want to
>> incorporate some behavior from future kernels into older kernels they
>> break proper kernel backport detection / support and this requires
>> manual intervention on compat / compat-drivers. So for example RHEL
>> and SUSE kernels are supported on compat / compat-drivers. Other than
>> that we support vanilla kernels. The better you describe where your
>> kernel came from the better we are able to provide support. Also
>> please note that every single compat-drivers release come already
>> compile tested against all supported kernels: 2.6.24 - 3.9, so hearing
>> a compile issue is odd. One other possibility on a compile issue other
>> than a custom distro hacked kernel is a different kernel
>> configuration. Right now we use a basic desktop type like kernel
>> configuration for our tests.
>>
>>>     | Also please note that compat-drivers-3.9-rc1-1 is out too, you
>>> should upgrade.
>>> compat-drivers-3.9-rc1-2 # ./scripts/driver-select ath  # I need only ar5523
>>
>> ar5523 didn't have its own driver-select menu entry but I just added
>> it, that will be part of the new release I'm about to announce, so
>> please use this next but in the meantime please verify the above.
>>
>>   Luis
