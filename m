MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1347344964-4120-1-git-send-email-bkamatch@qca.qualcomm.com>
References: <1347344964-4120-1-git-send-email-bkamatch@qca.qualcomm.com>
Date: Thu, 13 Sep 2012 12:09:27 -0700
Message-ID: <CAB=NE6UJOgP03t+eN_EDM+92JejAFfsqDdhF+2DD_FpD7M5JZg@mail.gmail.com>
Subject: Re: [PATCH] compat-drivers: Use GIT_TREE variable.
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: Bala Shanmugam <bkamatch@qca.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Mon, Sep 10, 2012 at 11:29 PM, Bala Shanmugam
<bkamatch@qca.qualcomm.com> wrote:
> In gen-stable-release.sh stable git tree path is hardcoded.
> Use GIT_TREE environment variable if specified.
>
> Signed-off-by: Bala Shanmugam <bkamatch@qca.qualcomm.com>

Thanks, applied and pushed! In the future please subscribe and use the
new dedicated mailing list for the project: backports@vger.kernel.org.
For more details:

https://backports.wiki.kernel.org/

  Luis
