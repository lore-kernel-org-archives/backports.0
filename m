Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:58296 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964787Ab3DECaE (ORCPT
	<rfc822;backports@vger.kernel.org>); Thu, 4 Apr 2013 22:30:04 -0400
Received: by mail-lb0-f181.google.com with SMTP id r11so3339086lbv.12
        for <backports@vger.kernel.org>; Thu, 04 Apr 2013 19:30:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130405021259.GM27415@gospo.rdu.redhat.com>
References: <1364908781.8204.14.camel@jlt4.sipsolutions.net>
 <1364923241.8204.15.camel@jlt4.sipsolutions.net> <515B4994.3030309@pendre.co.uk>
 <1364937780.8204.18.camel@jlt4.sipsolutions.net> <CAB=NE6VDAekd_a--iFocHGWxdzhVXbQrBcV1HD+kHvbL68r4iw@mail.gmail.com>
 <20130405021259.GM27415@gospo.rdu.redhat.com>
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Date: Thu, 4 Apr 2013 19:29:42 -0700
Message-ID: <CAB=NE6VOZpEYC=OLJ7KsMq3xwXdEqVeKxvLCOZTOCuEOUwijMQ@mail.gmail.com> (sfid-20130405_043012_934520_0A2CB82F)
Subject: Re: [ANN] new backports project
To: Andy Gospodarek <andy@greyhouse.net>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Phil Perry <phil@pendre.co.uk>,
	"backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Thu, Apr 4, 2013 at 7:12 PM, Andy Gospodarek <andy@greyhouse.net> wrote:
> On Tue, Apr 02, 2013 at 02:42:56PM -0700, Luis R. Rodriguez wrote:
>> I should note that RHEL / SUSE / Debian all had the same issues --
>> running into symbols we are exporting with the same upstream name. The
>> move to use LINUX_BACKPORT() should help cure these issues in general
>> moving forward. Additionally if you really want to help in this area
>> please review commit 8ae96730 on compat.git specifically Andi Kleen's
>> work on module namespace. If we can figure out to support module
>> namespace *ourselves*, ie, without Linus having to carry this crap
>> around, then we'd solve all these issues easily, I believe we wouldn't
>> have to rely on LINUX_BACKPORT() and in fact that would also mean
>> renaming our *driver* symbols. This means for instance you can run one
>> drivers with your stock mac80211, another with the backported version,
>> should you ever have to support such crazy environement.
>>
>
> As I was watching the patches for LINUX_BACKPORT fly past over the last
> few weeks and making changes to allow RHEL to work with compat, I
> wondered, "Why not add the LINUX_BACKPORT macro to each one of the
> symbols backported?"

Its sort of already done and committed!

> Of course that seems extremely tedious, but is there a compelling reason
> why something like this should not be done -- other than possibly doing
> as Luis suggests and finding a way to resurrect Andi Kleen's proposal
> for module symbol namespaces -- then I think the option to begin a more
> liberal use of the LINUX_BACKPORT macro is worth considering.

Johannes some idea to help with the tedious work of doing this moving
forward for new code. I'll let him dive in when he awakens.

  Luis
