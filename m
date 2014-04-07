Return-path: <backports-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:46561
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754274AbaDGNNo (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 09:13:44 -0400
Date: Mon, 7 Apr 2014 15:13:31 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Stefan Assmann <sassmann@kpanic.de>
cc: backports@vger.kernel.org
Subject: Re: coccinelle-1.0.0-rc20 compile issue
In-Reply-To: <53427B88.50606@kpanic.de>
Message-ID: <alpine.DEB.2.10.1404071511510.2187@hadrien> (sfid-20140407_151346_253698_6843B59A)
References: <534268E2.6060305@kpanic.de> <alpine.DEB.2.10.1404071128260.3433@hadrien> <53427B88.50606@kpanic.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-963924992-1396876412=:2187"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-963924992-1396876412=:2187
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT



On Mon, 7 Apr 2014, Stefan Assmann wrote:

> On 07.04.2014 11:29, Julia Lawall wrote:
> >
> >
> > On Mon, 7 Apr 2014, Stefan Assmann wrote:
> >
> > > Hi Julia,
> > >
> > > when trying to compile coccinelle rc20 on RHEL6 I ran into the following
> > > issue.
> > > ./configure
> > > make all
> > > [...]
> > > /usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I
> > > ../commons/ocollection -I ../globals -I  ../parsing_cocci  -c
> > > type_annoter_c.mli
> > > /usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I
> > > ../commons/ocollection -I ../globals -I  ../parsing_cocci  -c
> > > type_annoter_c.ml
> > > File "type_annoter_c.ml", line 204, characters 4-23:
> > > Error: Unbound value StringMap.singleton
> > > make[5]: *** [type_annoter_c.cmo] Error 2
> > > This doesn't happen with rc19.
> >
> > What is the verion of OCaml?  Indeed, I believe that the use of maps is
> > new.
>
> # rpm -qa |grep ocaml
> ocaml-ocamldoc-3.11.2-2.el6.x86_64
> ocaml-3.11.2-2.el6.x86_64
> ocaml-findlib-1.2.5-5.el6.x86_64
> ocaml-camlp4-3.11.2-2.el6.x86_64
> ocaml-camlp4-devel-3.11.2-2.el6.x86_64
> ocaml-runtime-3.11.2-2.el6.x86_64
>
> >
> > > When compiling on Fedora 20 there's no error but when I run
> > > make install
> > > [...]
> > > cp ocaml/coccilib.cmi ocaml/coccilib/coccilib.cmi
> > > cp: cannot create regular file ‘ocaml/coccilib/coccilib.cmi’: No such
> > > file or directory
> > > make: *** [ocaml/coccilib/coccilib.cmi] Error 1
> > >
> > > The Makefile is probably just missing a 'mkdir ocaml/coccilib'.
> >
> > Did you have any error on the configure?  I have some version of Fedora,
> > so i may be able to test this later today.
>
> I didn't spot any errors. Here's a paste.
> http://fpaste.org/92207/39686580/

Did you get it from github?  I think there is a problem that github
doesn't preserve empty directories.  It exists in the tgz available on
out web page:

http://coccinelle.lip6.fr/download.php

I think that the problem was discussed, so I'm a bit surprised that it was
not fixed.  I will look into it.

julia
--8323329-963924992-1396876412=:2187--
