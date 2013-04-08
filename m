Return-path: <backports-owner@vger.kernel.org>
Received: from he.sipsolutions.net ([78.46.109.217]:53825 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935741Ab3DHTe4 (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Apr 2013 15:34:56 -0400
Message-ID: <1365449679.25475.18.camel@jlt4.sipsolutions.net> (sfid-20130408_213459_975610_3B5FE3A0)
Subject: Re: [PATCH v3 8/8] build: add NFC defconfig file
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: Thierry Escande <thierry.escande@linux.intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Date: Mon, 08 Apr 2013 21:34:39 +0200
In-Reply-To: <CAB=NE6WWA4r+FyqR484ZJJm_usrCRDOjzMut-6JawNXJXUNmvw@mail.gmail.com> (sfid-20130408_213157_584530_A7D4DCF5)
References: <1365416773-12836-9-git-send-email-thierry.escande@linux.intel.com>
	 <CAB=NE6WWA4r+FyqR484ZJJm_usrCRDOjzMut-6JawNXJXUNmvw@mail.gmail.com>
	 (sfid-20130408_213157_584530_A7D4DCF5)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, 2013-04-08 at 12:31 -0700, Luis R. Rodriguez wrote:
> On Mon, Apr 8, 2013 at 3:26 AM, Thierry Escande
> <thierry.escande@linux.intel.com> wrote:
> > Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
> > ---
> >  backport/defconfigs/nfc |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >  create mode 100644 backport/defconfigs/nfc
> >
> > diff --git a/backport/defconfigs/nfc b/backport/defconfigs/nfc
> > new file mode 100644
> > index 0000000..999127f
> > --- /dev/null
> > +++ b/backport/defconfigs/nfc
> > @@ -0,0 +1,11 @@
> > +CPTCFG_NFC=m
> > +CPTCFG_NFC_NCI=m
> > +CPTCFG_NFC_HCI=m
> > +CPTCFG_NFC_SHDLC=y
> > +CPTCFG_NFC_LLCP=y
> > +CPTCFG_NFC_PN533=m
> > +CPTCFG_NFC_WILINK=m
> > +CPTCFG_NFC_PN544=m
> > +CPTCFG_NFC_PN544_I2C=m
> > +CPTCFG_NFC_MICROREAD=m
> > +CPTCFG_NFC_MICROREAD_I2C=m
> 
> Johannes, do we want to be disabling the other subsystems in these ?

Well anything not listed will have the default values, so that should be
OK, right? Most things should be default off.

And yeah I think for an NFC defconfig everything else is probably
desired off, no?

johannes

