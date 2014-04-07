Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:49695 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754182AbaDGJFG (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 7 Apr 2014 05:05:06 -0400
Message-ID: <534268E2.6060305@kpanic.de> (sfid-20140407_110509_167067_A7032F79)
Date: Mon, 07 Apr 2014 10:59:14 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: julia.lawall@lip6.fr
CC: backports@vger.kernel.org
Subject: coccinelle-1.0.0-rc20 compile issue
Content-Type: text/plain; charset=windows-1252
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi Julia,

when trying to compile coccinelle rc20 on RHEL6 I ran into the following
issue.
./configure
make all
[...]
/usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I
../commons/ocollection -I ../globals -I  ../parsing_cocci  -c
type_annoter_c.mli
/usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I
../commons/ocollection -I ../globals -I  ../parsing_cocci  -c
type_annoter_c.ml
File "type_annoter_c.ml", line 204, characters 4-23:
Error: Unbound value StringMap.singleton
make[5]: *** [type_annoter_c.cmo] Error 2
This doesn't happen with rc19.

When compiling on Fedora 20 there's no error but when I run
make install
[...]
cp ocaml/coccilib.cmi ocaml/coccilib/coccilib.cmi
cp: cannot create regular file ‘ocaml/coccilib/coccilib.cmi’: No such
file or directory
make: *** [ocaml/coccilib/coccilib.cmi] Error 1

The Makefile is probably just missing a 'mkdir ocaml/coccilib'.

  Stefan
