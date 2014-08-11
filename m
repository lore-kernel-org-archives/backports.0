Return-path: <backports-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:53672 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034AbaHKGiV (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 11 Aug 2014 02:38:21 -0400
Message-ID: <1407739093.1718.0.camel@jlt4.sipsolutions.net> (sfid-20140811_083823_481212_C030DBDF)
Subject: Re: [PATCH] backports: fix mconf compilation on OpenSUSE factory
From: Johannes Berg <johannes@sipsolutions.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Cc: hauke@hauke-m.de, backports@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>
Date: Mon, 11 Aug 2014 08:38:13 +0200
In-Reply-To: <1407597803-11371-1-git-send-email-mcgrof@do-not-panic.com> (sfid-20140809_172333_446755_55AB6E1D)
References: <1407597803-11371-1-git-send-email-mcgrof@do-not-panic.com>
	 (sfid-20140809_172333_446755_55AB6E1D)
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Sat, 2014-08-09 at 08:23 -0700, Luis R. Rodriguez wrote:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
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
> This is fixed by linking with -ltinfo. I've test builded this on
> Debian and OpenSUSE factory.

I have a vague feeling that we used to have this and it broke somewhere
else, and it was supposed to get added via check-lxdialog.sh...

Please look in the list archives for this, I'm not convinced this is
right.

johannes

