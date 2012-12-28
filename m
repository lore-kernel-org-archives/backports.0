MIME-Version: 1.0
Sender: mcgrof@gmail.com
In-Reply-To: <CAFub=KTufrSp75puA+3UoXXY6ONKJ8okZjvw2TmChXW_MGgjvw@mail.gmail.com>
References: <CAFub=KTufrSp75puA+3UoXXY6ONKJ8okZjvw2TmChXW_MGgjvw@mail.gmail.com>
Date: Fri, 28 Dec 2012 07:32:43 -0800
Message-ID: <CAB=NE6VUBQO-dtfoKzffCgpEW0G61k9PVb23AXFWaRArdCnOqg@mail.gmail.com>
Subject: Re: ckmake in Python
From: "Luis R. Rodriguez" <mcgrof@frijolero.org>
To: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>
Cc: backports@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <backports@vger.kernel.org>

On Sat, Dec 22, 2012 at 3:21 AM, Ozan =C3=87a=C4=9Flayan <ozancag@gmail.com=
> wrote:
> Hi,
>
> The latest ckmake rewritten in Python doesn't work on Fedora 18
> probably because of curses.
> The list of kernels is shown but I can't go up/down or select
> something. I have to hit CTRL^Z and kill
> ckmake in order to get rid of it. The situation is the same in both
> gnome-terminal and a real tty.

It doesn't support letting you select the kernels via the boxes, but
that would certainly be a welcomed change. Right now when you run it,
it will actually kick off compilation across all kernels and you will
see a status update for each one as each kernel job thread finishes.
Hitting CTRL-C is handled on the program through a signal handler and
its supposed to clean things but for some reason its not doing that or
its taking a while.

  Luis
