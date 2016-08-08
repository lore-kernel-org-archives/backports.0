Return-path: <backports-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:58673 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751158AbcHHHwH (ORCPT <rfc822;backports@vger.kernel.org>);
	Mon, 8 Aug 2016 03:52:07 -0400
MIME-Version: 1.0
Message-ID: <trinity-50e3397a-cfd4-4f35-ab8b-51700c2a6cf6-1470642723593@3capp-gmx-bs12> (sfid-20160808_095211_106940_206ADB6E)
From: "Peter Huewe" <PeterHuewe@gmx.de>
To: backports@vger.kernel.org
Subject: gentree fails at no such file compat/crypto-skcipher.c
Content-Type: text/plain; charset=UTF-8
Date: Mon, 8 Aug 2016 09:52:03 +0200
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

Hi,

I'm currently looking into the backports project to figure out how hard it would be to add the tpm drivers.
However unfortunately the gentree.py script fails, and I cannot really explain why:

./gentree.py --clean --git-revision v4.0 /home/peter/linux-next/ /home/peter/linux-4.0-backport
Get original source files from git ...
Traceback (most recent call last):
  File "./gentree.py", line 1091, in <module>
    ret = _main()
  File "./gentree.py", line 724, in _main
    logwrite=logwrite)
  File "./gentree.py", line 862, in process
    disable_list = add_automatic_backports(args)
  File "./gentree.py", line 276, in add_automatic_backports
    automatic_backport_mangle_c_file(f)), 'r'):
IOError: [Errno 2] No such file or directory: '/home/peter/linux-4.0-backport/compat/crypto-skcipher.c'


The full log:

peter@big:~/backports$ git pull
Already up-to-date.
peter@big:~/backports$ git pull -v
Von git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports
 = [aktuell]         master     -> origin/master
 = [aktuell]         linux-3.10.y -> origin/linux-3.10.y
 = [aktuell]         linux-3.11.y -> origin/linux-3.11.y
 = [aktuell]         linux-3.12.y -> origin/linux-3.12.y
 = [aktuell]         linux-3.13.y -> origin/linux-3.13.y
 = [aktuell]         linux-3.14.y -> origin/linux-3.14.y
 = [aktuell]         linux-3.15.y -> origin/linux-3.15.y
 = [aktuell]         linux-3.16.y -> origin/linux-3.16.y
 = [aktuell]         linux-3.17.y -> origin/linux-3.17.y
 = [aktuell]         linux-3.18.y -> origin/linux-3.18.y
 = [aktuell]         linux-3.19.y -> origin/linux-3.19.y
 = [aktuell]         linux-4.0.y -> origin/linux-4.0.y
 = [aktuell]         linux-4.1.y -> origin/linux-4.1.y
 = [aktuell]         linux-4.2.y -> origin/linux-4.2.y
 = [aktuell]         linux-4.3.y -> origin/linux-4.3.y
 = [aktuell]         linux-4.4.y -> origin/linux-4.4.y
Already up-to-date.
peter@big:~/backports$ ./devel/
backports-update-manager  doc/                      gplizer                   
ckmake                    git-tracker.py            pycocci                   
peter@big:~/backports$ ./devel/backports-update-manager 

Linux kernel backports updater
------------------------------------------------------------------
There are two parts to the updater:

	1. Stable kernel header release updater
	2. Git tree updater

Step 1) will go first and will be immediately followed by Step 2).
A description of what will be done and what space requires are needed
are described below. Total expected available space: 6 GiB.

Stable kernel header release updater
------------------------------------------------------------------
This will download 28 kernel headers to allow you to
cross compile any module over these kernels with ckmake.
The download payload is about ~ 364 MiB, once uncompressed
it will stash kernel header files under the directories:

	/home/peter/ksrc-backports/usr/src/
	/home/peter/ksrc-backports/lib/modules/

It will consume about ~ 2 GiB of space.

The kernel headers used are from Vanilla kernelsfrom the 
Ubuntu mainline / vanilla kernel PPA and are extracted
using the GNU ar and Python tar module:

http://kernel.ubuntu.com/~kernel-ppa/mainline/


Git tree updater
------------------------------------------------------------------
This will download or update all backport related kernel git trees:

	git://git.kernel.org/pub/scm/linux/kernel/git/backports/backports.git
	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
	git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

