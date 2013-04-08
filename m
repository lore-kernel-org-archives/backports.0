Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:53979 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936007Ab3DHU0v (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Apr 2013 16:26:51 -0400
Message-ID: <1365452804.25475.25.camel@jlt4.sipsolutions.net> (sfid-20130408_222655_029181_244811AF)
Subject: Re: [PATCH v3 0/8] backports: add NFC subsystem
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: Thierry Escande <thierry.escande@linux.intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Mon, 08 Apr 2013 22:26:44 +0200
In-Reply-To: <CAB=NE6X_gaL99LLsB-FqDwShqZ08CCFR+4KjNuremdefO_O0Ug@mail.gmail.com> (sfid-20130408_212844_658236_AFD91CE7)
References: <1365416773-12836-1-git-send-email-thierry.escande@linux.intel.com>
	 <CAB=NE6X_gaL99LLsB-FqDwShqZ08CCFR+4KjNuremdefO_O0Ug@mail.gmail.com>
	 (sfid-20130408_212844_658236_AFD91CE7)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-04-08 at 12:28 -0700, Luis R. Rodriguez wrote:
> On Mon, Apr 8, 2013 at 3:26 AM, Thierry Escande
> <thierry.escande@linux.intel.com> wrote:
> > This adds support for NFC core and drivers backport down to v3.1. Prior kernel
> > versions won't support it as is since PF_NFC net proto as been introduced in
> > v3.1 and sock_register kernel api in prior kernels will fail for PF_NFC.
> >
> > $ckmake --defconfig nfc
> 
> I think using this makes sense for testing *your* development work but
> for integration upstream I'd prefer to see a full ckmake test. We can
> get you access to the build box to help with this, or Johannes can
> also run it prior to integration.

I ran it, works & pushed.

johannes

