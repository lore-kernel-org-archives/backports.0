MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <0891E9AFF5C074489DA21F93F868F98787CCCB2C9B@colorado>
References: <CAB=NE6UVcok33umedje3AuqJNK51QTMFeVjeZxr7jvEosLi==g@mail.gmail.com>
	<0891E9AFF5C074489DA21F93F868F98787CCCB2C9B@colorado>
Date: Fri, 1 Mar 2013 11:27:46 -0800
Message-ID: <CAB=NE6VuvHbYnjR7KyEwo56CkfsHrbwetoz9+0sapnx9cPefMw@mail.gmail.com>
Subject: Re: QCA alx Ethernet driver
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Gorlevich Vladislav <Vladislav.Gorlevich@renlife.com>, Andy Gospodarek <andy@greyhouse.net>
Cc: "unified-drivers@lists.infradead.org" <unified-drivers@lists.infradead.org>, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Thu, Feb 28, 2013 at 8:03 PM, Gorlevich Vladislav
<Vladislav.Gorlevich@renlife.com> wrote:
> Error still remains:
>
> make
> ./scripts/gen-compat-autoconf.sh /root/compat-drivers-2013-02-27-u/.confi=
g /root/compat-drivers-2013-02-27-u/config.mk > include/linux/compat_autoco=
nf.h
> make -C /lib/modules/2.6.32-300.39.4.el5uek/build M=3D/root/compat-driver=
s-2013-02-27-u modules

2.6.32-300.39.4.el5uek seems to be a kernel part of Oracle Linux 5.
That is, it is not a vanilla Linux kernel and we only test building
compat-drivers on vanilla kernels. If a Linux distribution chooses to
muck with their own old kernel then support for that kernel can be
added but it must be done as was done for SUSE and RHEL.

That is, if you want to support Oracle Linux 5 you will have to add
support yourself or get someone at Oracle to jump in and contribute
just as was done for SUSE and RHEL.

> make[1]: Entering directory `/usr/src/kernels/2.6.32-300.39.4.el5uek'
>   CC [M]  /root/compat-drivers-2013-02-27-u/compat/main.o
> In file included from /root/compat-drivers-2013-02-27-u/include/linux/com=
pat-2.6.h:58,
>                  from <command line>:1:
> /root/compat-drivers-2013-02-27-u/include/linux/compat-2.6.35.h:49: error=
: conflicting types for =D0=B2netif_set_real_num_tx_queues=D0=B2
> include/linux/netdevice.h:1572: error: previous declaration of =D0=B2neti=
f_set_real_num_tx_queues=D0=B2 was here
> make[3]: *** [/root/compat-drivers-2013-02-27-u/compat/main.o] Error 1
> make[2]: *** [/root/compat-drivers-2013-02-27-u/compat] Error 2
> make[1]: *** [_module_/root/compat-drivers-2013-02-27-u] Error 2
> make[1]: Leaving directory `/usr/src/kernels/2.6.32-300.39.4.el5uek'
> make: *** [modules] Error 2

That should be easy to fix but again, I personally only support
testing against vanilla kernels.

  Luis

> Regards, Vlad Gorlevich
>
> ________________________________________
> =D0=9E=D1=82: unified-drivers [unified-drivers-bounces@lists.infradead.or=
g] =D0=BE=D1=82 =D0=B8=D0=BC=D0=B5=D0=BD=D0=B8 Luis R. Rodriguez [mcgrof@do=
-not-panic.com]
> =D0=9E=D1=82=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=BE: 01 =D0=BC=
=D0=B0=D1=80=D1=82=D0=B0 2013 =D0=B3. 2:30
> =D0=9A=D0=BE=D0=BC=D1=83: unified-drivers@lists.infradead.org
> =D0=A2=D0=B5=D0=BC=D0=B0: QCA alx Ethernet driver
>
> The QCA alx Ethernet driver is the first driver being attempted to be
> unified under a new scheme intended to address driver considerations
> for both FreeBSD and Linux. The git tree for development for this
> driver can be found here:
>
> git://github.com/erikarn/alx.git
>
> The latest release you should be using to test the driver is available at=
:
>
> http://www.kernel.org/pub/linux/kernel/projects/backports/2013/02/27/comp=
at-drivers-2013-02-27-u.tar.bz2
>
> Please post patches for alx addressed to:
>
> adrian@freebsd.org, mcgrof@kernel.org
>
> And please always Cc this mailing list given the broad interest of
> consumers and developers. If you have anyone interested in helping
> review the strategy please be sure to ask them to subscribe.
>
>   Luis
>
> _______________________________________________
> unified-drivers mailing list
> unified-drivers@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/unified-drivers
