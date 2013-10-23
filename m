Return-path: <backports-owner@vger.kernel.org>
Received: from server19320154104.serverpool.info ([193.201.54.104]:36235 "EHLO
	hauke-m.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751501Ab3JWVzX (ORCPT <rfc822;backports@vger.kernel.org>);
	Wed, 23 Oct 2013 17:55:23 -0400
Message-ID: <526845C4.5080504@hauke-m.de> (sfid-20131023_235527_750958_975B93CD)
Date: Wed, 23 Oct 2013 23:55:16 +0200
From: Hauke Mehrtens <hauke@hauke-m.de>
MIME-Version: 1.0
To: Solomon Peachy <pizza@shaftnet.org>
CC: "backports@vger.kernel.org" <backports@vger.kernel.org>
Subject: Re: backports-20130830 released
References: <52681718.1020502@hauke-m.de> <20131023194149.GA14165@shaftnet.org>
In-Reply-To: <20131023194149.GA14165@shaftnet.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10/23/2013 09:41 PM, Solomon Peachy wrote:
> On Wed, Oct 23, 2013 at 08:36:08PM +0200, Hauke Mehrtens wrote:
>> The source code can be found here: 
>> https://github.com/hauke/backports
> 
> The backports wiki still references a git tree on kernel.org [1]
> (which hasn't been updated since early September)
> 
> What is considered the canonnical source of backports?  At this
> point I'm guessing it's your github tree, since the last couple of
> releases have come from it.  If so, the wiki needs to be corrected
>  appropriately..
> 
> [1]
> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/backports.git
> 
> - Solomon
> 
Thanks,

I forgot about the wiki. ;-)

I changed this page:
https://backports.wiki.kernel.org/index.php/Documentation/backports/hacking

I hope my git repository is just a temporary solution.

Hauke
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSaEW8AAoJEIZ0px9YPRMytcwP/2BYite4AN+l60K1yWql7gfh
+WTMHccf1mhDu7B4jWt4KuZln/E/mrV9X1UprFmxVpho0M77vZHEfd7udWY2i8wl
y4YHurnKCnFFw2Q+u5MGdC7KtFBimUqm+JgrD0bbH/mKNyPkh4E0P4fO+CCnWmCb
LZkpiaON5TNXR1bGxLMfZsAyVzOOyB5jiRvgRG3Boh/rLukpzxw1JTyaON41mZZX
vU/hpB+WICuay5jTJjluW3rrIR8puoj3gQRXH30XBAcS04Ocjct7RDIogjMGxQ3B
nzc9Dbz7h72PF46R4EbGRh/mtLyEs0DlQC6B2hVCGtECpXqjFPa8sgUMvLri640s
+O5Vg+87346C6NUV4tk6FEkym/8Oh14aNojJrnNrOWWi1m1ZhYhHrkFk+wrVRMka
boZNcuUI/L/PCUPrKCMMSM2mCUwg2w5oSSA43tU3P9qKp3zUHfuiXGgNrym6hI+b
mJVarXmhalO5XYrz3yg8m+V1kTFbIc0MKlUeZxsB0dHKTQOJnROp1zIiuWrYKncu
jQrIyN25h9xeZsKwQjRxV4UTka04q8eXoI7g1tf72oc32IAmd03rDEFfgLphUL/b
0ghZRKg0kkHQ8fR9YGs49/JHoR+i7tb9DwwLTt80gTcgCL0RXDvutmd79YCd7Kej
Uu1O1iNe1smzUbwF2o3K
=N9TO
-----END PGP SIGNATURE-----
