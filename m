MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1344970789-13047-1-git-send-email-andy@greyhouse.net>
References: <1344970789-13047-1-git-send-email-andy@greyhouse.net>
Date: Tue, 14 Aug 2012 16:09:47 -0700
Message-ID: <CAB=NE6XfHv3fLqO5agVrm0FBM-_YxM9yaXDWMV_YwOgh-KQLoQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] compat: additional patches needed for RHEL6.3 support
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
To: Andy Gospodarek <andy@greyhouse.net>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Tue, Aug 14, 2012 at 11:59 AM, Andy Gospodarek <andy@greyhouse.net> wrote:
> The following patches should round out support for RHEL6.3 for compat.
>
> After applying the patches I ran ckmake and get the following results.
>
> Trying kernel 3.5.0-030500-generic [OK]
> Trying kernel 3.4.4-030404-generic [OK]
> Trying kernel 3.3.7-030307-generic [OK]
> Trying kernel 3.2.2-030202-generic [OK]
> Trying kernel 3.1.10-030110-generic [OK]
> Trying kernel 3.0.18-030018-generic [OK]
> Trying kernel 2.6.39-02063904-generic [OK]
> Trying kernel 2.6.38-02063808-generic [OK]
> Trying kernel 2.6.37-02063706-generic [OK]
> Trying kernel 2.6.36-02063604-generic [OK]
> Trying kernel 2.6.35-02063512-generic [OK]
> Trying kernel 2.6.34-02063410-generic [OK]
> Trying kernel 2.6.33-02063305-generic [OK]
> Trying kernel 2.6.32-02063255-generic [OK]
> Trying kernel 2.6.31-02063113-generic [OK]
> Trying kernel 2.6.30-02063010-generic [OK]
> Trying kernel 2.6.29-02062906-generic [OK]
> Trying kernel 2.6.28-02062810-generic [OK]
> Trying kernel 2.6.27-020627-generic [OK]
> Trying kernel 2.6.26-020626-generic [OK]
> Trying kernel 2.6.25-020625-generic [OK]
> Trying kernel 2.6.24-020624-generic [OK]
>
> Andy Gospodarek (5):
>   compat: RHEL build script fixup from upstream
>   compat: fix defines for RHEL by adding RHEL to string
>   compat: disable KFIFO on RHEL6.1 and later
>   compat: disable compat firmware module on RHEL6.0 and later
>   compat: fixup firmware defines on RHEL6
>
>  include/linux/compat-2.6.33.h |    2 ++
>  scripts/gen-compat-config.sh  |   14 +++++++++-----
>  2 files changed, 11 insertions(+), 5 deletions(-)

These look great, I've applied them all thanks!

 Luis
