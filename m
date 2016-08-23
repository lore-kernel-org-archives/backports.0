Return-path: <backports-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752389AbcHWTKX (ORCPT <rfc822;backports@vger.kernel.org>);
        Tue, 23 Aug 2016 15:10:23 -0400
Date: Tue, 23 Aug 2016 21:10:13 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, Tom Gundersen <teg@jklm.no>,
        Kay Sievers <kay@vrfy.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        akpm@linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>,
        backports@vger.kernel.org, vegard.nossum@gmail.com
Subject: Re: [RFC PATCH 4/5] Set KCONFIG_KSYMB as value for kconfig_ksymb
 module attribute
Message-ID: <20160823191013.GG3296@wotan.suse.de> (sfid-20160823_211107_546304_46738B33)
References: <1471462023-119645-1-git-send-email-cristina.moraru09@gmail.com>
 <1471462023-119645-5-git-send-email-cristina.moraru09@gmail.com>
 <20160818185941.GK3296@wotan.suse.de>
 <CAGZ2q2y5kGq017ro9YY7QL6qmay6xFeOfB5UVdWo2wg+5DA7cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGZ2q2y5kGq017ro9YY7QL6qmay6xFeOfB5UVdWo2wg+5DA7cw@mail.gmail.com>
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, Aug 20, 2016 at 05:16:50PM +0200, Cristina-Gabriela Moraru wrote:
> 2016-08-18 20:59 GMT+02:00 Luis R. Rodriguez <mcgrof@kernel.org>:
> >
> > On Wed, Aug 17, 2016 at 09:27:02PM +0200, Cristina Moraru wrote:
> > > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > > index 48958d3..a105916 100644
> > > --- a/scripts/mod/modpost.c
> > > +++ b/scripts/mod/modpost.c
> > > @@ -2245,6 +2245,12 @@ static void add_srcversion(struct buffer *b, struct module *mod)
> > >       }
> > >  }
> > >
> > > +static void add_kconfig_symbol(struct buffer *b, struct module *mod)
> > > +{
> > > +     buf_printf(b, "\n");
> > > +     buf_printf(b, "MODULE_INFO(kconfig_symbol, KBUILD_KSYMB);\n");
> >
> > What if its not available? What happens?
> >
> 
> If not available KBUILD_KSYMB is "" and so is set in kconfig_symbol.
> More concrete:
> 
> prompt:/sys$ cat ./module/mptbase/kconfig_symbol
> 
> prompt:/sys$

As I noted in my other e-mail I think its best we just avoid exposing this
then for modules that lack a mapping, and then we make this best effort,
but document the shortcomings very well and super clearly as to why a
backward map is not possible. This then enables us to do work on the build
system to help with this and complete the semantic gap.

  Luis
--
To unsubscribe from this list: send the line "unsubscribe backports" in
