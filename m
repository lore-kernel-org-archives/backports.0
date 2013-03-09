MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <CAFbutic3M0=LKb=U45+PAxJZGziMxku_C6qcNLrX86R4F77vxA@mail.gmail.com>
References: <CAFbutietUh=r65eZM7tGG+ST3RhS+pB+RJrX=ZK0jZehEyYaNA@mail.gmail.com>
	<CAB=NE6VDJrNHr130gsiaoGcHOSpRadJYnJjE=qCNW3535LZX1g@mail.gmail.com>
	<CAFbutifjPK3gdYRAQhAeYMJEM5c8=N7_YpSYwTtRg1nZBoEGAA@mail.gmail.com>
	<CAB=NE6X=r=MNHXYCQrR9i4BxDfCVSzO7nF1Nq+n=vXvge-nR0w@mail.gmail.com>
	<CAB=NE6UkcLZv9Wy2k3TTtj+bNZAV667Ejws4bFE=wbmqHBQeXA@mail.gmail.com>
	<CAFbutic3M0=LKb=U45+PAxJZGziMxku_C6qcNLrX86R4F77vxA@mail.gmail.com>
Date: Sat, 9 Mar 2013 00:16:11 -0800
Message-ID: <CAB=NE6UGHzH_MMkkxO4VX+TfP0XZMh9Laa_DXV=vz8nMfd8p9Q@mail.gmail.com>
Subject: Re: compat-driver doesn't compile
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Manu <vbmanu@gmail.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Fri, Mar 8, 2013 at 5:41 PM, Manu <vbmanu@gmail.com> wrote:
>>      >      | What kernel are you on?
>>      >      |
>>      >      | uname -r
>>      >
>>      > 3.6.11+
>
>>      What is this + postfix here ? What distribution are you running? Is
>>      this a vanilla kernel from kernel.org or some modified Linux
>>      distribution kernel? When distributions decide they want to
>>      incorporate some behavior from future kernels into older kernels they
>>      break proper kernel backport detection / support and this requires
>>      manual intervention on compat / compat-drivers. So for example RHEL
>>      and SUSE kernels are supported on compat / compat-drivers. Other than
>>      that we support vanilla kernels. The better you describe where your
>>      kernel came from the better we are able to provide support. Also
>>      please note that every single compat-drivers release come already
>>      compile tested against all supported kernels: 2.6.24 - 3.9, so hearing
>>      a compile issue is odd. One other possibility on a compile issue other
>>      than a custom distro hacked kernel is a different kernel
>>      configuration. Right now we use a basic desktop type like kernel
>>      configuration for our tests.
>
> I'm running Gentoo/arm on RaspberryPi Kernel. I'm not an expert, but I
> think the error depends on PCI missing on arm architecture.

I don't expect you to be an expert, and supporting RasberryPi's kernel
seems like a worthwhile effort to support, so I'd gladly accept
patches for whoever wants to support that if the kernel can be
identified somehow.

  Luis
