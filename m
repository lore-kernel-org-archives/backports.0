MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1356174253-2192-3-git-send-email-ozancag@gmail.com>
References: <1356174253-2192-1-git-send-email-ozancag@gmail.com>
	<1356174253-2192-3-git-send-email-ozancag@gmail.com>
Date: Fri, 28 Dec 2012 07:36:46 -0800
Message-ID: <CAB=NE6WFfJBjC0j0Jj4s6KrgHdFdQwzRdz7b51QzEiqOMUT46A@mail.gmail.com>
Subject: Re: [PATCH 3/3] update-initramfs: Add support for Fedora
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Cc: backports@vger.kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Sat, Dec 22, 2012 at 3:04 AM, Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com=
> wrote:
> Fedora doesn't ship lsb_release anymore. So try to read /etc/os-release
> to find whether distribution is Fedora.

Interesting..

> If Fedora is found, generate a new initramfs suffixed with -compat-driver=
s
> to not override the distribution kernel's default one. Also add a new
> kernel entry to grub2 configuration without overriding the default boot
> entry.
>
> Signed-off-by: Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com>

Thanks! Applied and pushed all!

  Luis
