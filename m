MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1345192004-8563-1-git-send-email-ozancag@gmail.com>
References: <1345192004-8563-1-git-send-email-ozancag@gmail.com>
Date: Mon, 20 Aug 2012 10:57:59 +0500
Message-ID: <CAB=NE6VserT5ODLUtYYEB6ps1jU5oLeoHx6Pbs4RN+K-gf7zww@mail.gmail.com>
Subject: Re: [PATCH 1/2] compat-drivers: Move around patches and selectively
 apply them
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Cc: backports@vger.kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Fri, Aug 17, 2012 at 12:26 PM, Ozan =C3=87a=C4=9Flayan <ozancag@gmail.co=
m> wrote:
> Put wlan/bt/eth related patches under network/ subdirectories. Apply them
> only if the network subsystem is enabled (For now, it is enabled by defau=
lt).
>
> Create empty network/ placeholders under patch directories.
>
> Signed-off-by: Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com>
> ---
>
> The patch is too big for this mailing list. The link to the patch is:
>   http://ozancaglayan.com/files/compat/0001-compat-drivers-Move-around-pa=
tches-and-selectively-a.patch

Thanks! However the pending patches do not apply starting with:

[PATCH 1/2 v2] compat-drivers: Add ability to select drivers to fetch

Can you respin your pending set but also use git format-patch -M
option but first attach this to your $HOME/.gitconfig :

[diff]
	renamelimit=3D0

  Luis
