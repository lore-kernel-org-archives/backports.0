Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:44932 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbaJ1UV3 convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Tue, 28 Oct 2014 16:21:29 -0400
Received: by mail-lb0-f173.google.com with SMTP id l4so1320821lbv.32
        for <backports@vger.kernel.org>; Tue, 28 Oct 2014 13:21:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0BA3FCBA62E2DC44AF3030971E174FB31B5587F6@hasmsx107.ger.corp.intel.com>
References: <0BA3FCBA62E2DC44AF3030971E174FB31B55873E@hasmsx107.ger.corp.intel.com>
 <CAB=NE6XBgHMNyLLS3wwYUh70sugbY0+YrKoBckk5O-tXF68t4Q@mail.gmail.com> <0BA3FCBA62E2DC44AF3030971E174FB31B5587F6@hasmsx107.ger.corp.intel.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 28 Oct 2014 13:21:07 -0700
Message-ID: <CAB=NE6Wh=yhFnxbsTwKun2t8SCbatHYGNYb95sk5ro9qdVGn3A@mail.gmail.com> (sfid-20141028_212131_516929_4FA8FF11)
Subject: Re: failure to build backports on ubuntu
To: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Tue, Oct 28, 2014 at 1:07 PM, Grumbach, Emmanuel
<emmanuel.grumbach@intel.com> wrote:
>>
>> On Tue, Oct 28, 2014 at 10:08 AM, Grumbach, Emmanuel
>> <emmanuel.grumbach@intel.com> wrote:
>> >
>> > I can't make menuconfig. Reverting this patch fixes it.
>>
>> There's no context provided here, gcc version, Linux distribution, etc. With
>> some of that it would help.
>>
>
> * Ubuntu 14.04
> *  gcc -v
> Using built-in specs.
> COLLECT_GCC=/usr/bin/gcc
> COLLECT_LTO_WRAPPER=/usr/lib/gcc/x86_64-linux-gnu/4.8/lto-wrapper
> Target: x86_64-linux-gnu
> Configured with: ../src/configure -v --with-pkgversion='Ubuntu 4.8.2-19ubuntu1' --with-bugurl=file:///usr/share/doc/gcc-4.8/README.Bugs --enable-languages=c,c++,java,go,d,fortran,objc,obj-c++ --prefix=/usr --program-suffix=-4.8 --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --with-gxx-include-dir=/usr/include/c++/4.8 --libdir=/usr/lib --enable-nls --with-sysroot=/ --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --enable-gnu-unique-object --disable-libmudflap --enable-plugin --with-system-zlib --disable-browser-plugin --enable-java-awt=gtk --enable-gtk-cairo --with-java-home=/usr/lib/jvm/java-1.5.0-gcj-4.8-amd64/jre --enable-java-home --with-jvm-root-dir=/usr/lib/jvm/java-1.5.0-gcj-4.8-amd64 --with-jvm-jar-dir=/usr/lib/jvm-exports/java-1.5.0-gcj-4.8-amd64 --with-arch-directory=amd64 --with-ecj-jar=/usr/share/java/eclipse-ecj.jar --enable-objc-gc --enable-multiarch --disable-werror --with-arch-32=i686 --with-abi=m64 --with-multilib-list=m32,m64,mx32 --with-tune=generic --enable-checking=release --build=x86_64-linux-gnu --host=x86_64-linux-gnu --target=x86_64-linux-gnu
> Thread model: posix
> gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1)
>
> I am compiling against 3.16.1
>
> Please let me know what else you want to know.

The kernel solution to this uses an internal kernel variables to
prefix flags for the linker, the solution I provided is supposed to do
that but perhaps for some older linker it doesn't do that, I'm afraid
that since we don't have the internal variable solution and that
porting it would be hard (probably pointless) we'll have to work
around this then as mimicking that won't be easy

Can you try a solution on the backport/kconf/Makefile that see's if
lsb_release is available and use that for older releases of Ubuntu?
I'd try it but since you have the system I figure it'd be easier.

 Luis
