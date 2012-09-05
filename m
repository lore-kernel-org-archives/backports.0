Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <backports-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:51464 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab2IEMIj convert rfc822-to-8bit (ORCPT
	<rfc822;backports@vger.kernel.org>); Wed, 5 Sep 2012 08:08:39 -0400
Received: by ieje11 with SMTP id e11so953027iej.19
        for <backports@vger.kernel.org>; Wed, 05 Sep 2012 05:08:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5023A231020000D6000E4B88@novprvoes0310.provo.novell.com>
References: <5023A231020000D6000E4B88@novprvoes0310.provo.novell.com>
Date: Wed, 5 Sep 2012 15:08:38 +0300
Message-ID: <CAFub=KSC31bS=Rz_-=H46-euysNfba7fh+o8ymtkGW+e-zoAdA@mail.gmail.com>
Subject: Re: [Lf_driver_backport] Some general questions about compat, also
 adding distro kernels
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: Ann Davis <andavis@suse.com>
Cc: lf_driver_backport@lists.linux-foundation.org,
	backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Aug 9, 2012 at 8:42 PM, Ann Davis <andavis@suse.com> wrote:
> Hi all,

Hi,

(BTW we have a new mailing list for backport stuff:
backports@vger.kernel.org. I CC'ed that too)

>
> 1)  Is the intention for backporters to pull the compat source into their own build structure, build the compat module themselves, then provide it along with their backported driver?
>

Normally the compat-* trees (compat-drivers for example) copies the
compat tree into itself, builds it and finally builds/links drivers
that use it. So in the simplest case you end up with compat.ko and
let's say foobar.ko which depends on compat.ko. Then when you load
foobar.ko, it loads compat.ko. That's all.

> 2)  How to address the problem of providing 2 different drivers pulled from different upstream kernel versions?  This would entail 2 different compat modules, right?  Seems like there would be a conflict.

The compat module will always be one as it only backports the low
level API changes that will allow building the new drivers (wlan, eth,
bluetooth, drm, etc. etc whatever you want to backport) against the
kernels that it supports (2.6.24 through the last major stable).
Instead you will have 2 different driver builds for a specific device
using the same compat module. (If I correctly get what you asked and
I'm not mistaken).

> PS.  I'm working on a patch that includes SUSE kernels into the compat project.  So Andy, I'm interested to see what you're doing from the RHEL 6 perspective.  Right now I'm just modifying bin/get-compat/kernels and bin/ckmake but I don't know if this is structurally a reasonable approach.  I.e., should there be separate "get-<distro>-compat-kernels" scripts for separate distros?  I'd love to hear what other folks are doing on this front so I can head in the same general direction.

the get-compat-kernels and ckmake scripts just build-tests the compat
module against the supported kernel versions 2.6.24 through the latest
stable major version. It uses Ubuntu vanilla kernels to do this. The
scripts are distro-independent. ckmake only builds against the kernels
having a "-generic" suffix in /lib/modules. Probably you would want to
build-test compat against SUSE kernels so simply you can modify the
below line in ckmake (line ~217)

for i in $(find $KSRC_PREFIX/lib/modules/ -type d -name \*generic\*

to filter the SUSE kernels instead of "-generic" Ubuntu kernels. (For
example for Fedora -name \.fc\* will suffice) This will test the
compat compilation against SUSE kernels.

-- 
Ozan Çağlayan
