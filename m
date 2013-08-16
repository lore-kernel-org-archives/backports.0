Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:53932 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753878Ab3HPNQX (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 Aug 2013 09:16:23 -0400
Message-ID: <520E261B.9070304@hauke-m.de> (sfid-20130816_151639_498161_0FAEF5D9)
Date: Fri, 16 Aug 2013 15:16:11 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Solomon Peachy <pizza@shaftnet.org>
CC: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backports:  Add patch for cw1200_sdio with kernels
 < 3.2
References: <1376571357-16506-1-git-send-email-pizza@shaftnet.org> <1376571357-16506-2-git-send-email-pizza@shaftnet.org> <20130816030715.GB9574@garbanzo.do-not-panic.com> <520E012F.6020108@hauke-m.de> <20130816114726.GC28867@shaftnet.org>
In-Reply-To: <20130816114726.GC28867@shaftnet.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/16/2013 01:47 PM, Solomon Peachy wrote:
> On Fri, Aug 16, 2013 at 12:38:39PM +0200, Hauke Mehrtens wrote:
>> I just compile tested cw1200 against many kernel versions and I
>> always get an error of a missing symbol for kernel <= 3.9:
>> 
>> WARNING: "get_random_int" 
>> [/pub/mem/hauke/devel/tmp/.tmp.ckmake/3.4.56/drivers/net/wireless/cw1200/cw1200_core.ko]
>>
>> 
undefined!
> 
> Argh, it wasn't an exported symbol in older kernels.  (How did this
> ever work for me on my 3.4 testbed?)

I tested this on an amd64 system, it could be that it works on some
other archs.

> Hmm.  Rather than patching cw1200 to use get_random_bytes(), would
> it make more sense to add a backported version of this to 
> compat-3.8 instead?

Yes you should put it into backport/compat/backport-3.10.c.
I am still wondering if get_random_int() is needed for such an
algorithm at all.

>> I deactivate compiling against older kernels than 3.6.39 because
>> that caused some other problems like starting with 3.6.37 and
>> missing hw_features in 2.6.38:
>> 
>> drivers/net/wireless/cw1200/bh.c: In function
>> ‘cw1200_register_bh’: drivers/net/wireless/cw1200/bh.c:62:72:
>> error: ‘WQ_CPU_INTENSIVE’ undeclared (first use in this
>> function) drivers/net/wireless/cw1200/bh.c:62:72: note: each
>> undeclared identifier is reported only once for each function it
>> appears in make[7]: *** [/drivers/net/wireless/cw1200/bh.o] Error
>> 1
> 
> IIRC this was actually defined in 2.6.36. I have another patch
> (stripped via the mainlining effort) that implements this
> functionality via kthreads for <=2.6.35 kernels.  (Given that the
> new workqueue semantics were backported, I'd hoped to retire this
> patch...)
> 
> I'll go through the 'ckmake' process, and post any necessary
> patches to get cw1200 to cleanly build at least as far back as
> 2.6.35.

I uploaded a logfile with some error messages:
http://hauke-m.de/files/compat-wireless/ckmake.log

Hauke
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSDiYbAAoJEIZ0px9YPRMyM7UP/AtPam8sVOqlnXaNUzRtr4fi
1JXy4Ec89o7yt8t3yhnn034yd7gnSw6bt1AlQwRNRtcasvtS9hDge9JZ2XBFSQP0
zDHzz38K3v149dG0CIuV+o+C+804KLVhbFHMfYoIur8XgS17T4hQgurZDENb8Iv2
EfI1asWNtjWfw9tSURkGHoZoJj9A17e4fEIBY8JuURCfewMAxIjcbV2VrrmNF2ZE
kzuFk6xW/dQVeWBFRMTOHj0lVkAR5DtVcFJR0cM9ZnxCZdAMpLAvAtOspm1Hf111
DdLlCtLJYRpaW6RIPtKOx1XJfltyVYP41DetVmAWnTnBhexFybHk8DVDmhKjTED2
sTPWUK8B6RT3VYHf8tzJISJxJWmH5N7F7Cv4dA+Bqqb8gs93UlggHu0GdFiT7XGF
1ao1vWpUq/eN+ya9cunE7BCG4hgawJL8xYnzwQEV0mhSLJCQb6518WXB6FlKqWZM
c96S8SdNSbKgdr0ls3OFYFSqNct0TN5o5qMYZEUCIiNmsMi5neRt2fHsE97YuPpY
QcJcQZglYNrO0bnIZTGSK+Gc0ZXMjADOokgY4swGSg0C4RiqGhSa0TJ87BExeDAn
18YldR3j7yuc9oC5oAwPWnL3oW3+8uEyR2qoQKTmJdXTSYFHU05iyHL3wxccH4Bv
bT/MufoA/VYj9tPe9SWn
=aRf8
-----END PGP SIGNATURE-----
