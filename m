Return-path: <backports-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:48977 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754182AbaDGJaC (ORCPT
	<rfc822;backports@vger.kernel.org>); Mon, 7 Apr 2014 05:30:02 -0400
Date: Mon, 7 Apr 2014 11:29:49 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Stefan Assmann <sassmann@kpanic.de>
cc: backports@vger.kernel.org
Subject: Re: coccinelle-1.0.0-rc20 compile issue
In-Reply-To: <534268E2.6060305@kpanic.de>
Message-ID: <alpine.DEB.2.10.1404071128260.3433@hadrien> (sfid-20140407_113005_437420_9BB9C440)
References: <534268E2.6060305@kpanic.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-867819879-1396862989=:3433"
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-867819879-1396862989=:3433
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT



On Mon, 7 Apr 2014, Stefan Assmann wrote:

> Hi Julia,
>
> when trying to compile coccinelle rc20 on RHEL6 I ran into the following
> issue.
> ./configure
> make all
> [...]
> /usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I
> ../commons/ocollection -I ../globals -I  ../parsing_cocci  -c
> type_annoter_c.mli
> /usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I
> ../commons/ocollection -I ../globals -I  ../parsing_cocci  -c
> type_annoter_c.ml
> File "type_annoter_c.ml", line 204, characters 4-23:
> Error: Unbound value StringMap.singleton
> make[5]: *** [type_annoter_c.cmo] Error 2
> This doesn't happen with rc19.

What is the verion of OCaml?  Indeed, I believe that the use of maps is
new.

> When compiling on Fedora 20 there's no error but when I run
> make install
> [...]
> cp ocaml/coccilib.cmi ocaml/coccilib/coccilib.cmi
> cp: cannot create regular file ‘ocaml/coccilib/coccilib.cmi’: No such
> file or directory
> make: *** [ocaml/coccilib/coccilib.cmi] Error 1
>
> The Makefile is probably just missing a 'mkdir ocaml/coccilib'.

Did you have any error on the configure?  I have some version of Fedora,
so i may be able to test this later today.

julia
--8323329-867819879-1396862989=:3433--
