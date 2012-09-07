MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <1346960995-13363-2-git-send-email-ozancag@gmail.com>
References: <1346960995-13363-1-git-send-email-ozancag@gmail.com>
	<1346960995-13363-2-git-send-email-ozancag@gmail.com>
Date: Thu, 6 Sep 2012 17:33:24 -0700
Message-ID: <CAB=NE6XDuXvn2RHeJPpce36Tp8Fqc+Ry3uXik2nenDguvGcOoQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] compat-drivers: Update 53-pr_fmt.patch
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Cc: mcgrof@kernel.org, backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Thu, Sep 6, 2012 at 12:49 PM, Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com=
> wrote:
> Fix ath5k/debug.c redefinition warning for pr_fmt macro
>
> Signed-off-by: Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com>
> ---

Thanks, applied and pushed. With this and a typo fix from my previous
atomic patch we now get compilation back on track:

mcgrof@garbanzo ~/devel/compat-drivers (git::master)$ time ckmake
Trying kernel 3.5.0-030500-generic [OK]
Trying kernel 3.4.4-030404-generic [OK]
Trying kernel 3.3.7-030307-generic [OK]
Trying kernel 3.2.2-030202-generic [OK]
Trying kernel 3.1.10-030110-generic [OK]
Trying kernel 3.0.18-030018-generic [OK]
Trying kernel 2.6.39-02063904-generic [OK]
Trying kernel 2.6.38-02063808-generic [OK]
Trying kernel 2.6.37-02063706-generic [OK]
Trying kernel 2.6.36-02063604-generic [OK]
Trying kernel 2.6.35-02063512-generic [OK]
Trying kernel 2.6.34-02063410-generic [OK]
Trying kernel 2.6.33-02063305-generic [OK]
Trying kernel 2.6.32-02063255-generic [OK]
Trying kernel 2.6.31-02063113-generic [OK]
Trying kernel 2.6.30-02063010-generic [OK]
Trying kernel 2.6.29-02062906-generic [OK]
Trying kernel 2.6.28-02062810-generic [OK]
Trying kernel 2.6.27-020627-generic [OK]
Trying kernel 2.6.26-020626-generic [OK]
Trying kernel 2.6.25-020625-generic [OK]
Trying kernel 2.6.24-020624-generic [OK]

real    27m16.075s
user    143m0.604s
sys     13m36.899s


  Luis
