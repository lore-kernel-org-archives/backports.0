Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:53849 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935627Ab3DHTku (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Apr 2013 15:40:50 -0400
Message-ID: <1365450036.25475.21.camel@jlt4.sipsolutions.net> (sfid-20130408_214053_853532_274E498C)
Subject: Re: [PATCH v3 8/8] build: add NFC defconfig file
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: Thierry Escande <thierry.escande@linux.intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Mon, 08 Apr 2013 21:40:36 +0200
In-Reply-To: <CAB=NE6X6+M2-eUeqTv-PAJDQ_VaLwUv3n94J1YTR+4CK7YYdaw@mail.gmail.com> (sfid-20130408_213755_513280_4A96F3C1)
References: <1365416773-12836-9-git-send-email-thierry.escande@linux.intel.com>
	 <CAB=NE6WWA4r+FyqR484ZJJm_usrCRDOjzMut-6JawNXJXUNmvw@mail.gmail.com>
	 <1365449679.25475.18.camel@jlt4.sipsolutions.net>
	 <CAB=NE6X6+M2-eUeqTv-PAJDQ_VaLwUv3n94J1YTR+4CK7YYdaw@mail.gmail.com>
	 (sfid-20130408_213755_513280_4A96F3C1)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-04-08 at 12:37 -0700, Luis R. Rodriguez wrote:

> >> > +CPTCFG_NFC=m
[...]
> >> Johannes, do we want to be disabling the other subsystems in these ?
> >
> > Well anything not listed will have the default values, so that should be
> > OK, right? Most things should be default off.
> 
> OK so the default would be -- "if you have it on your kernel then
> we'll enable at build time", is that right? I wasn't clear on this,
> that's all.

No, because of the prefix rename (CONFIG_ -> CPTCFG_) the kernel's
configuration has no influence on our configuration at all.

So the default is just whatever the default is in the Kconfig files,
which is essentially everything else turned off.

johannes

