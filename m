MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <63F46C2DA34879449F56E238025B3C0B54CEDB13@fe20107s.ecn.etasgroup.com>
References: <63F46C2DA34879449F56E238025B3C0B54CEDB13@fe20107s.ecn.etasgroup.com>
Date: Thu, 28 Mar 2013 11:38:47 -0700
Message-ID: <CAB=NE6VShWL_CLURZMNPacTyz44Hmj6iNLoN25PehK3V2ML5jA@mail.gmail.com>
Subject: Re: compat-drivers for older kernels
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: "Jonathan David (AA-DG/PAO-ENG1)" <David.Jonathan@etas.com>
Cc: "backports@vger.kernel.org" <backports@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Thu, Mar 28, 2013 at 10:36 AM, Jonathan David (AA-DG/PAO-ENG1)
<David.Jonathan@etas.com> wrote:
> Hi Luis,
>
> In my search for answers I came up with this link, and therefore I=E2=80=
=99m talking
> to you:
> https://github.com/mcgrof/compat-drivers/tree/master/enable-older-kernels=
.
> Feel free to point me elsewhere=E2=80=A6
>
>
>
> I clicked through to do-not-panic.com, read about compat-drivers testing,
> saw the list of 31 kernels, including 2.6.24 with OK, and I=E2=80=99m won=
dering how
> this can be.

OK means the master branch from compat and compat-drivers has been
compile tested on that vanilla upstream kernel. So compat.git would
work compiling against 2.6.24. compat-drivers.git will also compile
successfully on 2.6.24.

> I=E2=80=99m trying to build compat-drivers-3.8.1 (for ARM, but I don=E2=
=80=99t think that is
> the issue) against a 2.6.24.4 kernel.

Great.

> I started by selecting just the
> Bluetooth drivers, and see structure incompatibilities.  One example:
> drivers/bluetooth/hci_ldisc.c assumes that struct tty_struct has an ops
> field.  In 2.6.24.4 it does not.

Bluetooth is not enabled by default on the master branch for 2.6.24.
If you want to work on that, patches are welcomed.

> I=E2=80=99ve been #ifdef=E2=80=99ing my through a number of things like t=
he above, but
> thought I=E2=80=99d ask in case I=E2=80=99ve overlooked something obvious=
.

Patches welcomed for enabling drivers / subsystems on older kernels.
By default they are enabled only for certain kernels where the
maintainer decides to start supporting something. This is currently
expressed on config.mk. This will hopefully be a lot clearer now that
we have kconfig support staring.

  Luis
