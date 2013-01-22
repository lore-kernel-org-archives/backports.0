MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <CAFub=KQKg6wJrOEEzdhuVFr-aPbmqtdKBkRedxbNYi-B_WDdcg@mail.gmail.com>
References: <CAFub=KTufrSp75puA+3UoXXY6ONKJ8okZjvw2TmChXW_MGgjvw@mail.gmail.com>
	<CAB=NE6VUBQO-dtfoKzffCgpEW0G61k9PVb23AXFWaRArdCnOqg@mail.gmail.com>
	<CAFub=KQgkApMGBZi6b_pa20DNdjeC6TN6O_4nJM1GrUfSj45Wg@mail.gmail.com>
	<CAB=NE6WutFyazf55WQG4-v=9su6VoR_1_Nh8qF4xyUYs1kFbEw@mail.gmail.com>
	<CAB=NE6WeJHUpu3uf1nM7yjZn88iiYcDCrx-FHyrBPMGfPJWQOw@mail.gmail.com>
	<CAFub=KQKg6wJrOEEzdhuVFr-aPbmqtdKBkRedxbNYi-B_WDdcg@mail.gmail.com>
Date: Mon, 21 Jan 2013 17:15:53 -0800
Message-ID: <CAB=NE6USt7hRZu4dv7F4CPQ_22cwvp7V0nMYTsx2AiuXBnNUhg@mail.gmail.com>
Subject: Re: ckmake in Python
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Tue, Jan 8, 2013 at 2:27 AM, Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com>=
 wrote:
> On Sat, Dec 29, 2012 at 1:10 AM, Luis R. Rodriguez <mcgrof@frijolero.org>=
 wrote:
>> On Fri, Dec 28, 2012 at 2:49 PM, Luis R. Rodriguez <mcgrof@frijolero.org=
> wrote:
>>> On Fri, Dec 28, 2012 at 1:47 PM, Ozan =C3=87a=C4=9Flayan <ozancag@gmail=
.com> wrote:
>>>> Ah, So what was the point of using curses?
>>>
>>> Multithreading.
>>
>> Rather python --> multithreading. The fact that ncurses was used is
>> more of a wish to display live results from multithreaded processes
>> running in the background.
>
> Okay. This really doesn't work on Fedora :) When I start ckmake,
> nothing happens.

Nothing should happen unless a compilation completes for a kernel.

> ckmake process runs, load average jumps to 15-20~,
> ckmake hogs the cpu by %200 but building never finishes, even worse
> last night there wasn't even any forked make process at all. I had to
> stop it using CTRL+Z and then kill it after 20 minutes of waiting.

Hm odd, I just tested this on a Fedora 16 box and it worked without
even adding any new packages. I tested this by trying to run ckmake
only against compat.git, not compat-drivers. I'll try it now with
compat-drivers on the Fedora box to see if I see something similar.

> Also now I have a .tmp.ckmake folder in compat/ that I can't delete (I
> cut 'rm -rf' after some 20 minutes, too. Maybe this should sit and
> wait there for further compilations? I don't know)

Indeed, so it uses that directory to store compies of entire source
code of the current git *for each kernel* that it wants to test on. We
do this given that we cannot share the same directory for output
binary for different kernels when they are all running in parallel.

If we hit CTRL the signal handler should remove that directory. The
directory should also be nuked when it completes.

> [root@localhost .tmp.ckmake]# ll
> total 40
> drwxr-xr-x 6 root root 4096 Jan  7 18:56 2.6.24
> drwxr-xr-x 6 root root 4096 Jan  7 18:56 2.6.27
> drwxr-xr-x 3 root root 4096 Jan  8 12:17 2.6.28
> drwxr-xr-x 6 root root 4096 Jan  7 18:56 2.6.30
> drwxr-xr-x 6 root root 4096 Jan  7 18:56 2.6.31
> drwxr-xr-x 6 root root 4096 Jan  7 18:56 2.6.33
> drwxr-xr-x 6 root root 4096 Jan  7 18:56 2.6.35
> drwxr-xr-x 6 root root 4096 Jan  7 18:56 2.6.36
> drwxr-xr-x 6 root root 4096 Jan  7 18:56 3.1.10
> drwxr-xr-x 6 root root 4096 Jan  7 18:56 3.2.33
>
> Anyway I started to think about reviving ckmake.sh and keeping this
> python-based one as experimental or development stuff. What do you
> think about?

Sure.

> Or how should I debug this to understand why things
> stall?

Can you try ckmake just against compat.git ? Or perhaps get me access
to the box:

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeF/MMg+KqfzBfy+undzW4XCP8vJedmMO3/q5=
ypNz9P+825coqOfqVIJclO2/gPgYWwCP9oif7hVj9ASduaxQCQ1Cbqk7IU64MhdEKmsV77Z3f7+=
GC0jwr7L5iF45DvD+XBO5ZC0EFZJbd45Fh7iW2/IBde7QWu1DtzjTu3PCeavSJ3MtV129qicSPX=
SgWbEOZXngL8WrnQ5n7rbZ4lfJPag13SSoewhU582GTuroIe4f9g/4J6RpoKvR/Ck6wMwRt3evQ=
x/yet+BaqlydJoAB/3H8FR9Y0qoGHGG32493Flb8MBROjutcvRx0mdqgZL1QJWdwfRjKcSbWe9a=
Id699
mcgrof@frijol

  Luis
