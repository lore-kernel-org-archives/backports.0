Return-Path: <ozancag@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1354202681-11787-6-git-send-email-hauke@hauke-m.de>
References: <1354202681-11787-1-git-send-email-hauke@hauke-m.de>
	<1354202681-11787-6-git-send-email-hauke@hauke-m.de>
Date: Fri, 30 Nov 2012 09:58:57 +0200
Message-ID: <CAFub=KRsvwuXYa8EtMpm7hLgW+hgahP5mUhN2UWFBvxhBXXMeA@mail.gmail.com>
Subject: Re: [PATCH 5/5] compat-drivers: do not apply patches in natural sort order
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: mcgrof@gmail.com, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Thu, Nov 29, 2012 at 5:24 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> Without this patch the patches are applied in the natural sort order of
> numbers, which caused this order for patches/network/:
> patches/network/0001-netdev_ops.patch
> patches/network/02-ksize.patch
> patches/network/0002-net-misc.patch
> patches/network/0003-netdev-needed_headroom_tailroom.patch
> patches/network/03-rfkill.patch
> patches/network/04-netns.patch
> patches/network/0004-wext-namespace.patch
> patches/network/0005-netlink-portid.patch
> patches/network/05-usb.patch

Actually it was me who changed/broke this and I really can't decide
now which one is more intuitive.

commit 46a5aef05b92a2162150326f426bebe3541d6e8c
Author: Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com>
Date:   Fri Jun 22 16:30:54 2012 +0300

    compat-wireless: Naturally sort patch prefixes

    Use ls -v to get a naturally sorted list of patches like:

    patches/00-vga_switcheroo_client_ops.patch
    patches/01-dma_buf_ops-addition.patch
    patches/02-revert-vm_mmap.patch
    patches/98-pr_fmt.patch
    patches/99-change-makefile.patch
    patches/9999-FIXME-dont-build-i915-for-i2c-problems.patch

    instead of:

    patches/00-vga_switcheroo_client_ops.patch
    patches/01-dma_buf_ops-addition.patch
    patches/02-revert-vm_mmap.patch
    patches/98-pr_fmt.patch
    patches/9999-FIXME-dont-build-i915-for-i2c-problems.patch
    patches/99-change-makefile.patch

    Signed-off-by: Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com>
    Signed-off-by: Luis R. Rodriguez <mcgrof@frijolero.org>


--=20
Ozan =C3=87a=C4=9Flayan
Research Assistant
Galatasaray University - Computer Engineering Dept.
http://www.ozancaglayan.com
