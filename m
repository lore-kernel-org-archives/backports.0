Return-path: <backports-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:49694 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935727Ab3DHThg (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 8 Apr 2013 15:37:36 -0400
Received: by mail-la0-f42.google.com with SMTP id fe20so5771429lab.1
        for <backports@vger.kernel.org>; Mon, 08 Apr 2013 12:37:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365449679.25475.18.camel@jlt4.sipsolutions.net>
References: <1365416773-12836-9-git-send-email-thierry.escande@linux.intel.com>
 <CAB=NE6WWA4r+FyqR484ZJJm_usrCRDOjzMut-6JawNXJXUNmvw@mail.gmail.com> <1365449679.25475.18.camel@jlt4.sipsolutions.net>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Mon, 8 Apr 2013 12:37:14 -0700
Message-ID: <CAB=NE6X6+M2-eUeqTv-PAJDQ_VaLwUv3n94J1YTR+4CK7YYdaw@mail.gmail.com> (sfid-20130408_213755_447659_DE3B98ED)
Subject: Re: [PATCH v3 8/8] build: add NFC defconfig file
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thierry Escande <thierry.escande@linux.intel.com>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Mon, Apr 8, 2013 at 12:34 PM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> On Mon, 2013-04-08 at 12:31 -0700, Luis R. Rodriguez wrote:
>> On Mon, Apr 8, 2013 at 3:26 AM, Thierry Escande
>> <thierry.escande@linux.intel.com> wrote:
>> > Signed-off-by: Thierry Escande <thierry.escande@linux.intel.com>
>> > ---
>> >  backport/defconfigs/nfc |   11 +++++++++++
>> >  1 file changed, 11 insertions(+)
>> >  create mode 100644 backport/defconfigs/nfc
>> >
>> > diff --git a/backport/defconfigs/nfc b/backport/defconfigs/nfc
>> > new file mode 100644
>> > index 0000000..999127f
>> > --- /dev/null
>> > +++ b/backport/defconfigs/nfc
>> > @@ -0,0 +1,11 @@
>> > +CPTCFG_NFC=m
>> > +CPTCFG_NFC_NCI=m
>> > +CPTCFG_NFC_HCI=m
>> > +CPTCFG_NFC_SHDLC=y
>> > +CPTCFG_NFC_LLCP=y
>> > +CPTCFG_NFC_PN533=m
>> > +CPTCFG_NFC_WILINK=m
>> > +CPTCFG_NFC_PN544=m
>> > +CPTCFG_NFC_PN544_I2C=m
>> > +CPTCFG_NFC_MICROREAD=m
>> > +CPTCFG_NFC_MICROREAD_I2C=m
>>
>> Johannes, do we want to be disabling the other subsystems in these ?
>
> Well anything not listed will have the default values, so that should be
> OK, right? Most things should be default off.

OK so the default would be -- "if you have it on your kernel then
we'll enable at build time", is that right? I wasn't clear on this,
that's all.

  Luis
