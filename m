Return-path: <backports-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35178 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752900AbcHTOtE (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 20 Aug 2016 10:49:04 -0400
MIME-Version: 1.0
In-Reply-To: <CAGZ2q2xi9Uy-ye387=mWhy_fOEJBC593Nos7fH027m-_ZdoOXA@mail.gmail.com>
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <1471462023-119645-2-git-send-email-cristina.moraru09@gmail.com>
 <20160818182236.GO3296@wotan.suse.de> <CAGZ2q2xi9Uy-ye387=mWhy_fOEJBC593Nos7fH027m-_ZdoOXA@mail.gmail.com>
From: Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>
Date: Sat, 20 Aug 2016 16:49:02 +0200
Message-ID: <CAGZ2q2w=RFFkWBtg0fwVzEFs_2+x39aayjHu-v6d1G1=PXWSPg@mail.gmail.com> (sfid-20160820_164908_241748_86999F10)
Subject: Re: [RFC PATCH 1/5] Add generation of Module.symb in streamline_config
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tom Gundersen <teg@jklm.no>,
        Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        akpm@linux-foundation.org, backports@vger.kernel.org,
        "vegard.nossum@gmail.com" <vegard.nossum@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

2016-08-20 15:59 GMT+02:00 Cristina-Gabriela Moraru
<cristina.moraru09@gmail.com>:
>
>
> 2016-08-18 20:22 GMT+02:00 Luis R. Rodriguez <mcgrof@kernel.org>:
>>
>> On Wed, Aug 17, 2016 at 09:26:59PM +0200, Cristina Moraru wrote:
>> > Add generation of ./scripts/Module.ksymb file containing
>> > associations of driver file names and corresponding CONFIG_*
>> > symbol:
>> >
>> > foo_KCONF=3DCONFIG_FOO
>> >
>> > This file will be further loaded by the Makefile as a
>> > configuration file: all foo_KCONF will be considered variables
>> > and all CONFIG_FOO will be their associate values.
>>
>> Will the file generated always work? What are the current
>> restrictions on kconfig variable names?
>>
>
> The file generated will always work. It's loaded with makefile's "include=
"
> directive which is quite straightforward.
>
> If you're referring to  CONFIG_* variables, I can't find any restriction
> regarding size or anything else.
> If you're referring to the newly created makefile variable foo_KCONF I on=
ly
> found this in the documentation:
> "A variable name may be any sequence of characters not containing =E2=80=
=98:=E2=80=99, =E2=80=98#=E2=80=99,
> =E2=80=98=3D=E2=80=99, or whitespace."
> "It is traditional to use upper case letters in variable names, but we
> recommend using lower case letters for variable names that serve internal
> purposes in the makefile, and reserving upper case for parameters that
> control implicit rules or for parameters that the user should override wi=
th
> command options"
>
> Since the module name is lowercase I put the suffix uppercase in order to=
 be
> more visible.
>
>>
>> > The suffix
>> > is added to be able to differentiate the new variables from
>> > all existing variables in the Makefile system. Each kernel
>> > module will receive its CONFIG_FOO option as macro in the
>> > compilation command (-D parameter) and will expose it along
>> > with other module attributes (attributes of struct module).
>>
>> This is done later so this description does not belong here.
>> You want to describe what this patch does alone, if it has
>> potential for the future just mention basics, and that will will
>> be done later.
>>
>> > Note: this patch is built on the assumption that each driver
>> > has exactly one associate CONFIG_FOO symbol.
>>
>> This should note be a note, it should be an important aspect of
>> your changes -- you should try to describe when a direct mapping
>> is possible and when it is not.
>>
>> > CONFIG_* options
>> > that are required by CONFIG_FOO are not included. They can be
>> > found by SAT resolvers.
>>
>> You can leave this out.
>>
>> > This patch is part of a research project within
>> > Google Summer of Code of porting 'make localmodconfig'
>> > for backported drivers. The goal is to enable each
>> > module to expose in /sys its corresponding CONFIG_* option.
>> > The value of this attribute will be dynamically pegged by
>> > modpost without requiring extra work from the driver developers.
>> > Further, this information will be used by a hardware interogation
>> > tool to extract build information about the existing devices.
>>
>> You can leave this out.
>>
>> >
>> > Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
>> > ---
>> >  scripts/kconfig/streamline_config.pl | 30
>> > +++++++++++++++++++++++++++++-
>> >  1 file changed, 29 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/scripts/kconfig/streamline_config.pl
>> > b/scripts/kconfig/streamline_config.pl
>> > index b8c7b29..686d02a 100755
>> > --- a/scripts/kconfig/streamline_config.pl
>> > +++ b/scripts/kconfig/streamline_config.pl
>> > @@ -128,9 +128,11 @@ my @config_file =3D read_config;
>> >  # Parse options
>> >  my $localmodconfig =3D 0;
>> >  my $localyesconfig =3D 0;
>> > +my $genmoduleksymb =3D 0;
>> >
>> >  GetOptions("localmodconfig" =3D> \$localmodconfig,
>> > -        "localyesconfig" =3D> \$localyesconfig);
>> > +        "localyesconfig" =3D> \$localyesconfig,
>> > +        "genmoduleksymb" =3D> \$genmoduleksymb);
>> >
>> >  # Get the build source and top level Kconfig file (passed in)
>> >  my $ksource =3D ($ARGV[0] ? $ARGV[0] : '.');
>> > @@ -147,6 +149,7 @@ my %objects;
>> >  my $var;
>> >  my $iflevel =3D 0;
>> >  my @ifdeps;
>> > +my @drv_objs;
>> >
>> >  # prevent recursion
>> >  my %read_kconfigs;
>> > @@ -348,6 +351,31 @@ foreach my $makefile (@makefiles) {
>> >      close($infile);
>> >  }
>> >
>> > +foreach my $obj_key ( keys %objects )
>> > +{
>> > +     my @config_options =3D @{$objects{$obj_key}};
>> > +     # Last index of array is 0 is equivalent to array's size is 1
>> > +     if ( $#config_options =3D=3D 0) {
>> > +             push(@drv_objs, $obj_key);
>> > +     }
>> > +}
>> > +
>> > +sub gen_module_kconfigs {
>> > +     my $module_ksymb =3D $ENV{'srctree'}."/scripts/Module.ksymb";
>> > +
>> > +     open(my $ksymbfile, '>', $module_ksymb) || die "Can not open
>> > $module_ksymb for writing";
>> > +
>> > +     foreach (@drv_objs) {
>> > +             print $ksymbfile "$_" . "_KCONF=3D" . "@{$objects{$_}}\n=
";
>> > +     }
>> > +     close($ksymbfile);
>> > +}
>> > +
>> > +if ($genmoduleksymb) {
>> > +     gen_module_kconfigs();
>> > +     exit(0);
>> > +}
>> > +
>> >  my %modules;
>> >  my $linfile;
>>
>> This is nice for experimentation, however as you note we want
>> to evaluate a better way to do this. While at it, can you describe
>> what algorithm currently is used by scripts/kconfig/streamline_config.pl
>> to collect %objects and the associated CONFIG symbol ? Can you think
>> of possible flaws to it ?
>>
>
> Shortly, all makefiles are parsed searching for patterns such as:
>
> obj-$(CONFIG_FOO) :=3D obj-foo1.o obj-foo2.o ... etc.
>
> Each obj-foo is added in the hashmap as key with the value
> array(CONFIG_FOO).
> If obj-foo already exists in the hashmap CONFIG_FOO is appended to the ar=
ray
> value.
>
> I noted that there are situations where an object obj-foo has as associat=
es
> more identical CONFIG_FOOs.
> Since I select only the names which have exaclty one CONFIG_* associated
> this is a bit confusing. I am missing one category of drivers which can b=
e
> found:
>
> driver-foo ---- CONFIG_FOO CONFIG_FOO
>
> For example: nfit CONFIG_ACPI_NFIT CONFIG_ACPI_NFIT -- this actually resu=
lts
> in  a module in /sys which does not have a content into kconfig_ksymb
> although it has exactly one match.
>
> Another thing I can think of is that sometimes we find lines such as:
>
> foo-name-$(CONFIG_FOO) =3D obj-foo1.o obj-foo2.o obj-foo3.o
>
> This can be a clue that the final kernel module is named foo-name and cou=
ld
> solve some ambiguous cases.
> This are just a few situations I can think of to be kept in mind for the
> next Module.ksymb generator
>
>>
>> The generation here is also forced, we want to enable this to be optiona=
l
>> so please consider adding a Kconfig entry for this as a feature, just as
>> the module versioning stuff has one.
>
>
> OK
>>
>>
>>   Luis
>
>

Message forwarded since original message was rejected by lkml and
backports for being HTML format.
Cristina
--
To unsubscribe from this list: send the line "unsubscribe backports" in
