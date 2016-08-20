Return-path: <backports-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35799 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752796AbcHTPQv (ORCPT
        <rfc822;backports@vger.kernel.org>); Sat, 20 Aug 2016 11:16:51 -0400
MIME-Version: 1.0
In-Reply-To: <20160818185941.GK3296@wotan.suse.de>
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <1471462023-119645-5-git-send-email-cristina.moraru09@gmail.com> <20160818185941.GK3296@wotan.suse.de>
From: Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>
Date: Sat, 20 Aug 2016 17:16:50 +0200
Message-ID: <CAGZ2q2y5kGq017ro9YY7QL6qmay6xFeOfB5UVdWo2wg+5DA7cw@mail.gmail.com> (sfid-20160820_171654_592036_5822E46F)
Subject: Re: [RFC PATCH 4/5] Set KCONFIG_KSYMB as value for kconfig_ksymb
 module attribute
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tom Gundersen <teg@jklm.no>,
        Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        akpm@linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>,
        backports@vger.kernel.org, vegard.nossum@gmail.com
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

2016-08-18 20:59 GMT+02:00 Luis R. Rodriguez <mcgrof@kernel.org>:
>
> On Wed, Aug 17, 2016 at 09:27:02PM +0200, Cristina Moraru wrote:
> > Update modpost to add in *.mod.c files generated for each
> > module the setting of module attribute kernel_ksymb to
> > value given by KBUILD_KSYMB macro.
>
> Please review your patches and update subjects to match what other
> types of previous patches look like in terms of format, so
> for this patch check changes to scripts/mod/modpost.c and use
> similar type of patch prefix.
>

OK

>
> >
> > This patch is part of a research project within
> > Google Summer of Code of porting 'make localmodconfig'
> > for backported drivers. The goal is to enable each
> > module to expose in /sys its corresponding CONFIG_* option.
> > The value of this attribute will be dynamically pegged by
> > modpost without requiring extra work from the driver developers.
> > Further, this information will be used by a hardware interogation
> > tool to extract build information about the existing devices.
>
> You can leave this out.
>
> > Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
> > ---
> >  scripts/mod/modpost.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 48958d3..a105916 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -2245,6 +2245,12 @@ static void add_srcversion(struct buffer *b, struct module *mod)
> >       }
> >  }
> >
> > +static void add_kconfig_symbol(struct buffer *b, struct module *mod)
> > +{
> > +     buf_printf(b, "\n");
> > +     buf_printf(b, "MODULE_INFO(kconfig_symbol, KBUILD_KSYMB);\n");
>
> What if its not available? What happens?
>

If not available KBUILD_KSYMB is "" and so is set in kconfig_symbol.
More concrete:

prompt:/sys$ cat ./module/mptbase/kconfig_symbol

prompt:/sys$

>
> > +}
> > +
> >  static void write_if_changed(struct buffer *b, const char *fname)
> >  {
> >       char *tmp;
> > @@ -2478,6 +2484,7 @@ int main(int argc, char **argv)
> >               add_depends(&buf, mod, modules);
> >               add_moddevtable(&buf, mod);
> >               add_srcversion(&buf, mod);
> > +             add_kconfig_symbol(&buf, mod);
> >
> >               sprintf(fname, "%s.mod.c", mod->name);
> >               write_if_changed(&buf, fname);
> > --
> > 2.7.4
> >
> >
>
> --
> Luis Rodriguez, SUSE LINUX GmbH
> Maxfeldstrasse 5; D-90409 Nuernberg
--
To unsubscribe from this list: send the line "unsubscribe backports" in
