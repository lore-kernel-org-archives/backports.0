Return-path: <backports-owner@vger.kernel.org>
Received: from app1b.xlhost.de ([84.200.252.162]:45888 "EHLO app1b.xlhost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510AbaDGKSu (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 7 Apr 2014 06:18:50 -0400
Message-ID: <53427B88.50606@kpanic.de> (sfid-20140407_121852_459753_BF001FD5)
Date: Mon, 07 Apr 2014 12:18:48 +0200
From: Stefan Assmann <sassmann@kpanic.de>
MIME-Version: 1.0
To: Julia Lawall <julia.lawall@lip6.fr>
CC: backports@vger.kernel.org
Subject: Re: coccinelle-1.0.0-rc20 compile issue
References: <534268E2.6060305@kpanic.de> <alpine.DEB.2.10.1404071128260.3433@hadrien>
In-Reply-To: <alpine.DEB.2.10.1404071128260.3433@hadrien>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On 07.04.2014 11:29, Julia Lawall wrote:
>
>
> On Mon, 7 Apr 2014, Stefan Assmann wrote:
>
>> Hi Julia,
>>
>> when trying to compile coccinelle rc20 on RHEL6 I ran into the following
>> issue.
>> ./configure
>> make all
>> [...]
>> /usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I
>> ../commons/ocollection -I ../globals -I  ../parsing_cocci  -c
>> type_annoter_c.mli
>> /usr/bin/ocamlc.opt -g  -I ../commons -I ../commons/ocamlextra -I
>> ../commons/ocollection -I ../globals -I  ../parsing_cocci  -c
>> type_annoter_c.ml
>> File "type_annoter_c.ml", line 204, characters 4-23:
>> Error: Unbound value StringMap.singleton
>> make[5]: *** [type_annoter_c.cmo] Error 2
>> This doesn't happen with rc19.
>
> What is the verion of OCaml?  Indeed, I believe that the use of maps is
> new.

# rpm -qa |grep ocaml
ocaml-ocamldoc-3.11.2-2.el6.x86_64
ocaml-3.11.2-2.el6.x86_64
ocaml-findlib-1.2.5-5.el6.x86_64
ocaml-camlp4-3.11.2-2.el6.x86_64
ocaml-camlp4-devel-3.11.2-2.el6.x86_64
ocaml-runtime-3.11.2-2.el6.x86_64

>
>> When compiling on Fedora 20 there's no error but when I run
>> make install
>> [...]
>> cp ocaml/coccilib.cmi ocaml/coccilib/coccilib.cmi
>> cp: cannot create regular file ‘ocaml/coccilib/coccilib.cmi’: No such
>> file or directory
>> make: *** [ocaml/coccilib/coccilib.cmi] Error 1
>>
>> The Makefile is probably just missing a 'mkdir ocaml/coccilib'.
>
> Did you have any error on the configure?  I have some version of Fedora,
> so i may be able to test this later today.

I didn't spot any errors. Here's a paste.
http://fpaste.org/92207/39686580/

Thanks!

   Stefan
