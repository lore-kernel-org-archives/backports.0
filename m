Return-path: <backports-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:51139 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706AbaDLD2M (ORCPT
	<rfc822;backports@vger.kernel.org>); Fri, 11 Apr 2014 23:28:12 -0400
Received: by mail-lb0-f180.google.com with SMTP id 10so4046526lbg.39
        for <backports@vger.kernel.org>; Fri, 11 Apr 2014 20:28:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB=NE6XbzG-AURbRnXpPLFi7+C0pOJLJOUmZAMWb9LupUa4-Ww@mail.gmail.com>
References: <1397266475-14442-1-git-send-email-mcgrof@do-not-panic.com>
 <1397266475-14442-9-git-send-email-mcgrof@do-not-panic.com> <CAB=NE6XbzG-AURbRnXpPLFi7+C0pOJLJOUmZAMWb9LupUa4-Ww@mail.gmail.com>
From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 11 Apr 2014 20:27:50 -0700
Message-ID: <CAB=NE6XnF5Ya1dAm7ZB+hKgOJdB_zn3HL96y6WU+tCqV9Yi6Sg@mail.gmail.com> (sfid-20140412_052814_667245_3264FE2E)
Subject: Re: [PATCH 08/10] backports: bump bluetooth reqs to 3.2
To: "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Content-Type: text/plain; charset=UTF-8
Sender: backports-owner@vger.kernel.org
List-ID: <backports@vger.kernel.org>

On Fri, Apr 11, 2014 at 6:41 PM, Luis R. Rodriguez
<mcgrof@do-not-panic.com> wrote:
> On Fri, Apr 11, 2014 at 6:34 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
>> As a prep to bump general requirements lets bump bluetooth
>> minimum kernel requirements to at least 3.2.
>
> Ignore this, it gets on 3.0 as the minimum requirements as I later
> removed this line, and that means it default to the oldest supported
> kernel, which is 3.0 now.

As expected removing this patch yields no issues:

1   3.0.101             [  OK  ]
2   3.1.10              [  OK  ]
3   3.2.54              [  OK  ]
4   3.3.8               [  OK  ]
5   3.4.79              [  OK  ]
6   3.5.7               [  OK  ]
7   3.6.11              [  OK  ]
8   3.7.10              [  OK  ]
9   3.8.13              [  OK  ]
10  3.9.11              [  OK  ]
11  3.10.29             [  OK  ]
12  3.11.10             [  OK  ]
13  3.12.10             [  OK  ]
14  3.13.2              [  OK  ]
15  3.14-rc1            [  OK  ]

real    28m19.343s
user    785m0.188s
sys     86m24.716s


  Luis
