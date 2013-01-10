MIME-Version: 1.0
In-Reply-To: <1357749263-4596-5-git-send-email-hauke@hauke-m.de>
References: <1357749263-4596-1-git-send-email-hauke@hauke-m.de>
	<1357749263-4596-5-git-send-email-hauke@hauke-m.de>
Date: Thu, 10 Jan 2013 14:14:55 -0800
Message-ID: <CAB=NE6WF98gFyyzJXg9==-EhrY7b45F+k3J_6OEO7xwTF7czOw@mail.gmail.com>
Subject: Re: [PATCH 5/5] compat: fix warning in usb_autopm_get_interface_no_{resume,suspend}
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Wed, Jan 9, 2013 at 8:34 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This fixes the following warning on kernel version <=3D 2.6.31.
>
> /compat/compat-2.6.33.c: In function =E2=80=98usb_autopm_get_interface_no=
_resume=E2=80=99:
> /compat/compat-2.6.33.c:32:2: warning: passing argument 1 of =E2=80=98ato=
mic_inc=E2=80=99 from incompatible pointer type [enabled by default]
> /arch/x86/include/asm/atomic_64.h:85:20: note: expected =E2=80=98struct a=
tomic_t *=E2=80=99 but argument is of type =E2=80=98int *=E2=80=99
> /compat/compat-2.6.33.c: In function =E2=80=98usb_autopm_put_interface_no=
_suspend=E2=80=99:
> /compat/compat-2.6.33.c:51:2: warning: passing argument 1 of =E2=80=98ato=
mic_dec=E2=80=99 from incompatible pointer type [enabled by default]
> /arch/x86/include/asm/atomic_64.h:98:20: note: expected =E2=80=98struct a=
tomic_t *=E2=80=99 but argument is of type =E2=80=98int *=E2=80=99
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Thanks applied all compat and compat-drivers patches and pushed!

  Luis