By default we will git clone or expect each git tree to be present under:


	/home/peter/

For each git clone issused --reference will be used based on Linus'
linux.git tree to help save as much space as possible. If you do not
have the git trees cloned you will be expected to download over 1 GiB
of data and once the trees are extracted they will consume about
2-3 GiB of space.

We detected you have all git trees present, we'll just git fetch for you.

Do you still want to continue (y/N)? y

Looking for updates and downloading. You can hit CTRL-C
and come back at any time, we'll take off right where 
we left off
3.0.101 - up to date !
3.1.10 - up to date !
3.10.102 - up to date !
3.11.10 - up to date !
3.12.61 - up to date !
3.13.11 - up to date !
3.14.73 - up to date !
3.15.10 - up to date !
3.16.36 - up to date !
3.17.8 - up to date !
3.18.36 - up to date !
3.19.8 - up to date !
3.2.81 - up to date !
3.3.8 - up to date !
3.4.112 - up to date !
3.5.7 - up to date !
3.6.11 - up to date !
3.7.10 - up to date !
3.8.13 - up to date !
3.9.11 - up to date !
4.0.9 - up to date !
4.1.27 - up to date !
4.2.8 - up to date !
4.3.6 - up to date !
4.4.14 - up to date !
4.5.7 - up to date !
4.6.3 - up to date !
4.7.0 - up to date !

