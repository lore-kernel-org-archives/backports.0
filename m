Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:56321 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753076Ab3HQASo (ORCPT <rfc822;backports@vger.kernel.org>);
	Fri, 16 Aug 2013 20:18:44 -0400
Message-ID: <520E8E46.8090004@hauke-m.de> (sfid-20130817_021857_376914_740581C7)
Date: Fri, 16 Aug 2013 22:40:38 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Solomon Peachy <pizza@shaftnet.org>
CC: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	backports@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backports:  Add patch for cw1200_sdio with kernels
 < 3.2
References: <1376571357-16506-1-git-send-email-pizza@shaftnet.org> <1376571357-16506-2-git-send-email-pizza@shaftnet.org> <20130816030715.GB9574@garbanzo.do-not-panic.com> <520E012F.6020108@hauke-m.de> <20130816114726.GC28867@shaftnet.org> <520E261B.9070304@hauke-m.de> <20130816142318.GA6262@shaftnet.org>
In-Reply-To: <20130816142318.GA6262@shaftnet.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/16/2013 04:23 PM, Solomon Peachy wrote:
> On Fri, Aug 16, 2013 at 03:16:11PM +0200, Hauke Mehrtens wrote:
>> I tested this on an amd64 system, it could be that it works on
>> some other archs.
> 
> Yeah, I was building this on arm.
> 
>> Yes you should put it into backport/compat/backport-3.10.c. I am
>> still wondering if get_random_int() is needed for such an 
>> algorithm at all.
> 
> I'm not sure what you mean by this.  This is get_random_int() in
> current kernels: (copied from 3.11-rc)
> 
> /* * Get a random word for internal kernel use only. Similar to
> urandom but * with the goal of minimal entropy pool depletion. As a
> result, the random * value is not cryptographically secure but for
> several uses the cost of * depleting entropy is too high */ static
> DEFINE_PER_CPU(__u32 [MD5_DIGEST_WORDS], get_random_int_hash); 
> unsigned int get_random_int(void) { __u32 *hash; unsigned int ret;
> 
> if (arch_get_random_int(&ret)) return ret;
> 
> hash = get_cpu_var(get_random_int_hash);
> 
> hash[0] += current->pid + jiffies + get_cycles(); 
> md5_transform(hash, random_int_secret); ret = hash[0]; 
> put_cpu_var(get_random_int_hash);
> 
> return ret; }
> 
> The cw1200 driver calls get_random_int() on every tx paket when
> there is QoS/queue contention to determine random backoff
> intervals.  The numbers don't need to be cryptographically secure,
> just "different" -- and there's really no point in sucking the
> kernel entropy pool dry to do this when it could happen on nearly
> every frame we transmit.  IOW, this is the perfect situation for
> get_random_int() vs get_random_bytes().
> 
> I wonder if it's worth backporting this whole thing (possibly minus
>  arch_get_random_int()) or just re-implementing it using 
> get_random_bytes() instead:
> 
> unsigned int get_random_int(void) { int r; get_random_bytes(&r,
> sizeof(r));
> 
> return r; }
> 
> After all, this logic is what any modules would have had would have
> had to use prior to 3.10.
> 
> Any thoughts on this?

Yes using get_random_bytes() sound good to me, so you would add this
functions somewhere to backports.

I was thinking about if using get_random_int() in cw1200 already has a
too big overhead, but I do not know how long it takes to generate this
random data, but this is unrelated to backports.

>> I uploaded a logfile with some error messages: 
>> http://hauke-m.de/files/compat-wireless/ckmake.log
> 
> Thanks, I will look into this tonight.
> 
> - Solomon
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSDo5AAAoJEIZ0px9YPRMyJuAQAKcHsDg6sptiQKuLWx6JWRZy
T2q0hdiNR38hl6tHmYjhWl+BY5GWrFTAQGw48nFSu6kNCk0UQPIcffDNTKoGZe0r
Ls+bzmfsD9ZcstndnK26gRKvsW5vOxUPvgtl8Jqf3YvX16ApZqr9XSWFWXSEYKSX
8LYvewR/6su66y5OUcL4VmQv/6CgLmslQDRJQanKfMkh/1B32JXvNMWbFQt/rviR
iwOpvrSYTfAeG0WUUdsSDXM56Rm2JeE57PNwYT9RIiyjKY50V+Zv3kVXqWrtsmeo
+Ql2pTGMrCW9ImJFUEgaCSYlpb0omOGOa6nRmkkV8o8MbibgWYhSEnlRLvMDl5z4
UJjKKGN4FNJyWDcxeVvayU1oLo0dLlkBEw0BVxrScgaOBochi3l5cJOB2FB8VM5l
petaOTuVAE+ctNEqiKNezfINvaGawvv3EBzmetKlm/oPdbUvhoCKRea4ZtASQzz+
thGSNFLBYk4kH3wGArmDZG3jVoQ/65PtsondVZy3JtV3/q4EY5FJPldMe5ONviyR
CKoCHxK/UbeyE8J/emCxMekj7OJfglpDdaAEApqku2EC1icEjI8fi6ny2n2JsFjx
nyYIGLJmLVeYxts0eAeYcM9MzxlaagQEvDl+j8FgcJpvGKgf7tUwxwzM6ZF/kokV
VH6XKReprJeXS1TKmIzy
=ICEb
-----END PGP SIGNATURE-----
