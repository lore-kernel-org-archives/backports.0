MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1362009219-20091-2-git-send-email-hauke@hauke-m.de>
References: <1362009219-20091-1-git-send-email-hauke@hauke-m.de>
	<1362009219-20091-2-git-send-email-hauke@hauke-m.de>
Date: Wed, 27 Feb 2013 17:10:38 -0800
Message-ID: <CAB=NE6XA_Ao02Vn-FrSzjC6emPgT2Ei7s2LP9L0Wkoidb_HR1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] compat-drivers: build driver/video/hdmi.ko
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: backports@vger.kernel.org, Adrian Chadd <adrian@freebsd.org>,
	nic-devel <nic-devel@qca.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Wed, Feb 27, 2013 at 3:53 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This module is needed by the drm driver now.
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Nice, thanks! Applied all 3 patches and pushed, also made some changes
to account for using the alx feed from Adrian's github:

https://github.com/erikarn/alx

If anyone had mine, please refer this as the alx git tree now. Kicked
out a vanilla and a -u release. Just a heads up to alx developers, the
-u release in this directory should now have the alx driver updates as
seen on adrian's tree.

http://www.kernel.org/pub/linux/kernel/projects/backports/2013/02/27/

  Luis
