MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <CAB=NE6USt7hRZu4dv7F4CPQ_22cwvp7V0nMYTsx2AiuXBnNUhg@mail.gmail.com>
References: <CAFub=KTufrSp75puA+3UoXXY6ONKJ8okZjvw2TmChXW_MGgjvw@mail.gmail.com>
	<CAB=NE6VUBQO-dtfoKzffCgpEW0G61k9PVb23AXFWaRArdCnOqg@mail.gmail.com>
	<CAFub=KQgkApMGBZi6b_pa20DNdjeC6TN6O_4nJM1GrUfSj45Wg@mail.gmail.com>
	<CAB=NE6WutFyazf55WQG4-v=9su6VoR_1_Nh8qF4xyUYs1kFbEw@mail.gmail.com>
	<CAB=NE6WeJHUpu3uf1nM7yjZn88iiYcDCrx-FHyrBPMGfPJWQOw@mail.gmail.com>
	<CAFub=KQKg6wJrOEEzdhuVFr-aPbmqtdKBkRedxbNYi-B_WDdcg@mail.gmail.com>
	<CAB=NE6USt7hRZu4dv7F4CPQ_22cwvp7V0nMYTsx2AiuXBnNUhg@mail.gmail.com>
Date: Mon, 21 Jan 2013 18:45:35 -0800
Message-ID: <CAB=NE6Uq1Q8KHQe_Mz077TgVETNJKsru0ZU6mYhFpA8V55-e3g@mail.gmail.com>
Subject: Re: ckmake in Python
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Mon, Jan 21, 2013 at 5:15 PM, Luis R. Rodriguez <mcgrof@frijolero.org> wrote:
> If we hit CTRL the signal handler should remove that directory. The
> directory should also be nuked when it completes.

Another thing you could do to debug is to tail -f the log file for each kernel:

tail -f .tmp.ckmake/2.6.24/ckmake.n.log

If that doesn't ever move you know something is going wrong. On a slow
box this might happen but the only reason why I suspect this might
happen on a slow box is the heuristics for the number of job processes
running at the same time to do compilation is too high. Right now use
use make -j $NUM_CPUS and this is computed by cpu_info_build_jobs() on
ckmake.

  Luis
