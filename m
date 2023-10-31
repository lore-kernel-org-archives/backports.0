Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90CC2030E
	for <backports@vger.kernel.org>; Tue, 31 Oct 2023 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailfence.com header.i=brianwitte@mailfence.com header.b="6B9IhyTD"
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7ECF4
	for <backports@vger.kernel.org>; Tue, 31 Oct 2023 09:24:08 -0700 (PDT)
Received: from ichabod.co-bxl (ichabod.co-bxl [10.2.0.36])
	by wilbur.contactoffice.com (Postfix) with ESMTP id B0B60480;
	Tue, 31 Oct 2023 17:24:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1698769445;
	s=20210208-e7xh; d=mailfence.com; i=brianwitte@mailfence.com;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
	l=2635; bh=BYFAYYgZLYgszcOkg/+2oWHfusrvfzfVSAXjt7nMXhk=;
	b=6B9IhyTDyJCH5qbzHHlxXkyDQqcpysvb2BLFeKtRrgSRwMm2F/gKftBqv9aN8IqF
	dMgFUjdIw4xhdi7y1igeraqKLZOmGWqS7n9UU8IvXWBQQisMAANzSNET4I1Xnge3IOv
	08PBEpg1Y0qKNNqAzv2V8HArzJNqaCtfGGdgz20kb8dRe6HB2Vh8iEkkoiu+zFUiDIN
	lBvrtey+P+3C7BCdd8EgLer5lgaZ4pzJHwCeTztI+uYPx3PzbicUmjtSTnObIgH32vf
	7307T7kH8Q2ZKr4NYoXTbFECI/W17WeZGSqPmnmx12rtwvToFOfNAk13Otcp6M/0O83
	ZI6CQ+3fAw==
Date: Tue, 31 Oct 2023 17:24:04 +0100 (CET)
From: Brian Witte <brianwitte@mailfence.com>
To: backports@vger.kernel.org, hauke@hauke-m.de,
	Johannes Berg <johannes@sipsolutions.net>,
	Larry Finger <Larry.Finger@lwfinger.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <44560748.117980.1698769443983@ichabod.co-bxl>
In-Reply-To: <b67264b6-41f8-4415-ab8a-fbdbac21748e@mailfence.com>
References: <831d1de6-5d02-43b9-b907-70d9f1a03cab@mailfence.com> <435c43bae693e72004c39ff90a901bc911ab1e6d.camel@sipsolutions.net> <029db1c1-2ac8-430e-915b-beb7c3741de2@lwfinger.net> <0b543e2e6aa3f2473d7ed8e406b74b69e1804143.camel@sipsolutions.net> <1a600228-6975-4798-b2df-89d99007337e@mailfence.com> <18fb6b9a0e1d2a7cc08eaa34979067e7094bb2a1.camel@sipsolutions.net> <b67264b6-41f8-4415-ab8a-fbdbac21748e@mailfence.com>
Subject: Re: rtw88, rtw89 -- options for bringing a couple rtw standalone
 GitHub repos into backports.git
Precedence: bulk
X-Mailing-List: backports@vger.kernel.org
List-Id: <backports.vger.kernel.org>
List-Subscribe: <mailto:backports+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:backports+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: ContactOffice Mail
X-ContactOffice-Account: com:441463380


> 
> I am going to get started now.
> 

Johannes,

Sorry for not getting back sooner. Busy at work, etc. then wanted to
make sure Larry could run the release package successfully.

I was able to get a new backports package built and running on my
machine over the weekend.

First, I did a `./gentree.py` on Hauke's v5.15.92 release with it's
corrresponding branch in stable with success and installed backports on
my hardware running v5.10.0. The new driver code was loaded and worked
as intended with a couple different usb dongles I have.

Second, as a test I built a package release for v5.16.20 because initial
rtw89 commit appears here:

  $ pwd
  /home/bkz/linux-stable

  $ git symbolic-ref --short HEAD && git rev-parse --short HEAD
  master
  ffc253263a13

  $ git describe --contains e3ec7017f6a20d12ddd9fe23d345ebb7b8c104dd
  v5.16-rc1~159^2~121^2~39

I was able to cut that release package that works for the rtw89 driver
by adjust existing patch file diff hunks to apply properly and adding a
new header that came in to net.

Preliminary test was successful:

  $ ./wi_stat.sh

  Kernel Version:
  5.10.0-26-amd64 debian

  Wireless Driver:
  device: wlp2s0
  driver: rtw89_pci

  Driver Stats:
  rx_bytes   : 359634613
  rx_packets : 271727
  tx_bytes   : 8117768
  tx_packets : 46573

My last question re: rtw89, since I just cut a release that "added it"
even though I did not do anything driver specific since the in-tree subsystem
and realtek/ dir do actual config, is this:

What other testing do you recommend for a "new driver" besides testing
"builds" as mentioned in docs [1] here in 'Adding new driver'?

It goes over supporting latest minor versions and says, "you should install
all supported kernel with the script in devel/get-compat-kernels and
then run devel/ckmake to build backports against every kernel version."

[1] https://backports.wiki.kernel.org/index.php/Documentation/backports/hacking

I am working on test/automation for our new backports workflow so any
insight you have would be helpful.

Again, thank you for your help. Larry and I appreciate it.

I will end this thread after your reply and come back to this list with
patches, general questions, and coordinating on helping cut new releases
for https://backports.wiki.kernel.org/index.php/Releases or updating
docs on the wiki.

Honestly, we could probably use some key points from this thread to make
some newbie friendly docs considering how confused I was at first, haha!

I could probably draw a nice diagram based on your explanations.

Anyway, thanks again!

Brian Witte
