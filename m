MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1350907079-31735-1-git-send-email-ozancag@gmail.com>
References: <1350907079-31735-1-git-send-email-ozancag@gmail.com>
Date: Wed, 24 Oct 2012 08:13:53 -0700
Message-ID: <CAB=NE6Ugv4h5sye0jWyPVnb94m90cK9B6a_XB1XaT6CwNKopPg@mail.gmail.com>
Subject: Re: [PATCH] compat-drivers: Enable CONFIG_DRM_LOAD_EDID_FIRMWARE
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Cc: backports@vger.kernel.org, mcgrof@kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Mon, Oct 22, 2012 at 4:57 AM, Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com=
> wrote:
> This was added in 3.4. Rename the option in the relevant source file
> and enable CONFIG_COMPAT_DRM_LOAD_EDID_FIRMWARE in config.mk to build
> the symbol into DRM_KMS_HELPER kernel module.
>
> Signed-off-by: Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com>

Applied both and pushed, thanks!

  Luis
