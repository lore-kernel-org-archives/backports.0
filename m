Return-Path: <mcgrof+caf_=mcgrof=gmail.com@frijolero.org>
Return-Path: <ozancag@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAB=NE6WeJHUpu3uf1nM7yjZn88iiYcDCrx-FHyrBPMGfPJWQOw@mail.gmail.com>
References: <CAFub=KTufrSp75puA+3UoXXY6ONKJ8okZjvw2TmChXW_MGgjvw@mail.gmail.com>
	<CAB=NE6VUBQO-dtfoKzffCgpEW0G61k9PVb23AXFWaRArdCnOqg@mail.gmail.com>
	<CAFub=KQgkApMGBZi6b_pa20DNdjeC6TN6O_4nJM1GrUfSj45Wg@mail.gmail.com>
	<CAB=NE6WutFyazf55WQG4-v=9su6VoR_1_Nh8qF4xyUYs1kFbEw@mail.gmail.com>
	<CAB=NE6WeJHUpu3uf1nM7yjZn88iiYcDCrx-FHyrBPMGfPJWQOw@mail.gmail.com>
Date: Tue, 8 Jan 2013 12:27:58 +0200
Message-ID: <CAFub=KQKg6wJrOEEzdhuVFr-aPbmqtdKBkRedxbNYi-B_WDdcg@mail.gmail.com>
Subject: Re: ckmake in Python
From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
To: "Luis R. Rodriguez" <mcgrof@frijolero.org>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Sat, Dec 29, 2012 at 1:10 AM, Luis R. Rodriguez <mcgrof@frijolero.org> w=
rote:
> On Fri, Dec 28, 2012 at 2:49 PM, Luis R. Rodriguez <mcgrof@frijolero.org>=
 wrote:
>> On Fri, Dec 28, 2012 at 1:47 PM, Ozan =C3=87a=C4=9Flayan <ozancag@gmail.=
com> wrote:
>>> Ah, So what was the point of using curses?
>>
>> Multithreading.
>
> Rather python --> multithreading. The fact that ncurses was used is
> more of a wish to display live results from multithreaded processes
> running in the background.

Okay. This really doesn't work on Fedora :) When I start ckmake,
nothing happens. ckmake process runs, load average jumps to 15-20~,
ckmake hogs the cpu by %200 but building never finishes, even worse
last night there wasn't even any forked make process at all. I had to
stop it using CTRL+Z and then kill it after 20 minutes of waiting.

Also now I have a .tmp.ckmake folder in compat/ that I can't delete (I
cut 'rm -rf' after some 20 minutes, too. Maybe this should sit and
wait there for further compilations? I don't know)
[root@localhost .tmp.ckmake]# ll
total 40
drwxr-xr-x 6 root root 4096 Jan  7 18:56 2.6.24
drwxr-xr-x 6 root root 4096 Jan  7 18:56 2.6.27
drwxr-xr-x 3 root root 4096 Jan  8 12:17 2.6.28
drwxr-xr-x 6 root root 4096 Jan  7 18:56 2.6.30
drwxr-xr-x 6 root root 4096 Jan  7 18:56 2.6.31
drwxr-xr-x 6 root root 4096 Jan  7 18:56 2.6.33
drwxr-xr-x 6 root root 4096 Jan  7 18:56 2.6.35
drwxr-xr-x 6 root root 4096 Jan  7 18:56 2.6.36
drwxr-xr-x 6 root root 4096 Jan  7 18:56 3.1.10
drwxr-xr-x 6 root root 4096 Jan  7 18:56 3.2.33

Anyway I started to think about reviving ckmake.sh and keeping this
python-based one as experimental or development stuff. What do you
think about? Or how should I debug this to understand why things
stall?

Thanks :)
