Return-path: <backports-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:36614 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbcHTPMP (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 20 Aug 2016 11:12:15 -0400
MIME-Version: 1.0
In-Reply-To: <20160818181007.GN3296@wotan.suse.de>
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <1471462023-119645-3-git-send-email-cristina.moraru09@gmail.com> <20160818181007.GN3296@wotan.suse.de>
From: Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>
Date: Sat, 20 Aug 2016 17:11:37 +0200
Message-ID: <CAGZ2q2yt1NYshNpm5ZCmPXfYxPynttEU7KiiL3RALegGD04nug@mail.gmail.com> (sfid-20160820_171220_292482_6E1F3FC1)
Subject: Re: [RFC PATCH 2/5] Add CONFIG symbol to module as compilation parameter
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tom Gundersen <teg@jklm.no>,
        Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        akpm@linux-foundation.org, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

2016-08-18 20:10 GMT+02:00 Luis R. Rodriguez <mcgrof@kernel.org>:
> On Wed, Aug 17, 2016 at 09:27:00PM +0200, Cristina Moraru wrote:
>> Add  CONFIG symbol to kernel modules as a define via -D
>
> Perhaps better worded as:
>
> When modules have a direct Kconfig CONFIG_ symbol associated with
> we want to be able to make it available to the build system when we
> are building the module.
>
> You can then describe you do this with -D.
>
>> compilation parameter. The CONFIG_FOO symbol for each
>> module is determined by the module name, using the
>> associations from Module.ksymb. This file is loaded
>> using the 'include' directive, thus run like a regular
>> makefile. The format of the content of the file is the
>> following:
>>
>> foo_KCONF=CONFIG_FOO
>>
>> creating a set of Makefile variables foo_KCONF with the
>> CONFIG_FOO as values.
>>
>> The Makefile then adds this value in the compilation
>> command with -DKBUILD_KCONF='"CONFIG_FOO"'.
>
> Very nice. What would it mean if it lacks this ?
> This should be explained on the commit log.
>

If we lack it then KBUILD_KCONF="" and in /sys the module has the
kconfig_symbol attribute but with the empty string as content:

prompt:/sys$ cat ./module/mptbase/kconfig_symbol

prompt:/sys$

I will add it into the commit log.

>> This patch is part of a research project within
>> Google Summer of Code of porting 'make localmodconfig'
>> for backported drivers. The goal is to enable each
>> module to expose in /sys its corresponding CONFIG_* option.
>> The value of this attribute will be dynamically pegged by
>> modpost without requiring extra work from the driver developers.
>> Further, this information will be used by a hardware interogation
>> tool to extract build information about the existing devices.
>
> You can leave this out as its part of the cover letter and
> not relevant to the patch. You can however mention you will
> use this later to make the define more useful in userspace.
>
>> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
>> ---
>>  scripts/Makefile.lib | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>> index e7df0f5..8ae9b7f 100644
>> --- a/scripts/Makefile.lib
>> +++ b/scripts/Makefile.lib
>> @@ -89,6 +89,10 @@ multi-objs-m       := $(addprefix $(obj)/,$(multi-objs-m))
>>  subdir-ym    := $(addprefix $(obj)/,$(subdir-ym))
>>  obj-dirs     := $(addprefix $(obj)/,$(obj-dirs))
>>
>> +# Include Module.ksymb which contains the associations of modules' names
>> +# and corresponding CONFIG_* options
>> +include Module.ksymb
>
> Is this file always generated? If not prefixing the include call with - would
> be better. If we are going to make this optional, then an ifdef wrapper would
> suffice as we know it'd be expected only if the new feature was enabled.

Yes. This file is always generated. In case a 'git pull' happened
between two 'make' commands, the associations should be updated. Ok. I
will add a ifdef.

>
>> +
>>  # These flags are needed for modversions and compiling, so we define them here
>>  # already
>>  # $(modname_flags) #defines KBUILD_MODNAME as the name of the module it will
>> @@ -100,6 +104,9 @@ name-fix = $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote)$(squote)
>>  basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
>>  modname_flags  = $(if $(filter 1,$(words $(modname))),\
>>                   -DKBUILD_MODNAME=$(call name-fix,$(modname)))
>> +ksym-fix = $(squote)$(quote)$($(subst $(comma),_,$(subst -,_,$1))_KCONF)$(quote)$(squote)
>> +ksymb_flags = $(if $(filter 1,$(words $(modname))),\
>> +                 -DKBUILD_KSYMB=$(call ksym-fix, $(modname)))
>
> Are clashes possible with this formula? Can we end up with two results for instance?
> If not what prevents current konfig logic and namespace from a clash ? If we do
> not have anything to prevent a clash, what can we do to help make such clash not
> possible ?

I think the fact that modname is unique prevents from having clashes.
KBUILD_KSYMB is found according to modname.
Currently there is no clash because I enforced the Module.ksymb to
have 1-to-1 mapping.
The only potential clash I can imagine right now it having the same
module name but architecture specific CONFIG_* symbol. If there is a
1-to-1 mapping in Module.ksymb there should be no clash in the
makefile.

>
>>  orig_c_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(KBUILD_SUBDIR_CCFLAGS) \
>>                   $(ccflags-y) $(CFLAGS_$(basetarget).o)
>> @@ -162,7 +169,7 @@ endif
>>
>>  c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
>>                $(__c_flags) $(modkern_cflags)                           \
>> -              $(basename_flags) $(modname_flags)
>> +              $(basename_flags) $(modname_flags) $(ksymb_flags)
>>
>>  a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
>>                $(__a_flags) $(modkern_aflags)
>> --
>
> Other than that looks good!
>
>   Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