3.0.101 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.0.101-0300101-generic_3.0.101-0300101.201310220446_amd64.deb ...
3.0.101 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.0.101-0300101_3.0.101-0300101.201310220446_all.deb ...
3.1.10 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.1.10-030110-generic_3.1.10-030110.201201181135_amd64.deb ...
3.1.10 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.1.10-030110_3.1.10-030110.201201181135_all.deb ...
3.10.102 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.10.102-0310102-generic_3.10.102-0310102.201606131145_amd64.deb ...
3.10.102 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.10.102-0310102_3.10.102-0310102.201606131145_all.deb ...
3.11.10 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.11.10-031110-generic_3.11.10-031110.201311291453_amd64.deb ...
3.11.10 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.11.10-031110_3.11.10-031110.201311291453_all.deb ...
3.12.61 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.12.61-031261-generic_3.12.61-031261.201606201232_amd64.deb ...
3.12.61 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.12.61-031261_3.12.61-031261.201606201232_all.deb ...
3.13.11 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.13.11-031311-generic_3.13.11-031311.201404222035_amd64.deb ...
3.13.11 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.13.11-031311_3.13.11-031311.201404222035_all.deb ...
3.14.73 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.14.73-031473-generic_3.14.73-031473.201606241434_amd64.deb ...
3.14.73 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.14.73-031473_3.14.73-031473.201606241434_all.deb ...
3.15.10 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.15.10-031510-generic_3.15.10-031510.201408132333_amd64.deb ...
3.15.10 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.15.10-031510_3.15.10-031510.201408132333_all.deb ...
3.16.36 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.16.36-031636-generic_3.16.36-031636.201606152333_amd64.deb ...
3.16.36 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.16.36-031636_3.16.36-031636.201606152333_all.deb ...
3.17.8 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.17.8-031708-generic_3.17.8-031708.201501081837_amd64.deb ...
3.17.8 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.17.8-031708_3.17.8-031708.201501081837_all.deb ...
3.18.36 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.18.36-031836-generic_3.18.36-031836.201606230133_amd64.deb ...
3.18.36 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.18.36-031836_3.18.36-031836.201606230133_all.deb ...
3.19.8 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.19.8-031908-generic_3.19.8-031908.201505110938_amd64.deb ...
3.19.8 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.19.8-031908_3.19.8-031908.201505110938_all.deb ...
3.2.81 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.2.81-030281-generic_3.2.81-030281.201606152334_amd64.deb ...
3.2.81 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.2.81-030281_3.2.81-030281.201606152334_all.deb ...
3.3.8 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.3.8-030308-generic_3.3.8-030308.201206041356_amd64.deb ...
3.3.8 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.3.8-030308_3.3.8-030308.201206041356_all.deb ...
3.4.112 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.4.112-0304112-generic_3.4.112-0304112.201604271231_amd64.deb ...
3.4.112 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.4.112-0304112_3.4.112-0304112.201604271231_all.deb ...
3.5.7 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.5.7-03050712-generic_3.5.7-03050712.201305111435_amd64.deb ...
3.5.7 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.5.7-03050712_3.5.7-03050712.201305111435_all.deb ...
3.6.11 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.6.11-030611-generic_3.6.11-030611.201212171335_amd64.deb ...
3.6.11 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.6.11-030611_3.6.11-030611.201212171335_all.deb ...
3.7.10 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.7.10-030710-generic_3.7.10-030710.201302271235_amd64.deb ...
3.7.10 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.7.10-030710_3.7.10-030710.201302271235_all.deb ...
3.8.13 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.8.13-030813-generic_3.8.13-030813.201305111843_amd64.deb ...
3.8.13 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.8.13-030813_3.8.13-030813.201305111843_all.deb ...
3.9.11 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.9.11-030911-generic_3.9.11-030911.201307202035_amd64.deb ...
3.9.11 - already installed /home/peter/ksrc-backports/debs/linux-headers-3.9.11-030911_3.9.11-030911.201307202035_all.deb ...
4.0.9 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.0.9-040009-generic_4.0.9-040009.201507212131_amd64.deb ...
4.0.9 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.0.9-040009_4.0.9-040009.201507212131_all.deb ...
4.1.27 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.1.27-040127-generic_4.1.27-040127.201606230134_amd64.deb ...
4.1.27 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.1.27-040127_4.1.27-040127.201606230134_all.deb ...
4.2.8 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.2.8-040208-generic_4.2.8-040208.201512150620_amd64.deb ...
4.2.8 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.2.8-040208_4.2.8-040208.201512150620_all.deb ...
4.3.6 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.3.6-040306-generic_4.3.6-040306.201602191831_amd64.deb ...
4.3.6 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.3.6-040306_4.3.6-040306.201602191831_all.deb ...
4.4.14 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.4.14-040414-generic_4.4.14-040414.201606241434_amd64.deb ...
4.4.14 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.4.14-040414_4.4.14-040414.201606241434_all.deb ...
4.5.7 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.5.7-040507-generic_4.5.7-040507.201606100436_amd64.deb ...
4.5.7 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.5.7-040507_4.5.7-040507.201606100436_all.deb ...
4.6.3 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.6.3-040603-generic_4.6.3-040603.201606241434_amd64.deb ...
4.6.3 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.6.3-040603_4.6.3-040603.201606241434_all.deb ...
4.7.0 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.7.0-040700rc6-generic_4.7.0-040700rc6.201607040332_amd64.deb ...
4.7.0 - already installed /home/peter/ksrc-backports/debs/linux-headers-4.7.0-040700rc6_4.7.0-040700rc6.201607040332_all.deb ...
Updating tree /home/peter/linux
Updating tree /home/peter/backports
Updating tree /home/peter/linux-stable
Updating tree /home/peter/linux-next
peter@big:~/backports$ ./gentree.py --clean --git-revision v4.0 /home/peter/linux-next/ /home/peter/linux-4.0-backport
Get original source files from git ...
Traceback (most recent call last):
  File "./gentree.py", line 1091, in <module>
    ret = _main()
  File "./gentree.py", line 724, in _main
    logwrite=logwrite)
  File "./gentree.py", line 862, in process
    disable_list = add_automatic_backports(args)
  File "./gentree.py", line 276, in add_automatic_backports
    automatic_backport_mangle_c_file(f)), 'r'):
IOError: [Errno 2] No such file or directory: '/home/peter/linux-4.0-backport/compat/crypto-skcipher.c'
peter@big:~/backports$ 





What did I do wrong?
python --version
Python 2.7.10

cat /etc/lsb-release 
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=15.10
DISTRIB_CODENAME=wily
DISTRIB_DESCRIPTION="Ubuntu 15.10"

uname -a
Linux biglamer 4.7.0+ #23 SMP Sun Aug 7 21:29:59 PDT 2016 x86_64 x86_64 x86_64 GNU/Linux

git --version
git version 2.5.0

spatch  --version
spatch version 1.0.0 with Python support and with PCRE support



Thanks,
Peter

--
To unsubscribe from this list: send the line "unsubscribe backports" in
