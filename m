Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:36967 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951AbaIPMNS (ORCPT <rfc822;backports@vger.kernel.org>);
	Tue, 16 Sep 2014 08:13:18 -0400
Message-ID: <1410869589.2335.1.camel@jlt4.sipsolutions.net> (sfid-20140916_141321_913459_599E3D7F)
Subject: Re: [PATCH] backports: fix mconf compilation on OpenSUSE factory
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, hauke@hauke-m.de,
	backports@vger.kernel.org
Date: Tue, 16 Sep 2014 14:13:09 +0200
In-Reply-To: <20140914142007.GC17349@wotan.suse.de> (sfid-20140914_162012_323135_B1D91681)
References: <1407597803-11371-1-git-send-email-mcgrof@do-not-panic.com>
	 <1407739093.1718.0.camel@jlt4.sipsolutions.net>
	 <1407739647.1718.1.camel@jlt4.sipsolutions.net>
	 <20140914142007.GC17349@wotan.suse.de>
	 (sfid-20140914_162012_323135_B1D91681)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sun, 2014-09-14 at 16:20 +0200, Luis R. Rodriguez wrote:
> On Mon, Aug 11, 2014 at 08:47:27AM +0200, Johannes Berg wrote:
> > On Mon, 2014-08-11 at 08:38 +0200, Johannes Berg wrote:
> > 
> > > I have a vague feeling that we used to have this and it broke somewhere
> > > else, and it was supposed to get added via check-lxdialog.sh...
> > 
> > commit d58be321df286371d50ed54e835efeea087a9fac
> > Author: Johannes Berg <johannes.berg@intel.com>
> > Date:   Mon Jun 3 17:54:33 2013 +0200
> > 
> >     backports: use check-lxdialog.sh
> 
> I've narrowed this down a bit further. The upstream check-lxdialog.sh
> has not changed but I noticed we also used a bit different strategy for
> linking and it seems there are some shortcomings with that that I guess
> could be a bug. This fixes it at least for me.
> 
> Thoughts?
> 
> From 3d8941817e410a546ad6f3f71c1a1d09926c246e Mon Sep 17 00:00:00 2001
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
> Date: Sun, 14 Sep 2014 06:05:29 -0700
> Subject: [PATCH] backports: fix mconf compilation library assumptions
> 
> On OpenSUSE factory 'make menuconfig' fails to compile with:
> 
> cc -Wall -Wmissing-prototypes -Wstrict-prototypes -O2
> -fomit-frame-pointer -DCURSES_LOC="<ncurses.h>" -DLOCALE   -c -o
> lxdialog/yesno.o lxdialog/yesno.c
> cc -Wl,--no-as-needed -lncursesw  mconf.o zconf.tab.o
> lxdialog/checklist.o lxdialog/inputbox.o lxdialog/menubox.o
> lxdialog/textbox.o lxdialog/util.o lxdialog/yesno.o   -o mconf
> /usr/lib64/gcc/x86_64-suse-linux/4.8/../../../../x86_64-suse-linux/bin/ld:
> /lib64/libncursesw.so.5: undefined reference to symbol 'acs_map'
> /usr/lib64/gcc/x86_64-suse-linux/4.8/../../../../lib64/libtinfo.so:
> error adding symbols: DSO missing from command line
> collect2: error: ld returned 1 exit status
> 
> Although this can be fixed by linking with -ltinfo after a bit
> further investigation I've traced this issue down to how we speak
> to the linker and ask it to link and when. For instance if one
> were to compile and link mconf by specifying the linker requirements
> before the final object file things fail and if we ask for it after
> things work. For instance if we ask for the libraries before:
> 
> gcc  -lncursesw -o
> 	kconf/mconf
> 	kconf/mconf.o
> 	kconf/zconf.tab.o
> 	kconf/lxdialog/checklist.o
> 	kconf/lxdialog/util.o
> 	kconf/lxdialog/inputbox.o
> 	kconf/lxdialog/textbox.o
> 	kconf/lxdialog/yesno.o
> 	kconf/lxdialog/menubox.o  -lncursesw
> 
> Passing the linker requirements at the end makes the gcc happy:
> 
> gcc  -o kconf/mconf
> 	kconf/mconf.o
> 	kconf/zconf.tab.o
> 	kconf/lxdialog/checklist.o
> 	kconf/lxdialog/util.o
> 	kconf/lxdialog/inputbox.o
> 	kconf/lxdialog/textbox.o
> 	kconf/lxdialog/yesno.o
> 	kconf/lxdialog/menubox.o  -lncursesw
> 
> It seems that using -Wl,--no-as-needed does not do what we wish with regards
> to the above requirements, this could be a bug but the kernel treats things
> a bit differently so we need to adopt, fix this by being explicit by
> using -Wl,--add-needed and letting it figure things out automagically.
> 
> This has been tested on Debian and OpenSUSE factory.

I have no idea what's going on, but it works for me here. I don't
remember which distro originally wanted this differently, but hey ...
this at least doesn't unconditionally try to link something that's not
there.

johannes

